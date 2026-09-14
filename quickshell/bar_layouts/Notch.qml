import QtQuick
import QtQuick.Effects

Rectangle {
    id: notch

    width: timeText.implicitWidth + 40
    height: 30

    color: "#000000"
    radius: 20

    border.color: "#1a1a1a"
    border.width: 1

    layer.enabled: true

    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: "#aa000000"
        shadowBlur: 1.0
        shadowVerticalOffset: 3
    }

    Text {
        id: timeText

        anchors.centerIn: parent

        color: "#ffffff"
        font.pixelSize: 16
        font.weight: Font.DemiBold
        font.family: "Monospace"

        function updateTime() {
            text = Qt.formatTime(new Date(), "hh:mm")
        }

        Timer {
            interval: 60000
            running: true
            repeat: true

            onTriggered: timeText.updateTime()
        }

        Component.onCompleted: updateTime()
    }
}
