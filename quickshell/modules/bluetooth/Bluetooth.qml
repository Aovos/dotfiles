import QtQuick
import Quickshell
import Quickshell.Io

Text {
    id: root

    property bool powered: false
    property bool connected: false

    text: {
        if (!powered)
            return "󰂲"

        if (connected)
            return ""

        return ""
    }

    color: {
        if (!powered)
            return "#666666"

        if (connected)
            return "#4fc3f7"

        return "#e0e0e0"
    }

    font.pixelSize: 16
    font.family: "JetBrainsMono Nerd Font"

    Process {
        id: bluetoothStateProc

        command: ["bluetoothctl", "show"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text

                root.powered =
                    output.indexOf("Powered: yes") !== -1
            }
        }
    }

    Process {
        id: bluetoothConnectedProc

        command: ["bluetoothctl", "devices", "Connected"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim()

                root.connected = output.length > 0
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            bluetoothStateProc.running = true
            bluetoothConnectedProc.running = true
        }
    }

    Component.onCompleted: {
        bluetoothStateProc.running = true
        bluetoothConnectedProc.running = true
    }
}
