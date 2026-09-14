import QtQuick

Text {
    id: clockText

    color: "#ffffff"

    font.pixelSize: 14
    font.weight: Font.DemiBold

    function updateTime() {
        text = Qt.formatTime(new Date(), "hh:mm")
    }

    Timer {
        interval: 60000
        running: true
        repeat: true

        onTriggered: clockText.updateTime()
    }

    Component.onCompleted: updateTime()
}
