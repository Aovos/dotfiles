import QtQuick
import Quickshell
import Quickshell.Io

Text {
    id: root

    property real volume: 0
    property bool muted: false
    property bool bluetoothDevice: false

    text: {
        if (muted)
            return ""

        if (bluetoothDevice)
            return ""

        if (volume < 0.34)
            return ""

        if (volume < 0.67)
            return ""

        return ""
    }

    color: muted
        ? "#666666"
        : "#e0e0e0"

    font.pixelSize: 16
    font.family: "JetBrainsMono Nerd Font"

    Process {
        id: volumeProc

        command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.trim()

                root.muted = output.indexOf("MUTED") !== -1

                const match = output.match(/([0-9]*\.[0-9]+)/)

                if (match)
                    root.volume = parseFloat(match[1])
            }
        }
    }

    Process {
        id: sinkProc

        command: ["wpctl", "inspect", "@DEFAULT_AUDIO_SINK@"]

        stdout: StdioCollector {
            onStreamFinished: {
                const output = text.toLowerCase()

                root.bluetoothDevice =
                    output.indexOf("bluez") !== -1
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            volumeProc.running = true
            sinkProc.running = true
        }
    }

    Component.onCompleted: {
        volumeProc.running = true
        sinkProc.running = true
    }
}
