import QtQuick
import Quickshell

PanelWindow {
    id: root
    
    focusable: true

    property bool opened: false

    visible: opened

    anchors {
        left: true
        right: true
        top: true
        bottom: true
    }

    implicitWidth: Screen.width * 0.18
    implicitHeight: Screen.height * 0.25

    color: "transparent"

    Rectangle {
        anchors.centerIn: parent

        width: root.implicitWidth
        height: root.implicitHeight

        radius: 16

        color: "#202020"

        border.width: 1
        border.color: "#7c3aed"

        Column {
            anchors.centerIn: parent

            spacing: 10

            Repeater {
                model: [
                    {
                        label: "🔒 Lock",
                        command: ["hyprlock"]
                    },
                    {
                        label: "🌙 Suspend",
                        command: ["systemctl", "suspend"]
                    },
                    {
                        label: "↻ Reboot",
                        command: ["systemctl", "reboot"]
                    },
                    {
                        label: " Shutdown",
                        command: ["systemctl", "poweroff"]
                    },
                    {
                        label: "⇦ Logout",
                        command: ["hyprctl", "dispatch", "exit"]
                    }
                ]

                delegate: Rectangle {
                    width: 220
                    height: 40

                    radius: 10

                    color: mouse.containsMouse
                           ? "#2f2f2f"
                           : "transparent"

                    border.width: mouse.containsMouse ? 1 : 0
                    border.color: "#7c3aed"

                    Behavior on color {
                        ColorAnimation {
                            duration: 120
                        }
                    }

                    Text {
                        anchors.centerIn: parent

                        text: modelData.label

                        color: "white"

                        font.pixelSize: 15
                        font.family: "JetBrainsMono Nerd Font"
                    }

                    MouseArea {
                        id: mouse

                        anchors.fill: parent

                        hoverEnabled: true

                        onClicked: {
                            Quickshell.execDetached(modelData.command)
                            root.opened = false
                        }
                    }
                }
            }
        }
    }
}
