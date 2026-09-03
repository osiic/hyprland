import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "modules"

ShellRoot {
    id: root

    // Global state for popups
    property bool controlCenterOpen: false
    property bool powerMenuOpen: false

    // Single Top Bar
    PanelWindow {
        id: barWindow
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: 38
        color: "transparent"

        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
        exclusionMode: ExclusionMode.Auto

        Bar {
            anchors.fill: parent
            onToggleControlCenter: root.controlCenterOpen = !root.controlCenterOpen
            onTogglePowerMenu: root.powerMenuOpen = !root.powerMenuOpen
        }
    }

    // Control Center Popup
    ControlCenter {
        visible: root.controlCenterOpen
        onCloseRequested: root.controlCenterOpen = false
    }

    // Power Menu Popup
    PowerMenu {
        visible: root.powerMenuOpen
        onCloseRequested: root.powerMenuOpen = false
    }

    // Notification Overlay
    Notifications {}
}
