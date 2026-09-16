// modules/powermenu/PowerMenu.qml

import QtQuick

Item {
    id: root

    signal toggleRequested()

    width: 24
    height: 24

    Text {
        anchors.centerIn: parent

        text: ""
        color: "#e0e0e0"

        font.pixelSize: 16
        font.family: "JetBrainsMono Nerd Font"
    }

    MouseArea {
        anchors.fill: parent

        onClicked: {
            root.toggleRequested()
        }
    }
}
