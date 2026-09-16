import QtQuick

Rectangle {
    id: root

    default property alias content: contentItem.data

    property bool hovered: false

    width: 28
    height: 28

    radius: 14

    color: hovered
        ? "#2a2a2a"
        : "#202020"

    border.width: hovered ? 1 : 0
    border.color: "#bb86fc"

    scale: hovered ? 1.12 : 1.0
    y: hovered ? -2 : 0

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

    Behavior on color {
        ColorAnimation {
            duration: 150
        }
    }

    Item {
        id: contentItem

        anchors.centerIn: parent
    }

    MouseArea {
        anchors.fill: parent

        hoverEnabled: true

        onEntered: root.hovered = true
        onExited: root.hovered = false
    }
}
