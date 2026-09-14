import QtQuick
import QtQuick.Effects

import "../modules/clock"

Rectangle {
    id: root

    width: clockArea.width + 20
    height: 40

    radius: 20

    color: "#000000"

    border.color: "#1a1a1a"
    border.width: 1

    layer.enabled: true

    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: "#aa000000"
        shadowBlur: 1.0
        shadowVerticalOffset: 3
    }

    Rectangle {
        id: clockArea

        width: 100
        height: 30

        radius: 15

        color: "#202020"

        anchors.centerIn: parent

        Clock {
            anchors.centerIn: parent
        }
    }
}
