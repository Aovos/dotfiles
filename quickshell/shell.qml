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

    implicitHeight: 50

    exclusionMode: ExclusionMode.Auto

    WlrLayershell.layer: WlrLayer.Top
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    focusable: false
    color: "transparent"
    
    // Notch {
    //     anchors {
    //         horizontalCenter: parent.horizontalCenter
    //         top: parent.top
    //         topMargin: 5
    //     }
    // }

    TopBar {
        anchors {
            horizontalCenter: parent.horizontalCenter
            top: parent.top
            topMargin: 5
        }
    }
}
