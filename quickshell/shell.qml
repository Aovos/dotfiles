import QtQuick
import Quickshell
import Quickshell.Wayland

import "bar_layouts"

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 60

    exclusionMode: ExclusionMode.Ignore

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    focusable: false
    color: "transparent"

    TopBar {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 10
        }
    }

    // mask: Region {
    //     x: notch.x
    //     y: notch.y
    //     width: notch.width
    //     height: notch.height
    // }
}
