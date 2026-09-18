import QtQuick
import Quickshell
import Quickshell.Io

Text {
    id: root

    property string profile: "balanced"

    text: {
        switch (profile) {
        case "performance":
            return ""

        case "power-saver":
            return ""

        default:
            return ""
        }
    }

    color: {
        switch (profile) {
        case "performance":
            return "#ff7043"

        case "power-saver":
            return "#81c784"

        default:
            return "#e0e0e0"
        }
    }

    font.pixelSize: 16
    font.family: "JetBrainsMono Nerd Font"

    Process {
        id: powerProfileProc

        command: ["powerprofilesctl", "get"]

        stdout: StdioCollector {
            onStreamFinished: {
                root.profile = this.text.trim()
            }
        }
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            powerProfileProc.running = true
        }
    }

    Component.onCompleted: {
        powerProfileProc.running = true
    }
}
