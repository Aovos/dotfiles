import QtQuick

Rectangle {
    id: root

    default property alias content: contentItem.data

    width: 28
    height: 28

    radius: 14

    color: "#202020"

    Item {
        id: contentItem

        anchors.centerIn: parent
    }
}
