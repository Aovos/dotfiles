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

            property var currentWorkspace: Hyprland.workspaces.values.find(w => w.id === (index + 1))
            property bool isUrgent: currentWorkspace?.urgent ?? false

            width: 28
            height: 28
            radius: 14

            color: isUrgent
                ? colorUrgentBackground
                : (index + 1) === activeWorkspace 
                    ? colorActiveBackground
                    : (currentWorkspace !== undefined ? colorOccupiedBackground : colorEmptyBackground)

            Text {
                anchors.centerIn: parent
                text: modelData

                color: isUrgent
                    ? colorUrgentForeground
                    : (index + 1) === activeWorkspace 
                        ? colorActiveForeground
                        : (currentWorkspace !== undefined ? colorOccupiedForeground : colorEmptyForeground)

                font.pixelSize: 14
                font.family: "JetBrainsMono Nerd Font"
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton
                
                onClicked: {
                    Hyprland.dispatch("hl.dsp.focus({ workspace = " + (index + 1) + " })")
                }
            }
        }
    }
}

