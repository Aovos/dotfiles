import QtQuick

import "../modules/clock"
import "../modules/cava"
import "../modules/workspaces"
import "../modules/battery"
import "../modules/powerprofile"
import "../modules/sound"
import "../modules/wifi"
import "../modules/bluetooth"

Rectangle {
    id: root

    width: 900
    height: 40

    radius: 20

    color: "#000000"

    border.color: "#1a1a1a"
    border.width: 1

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

    Rectangle {
        id: cavaArea

        width: 120
        height: 30

        radius: 15

        color: "#202020"

        anchors {
            left: clockArea.right
            leftMargin: 8
            verticalCenter: parent.verticalCenter
        }

        Cava {
            anchors.centerIn: parent
        }
    }

    Workspaces {
        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: statusArea

        width: 180
        height: 30

        radius: 15

        color: "#202020"

        anchors {
            right: parent.right
            rightMargin: 8
            verticalCenter: parent.verticalCenter
        }

        Row {
            anchors.centerIn: parent

            spacing: 8

            Wifi { }

            PowerProfile { }

            Bluetooth { }

            Sound { }

            Battery { }
        }
    }

}
