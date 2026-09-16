import QtQuick
import Quickshell
import Quickshell.Wayland

import "bar_layouts"
import "popups"

PanelWindow {
    id: root

    PowerPopup {
        id: powerPopup
    }

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 50

    exclusionMode: ExclusionMode.Auto

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    focusable: false
    color: "transparent"

    TopBar {
        id: topBar

        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 5
        }

        onPowerToggled: {
            powerPopup.opened = !powerPopup.opened
        }
    }
}
