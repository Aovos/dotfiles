import QtQuick

import "../modules/clock"
import "../modules/cava"
import "../modules/workspaces"
import "../modules/battery"
import "../modules/powerprofile"
import "../modules/sound"
import "../modules/wifi"
import "../modules/bluetooth"
import "../modules/powermenu"
import "../shared"

Rectangle {
    id: root

    signal powerToggled()

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

        StatusButton {
            PowerMenu {
                id: powerMenu

                anchors.centerIn: parent

                onToggleRequested: {
                    root.powerToggled()
                }
            }
        }
    }
}
