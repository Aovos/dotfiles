import QtQuick

import "../modules/clock"
import "../modules/workspaces"
import "../modules/battery"
import "../modules/powerprofile"
import "../modules/sound"
import "../modules/wifi"
import "../modules/bluetooth"
import "../shared"

Rectangle {
    id: root

    property bool expanded: true

    width: 900
    height: 40

    radius: 20

    color: "#000000"

    border.color: "#1a1a1a"
    border.width: 1

    anchors.horizontalCenter: parent.horizontalCenter

    y: expanded ? 0 : -height

    function toggle() {
        expanded = !expanded
    }

    Behavior on y {
        NumberAnimation {
            duration: 250
            easing.type: Easing.OutCubic
        }
    }

    Rectangle {
        id: clockArea

        width: 100
        height: 30

        radius: 15

        color: "#202020"

        anchors {
            left: parent.left
            leftMargin: 8
            verticalCenter: parent.verticalCenter
        }

        Clock {
            anchors.centerIn: parent
        }
    }

    Workspaces {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    Row {
        id: statusArea

        spacing: 4

        anchors {
            right: parent.right
            rightMargin: 8
            verticalCenter: parent.verticalCenter
        }

        StatusButton {
            PowerProfile {
                anchors.centerIn: parent
            }
        }

        StatusButton {
            Sound {
                anchors.centerIn: parent
            }
        }

        StatusButton {
            Wifi {
                anchors.centerIn: parent
            }
        }

        StatusButton {
            Bluetooth {
                anchors.centerIn: parent
            }
        }

        StatusButton {
            Battery {
                anchors.centerIn: parent
            }
        }
    }
}
