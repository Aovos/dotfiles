import QtQuick
import Quickshell
import Quickshell.Io

Text {
    id: root

    property int signalStrength: 0
    property bool connected: false
    property bool wifiEnabled: true

    text: {
        if (!wifiEnabled)
            return "󰤮"

        if (!connected)
            return "󰤯"

        if (signalStrength >= 80)
            return "󰤨"

        if (signalStrength >= 60)
            return "󰤥"

        if (signalStrength >= 40)
            return "󰤢"

        if (signalStrength >= 20)
            return "󰤟"

        return "󰤯"
    }

    color: {
        if (!wifiEnabled)
            return "#666666"

        if (!connected)
            return "#888888"

        return "#e0e0e0"
    }

    font.pixelSize: 16
    font.family: "JetBrainsMono Nerd Font"

    Process {
        id: wifiProc

        command: [
            "nmcli",
            "-t",
            "-f",
            "ACTIVE,SSID,SIGNAL",
            "dev",
            "wifi"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                let lines = text.trim().split("\n")

                root.connected = false
                root.signalStrength = 0

                for (let line of lines) {
                    if (line.startsWith("yes:")) {
                        let parts = line.split(":")

                        root.connected = true
                        root.signalStrength = parseInt(parts[2])

                        break
                    }
                }
            }
        }
    }

    Process {
        id: wifiRadioProc

        command: [
            "nmcli",
            "radio",
            "wifi"
        ]

        stdout: StdioCollector {
            onStreamFinished: {
                root.wifiEnabled =
                    text.trim().toLowerCase() === "enabled"
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            wifiProc.running = true
            wifiRadioProc.running = true
        }
    }

    Component.onCompleted: {
        wifiProc.running = true
        wifiRadioProc.running = true
    }
}
