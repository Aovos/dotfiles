import QtQuick
import Quickshell.Services.UPower

Item {
    id: root

    property var battery: UPower.displayDevice

    property real percentage: battery
        ? (battery.percentage <= 1
            ? battery.percentage * 100
            : battery.percentage)
        : 0

    implicitWidth: batteryIcon.implicitWidth
    implicitHeight: batteryIcon.implicitHeight

    Text {
        id: batteryIcon

        anchors.centerIn: parent

        text: {
            if (!battery)
                return "󰂎"

            const level = percentage

            // Charging
            if (battery.state === UPowerDeviceState.Charging) {
                if (level >= 95) return "󰂅"
                if (level >= 85) return "󰂋"
                if (level >= 75) return "󰂊"
                if (level >= 65) return "󰢞"
                if (level >= 55) return "󰂉"
                if (level >= 45) return "󰢝"
                if (level >= 35) return "󰂈"
                if (level >= 25) return "󰂇"
                if (level >= 15) return "󰂆"

                return "󰢜"
            }

            // Discharging
            if (level >= 95) return "󰁹"
            if (level >= 85) return "󰂂"
            if (level >= 75) return "󰂁"
            if (level >= 65) return "󰂀"
            if (level >= 55) return "󰁿"
            if (level >= 45) return "󰁾"
            if (level >= 35) return "󰁽"
            if (level >= 25) return "󰁼"
            if (level >= 15) return "󰁻"
            if (level >= 5)  return "󰁺"

            return "󰂎"
        }

        color: {
            if (!battery)
                return "#e0e0e0"

            if (battery.state === UPowerDeviceState.Charging)
                return "#81c784"

            if (percentage <= 5)
                return "#ff5555"

            if (percentage <= 15)
                return "#ffb86c"

            return "#e0e0e0"
        }

        font.pixelSize: 16
        font.family: "JetBrainsMono Nerd Font"
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
    }

}
