import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "config"
import "modules"
import "launcher"
import "media"

ShellRoot {
    id: root

    // Global state for popups
    property bool controlCenterOpen: false
    property bool powerMenuOpen: false
    property bool launcherOpen: false
    property bool mediaOpen: false

    // Single Top Bar
    PanelWindow {
        id: barWindow
        anchors {
            top: true
            left: true
            right: true
        }
        implicitHeight: Theme.barHeight
        color: "transparent"

        WlrLayershell.layer: WlrLayer.Top
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
        exclusionMode: ExclusionMode.Auto

        Bar {
            anchors.fill: parent
            onToggleControlCenter: root.controlCenterOpen = !root.controlCenterOpen
            onTogglePowerMenu: root.powerMenuOpen = !root.powerMenuOpen
            onToggleLauncher: root.launcherOpen = !root.launcherOpen
            onToggleMedia: root.mediaOpen = !root.mediaOpen
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

    // App Launcher
    Launcher {
        visible: root.launcherOpen
        onCloseRequested: root.launcherOpen = false
    }

    // Media Controls Popup
    MediaPopup {
        visible: root.mediaOpen
        onCloseRequested: root.mediaOpen = false
    }

    // Notification Overlay
    Notifications {}

    // IPC handlers for Hyprland binds
    IpcHandler {
        target: "shell"

        function toggleLauncher() {
            root.launcherOpen = !root.launcherOpen;
        }

        function toggleControlCenter() {
            root.controlCenterOpen = !root.controlCenterOpen;
        }

        function togglePowerMenu() {
            root.powerMenuOpen = !root.powerMenuOpen;
        }

        function toggleMedia() {
            root.mediaOpen = !root.mediaOpen;
        }
    }
}
