import QtQuick
import QtQuick.Controls
import QtQuick.Effects
import Quickshell
import Quickshell.Wayland

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 40

    // Die Anwendung soll den Platz vollständig nutzen
    exclusionMode: ExclusionMode.Ignore

    // Über normalen Fenstern
    WlrLayershell.layer: WlrLayer.Overlay

    // Keine Tastatur-Eingaben abfangen
    focusable: false
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    color: "transparent"

    // ============================================================
    // WICHTIG:
    // Nur der Bereich der Notch empfängt Mausklicks.
    // Alles links und rechts wird an die Anwendung durchgereicht.
    // ============================================================
    mask: Region {
        x: notch.x
        y: notch.y
        width: notch.width
        height: notch.height
    }

    Rectangle {
        id: notch

        width: timeText.implicitWidth + 40
        height: 30

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 10
        }

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
                var date = new Date()

                var hours = date.getHours().toString().padStart(2, "0")
                var minutes = date.getMinutes().toString().padStart(2, "0")

                timeText.text = hours + ":" + minutes
            }

            Timer {
                interval: 1000
                running: true
                repeat: true

                onTriggered: timeText.updateTime()
            }

            Component.onCompleted: {
                updateTime()
            }
        }
    }
}
