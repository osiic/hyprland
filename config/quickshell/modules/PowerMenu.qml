import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import ".."

PanelWindow {
    id: pmWindow
    anchors {
        top: true
        right: true
    }
    margins {
        top: 44
        right: 12
    }
    implicitWidth: 220
    implicitHeight: 250
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

    signal closeRequested()

    Rectangle {
        anchors.fill: parent
        radius: Theme.radiusMd
        color: Theme.bgBase
        border.color: Theme.borderSubtle
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 10
            spacing: 6

            // Power Actions List
            Repeater {
                model: [
                    { name: "Lock Screen", icon: "󰌾", action: ["swaylock"], color: Theme.textPrimary },
                    { name: "Suspend", icon: "󰤄", action: ["systemctl", "suspend"], color: Theme.textPrimary },
                    { name: "Logout", icon: "󰍃", action: ["hyprctl", "dispatch", "exit"], color: Theme.warning },
                    { name: "Reboot", icon: "󰜉", action: ["systemctl", "reboot"], color: Theme.warning },
                    { name: "Shutdown", icon: "󰐥", action: ["systemctl", "poweroff"], color: Theme.danger }
                ]

                delegate: Rectangle {
                    id: btnItem
                    required property var modelData
                    Layout.fillWidth: true
                    height: 38
                    radius: Theme.radiusSm
                    color: btnArea.containsMouse ? Theme.bgSurfaceHover : Theme.bgSurface
                    border.color: Theme.borderSubtle
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 12
                        anchors.rightMargin: 12
                        spacing: 12

                        Text {
                            text: btnItem.modelData.icon
                            color: btnItem.modelData.color
                            font.family: Theme.fontMono
                            font.pixelSize: 14
                        }

                        Text {
                            text: btnItem.modelData.name
                            color: Theme.textPrimary
                            font.family: Theme.fontSans
                            font.pixelSize: 11
                            font.bold: true
                        }
                    }

                    MouseArea {
                        id: btnArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(btnItem.modelData.action);
                            pmWindow.closeRequested();
                        }
                    }
                }
            }
        }
    }
}
