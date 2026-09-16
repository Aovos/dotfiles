import QtQuick
import Quickshell.Hyprland

Row {
    spacing: 4

    property var workspaceIcons: [
        "󰈹", "󰇮", "", "󰉌", "󰎆",
        "󱣴", "", "", "󰈔", "󰗠"
    ]

    property int activeWorkspace: Hyprland.focusedWorkspace?.id ?? 1

    property color colorActiveBackground: "#22162f"
    property color colorActiveForeground: "#bb86fc"

    property color colorOccupiedBackground: "#353535"
    property color colorOccupiedForeground: "#e0e0e0"

    property color colorEmptyBackground: "#202020"
    property color colorEmptyForeground: "#666666"

    property color colorUrgentBackground: "#cf6679"
    property color colorUrgentForeground: "#000000"

    Repeater {
        model: workspaceIcons

        Rectangle {
            required property int index
            required property string modelData

            property var currentWorkspace:
                Hyprland.workspaces.values.find(
                    w => w.id === (index + 1)
                )

            property bool isUrgent: currentWorkspace?.urgent ?? false
            property bool hovered: false

            width: 28
            height: 28
            radius: 14

            // 1. Basis-Skalierung basierend auf Hover-Zustand
            scale: hovered ? 1.12 : 1.0
            y: hovered ? -2 : 0

            border.width: hovered ? 1 : 0
            border.color: "#bb86fc"

            // Sanfter Übergang für Hover-Effekte
            Behavior on scale {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on y {
                NumberAnimation {
                    duration: 150
                    easing.type: Easing.OutCubic
                }
            }

            Behavior on border.width {
                NumberAnimation {
                    duration: 150
                }
            }

            // 2. Saubere Pulsierung über einen transform-Scale-Node (verhindert Konflikte mit Behavior)
            transform: Scale {
                id: pulseScale
                origin.x: 14 // Hälfte der Breite (Zentriert)
                origin.y: 14 // Hälfte der Höhe (Zentriert)
                
                property real pulseValue: 1.0
                xScale: pulseValue
                yScale: pulseValue

                SequentialAnimation on pulseValue {
                    running: isUrgent
                    loops: Animation.Infinite

                    NumberAnimation {
                        from: 1.0
                        to: 1.15 // Wie stark es pulsieren soll (1.15 = +15%)
                        duration: 600
                        easing.type: Easing.InOutQuad
                    }

                    NumberAnimation {
                        from: 1.15
                        to: 1.0
                        duration: 600
                        easing.type: Easing.InOutQuad
                    }
                }
            }

            color: isUrgent
                ? colorUrgentBackground
                : hovered
                    ? ((index + 1) === activeWorkspace
                        ? Qt.lighter(colorActiveBackground, 1.3)
                        : (currentWorkspace !== undefined
                            ? Qt.lighter(colorOccupiedBackground, 1.2)
                            : Qt.lighter(colorEmptyBackground, 1.3)))
                    : ((index + 1) === activeWorkspace
                        ? colorActiveBackground
                        : (currentWorkspace !== undefined
                            ? colorOccupiedBackground
                            : colorEmptyBackground))

            Behavior on color {
                ColorAnimation {
                    duration: 150
                }
            }

            Text {
                anchors.centerIn: parent

                text: modelData

                color: isUrgent
                    ? colorUrgentForeground
                    : ((index + 1) === activeWorkspace
                        ? colorActiveForeground
                        : (currentWorkspace !== undefined
                            ? colorOccupiedForeground
                            : colorEmptyForeground))

                font.pixelSize: 14
                font.family: "JetBrainsMono Nerd Font"
            }

            MouseArea {
                anchors.fill: parent

                acceptedButtons: Qt.LeftButton
                hoverEnabled: true

                onEntered: hovered = true
                onExited: hovered = false

                onClicked: {
                    Hyprland.dispatch(
                        "hl.dsp.focus({ workspace = " + (index + 1) + " })"
                    )
                }
            }
        }
    }
}
