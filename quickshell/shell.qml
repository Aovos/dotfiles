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

    WlrLayershell.layer: WlrLayer.Overlay

    exclusionMode: ExclusionMode.Ignore

    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    focusable: false
    color: "transparent"

    Notch {
        id: notch
    }

    Shortcut {
        sequence: "Meta+I"

        onActivated: {
            notch.toggle()
        }
    }
}
