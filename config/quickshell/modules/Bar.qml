import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import Quickshell.Services.SystemTray
import Quickshell.Services.Pipewire
import ".."

Rectangle {
    id: bar
    color: Theme.bgBase
    border.color: Theme.borderSubtle
    border.width: 1
    radius: 0

    signal toggleControlCenter()
    signal togglePowerMenu()

    // Top subtle border highlight
    Rectangle {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        height: 1
        color: Theme.borderSubtle
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 12

        // ================= LEFT: WORKSPACES & ACTIVE WINDOW =================
        RowLayout {
            spacing: 6

            // Arch / App Icon
            Rectangle {
                width: 24
                height: 24
                radius: Theme.radiusSm
                color: Theme.bgSurface

                Text {
                    anchors.centerIn: parent
                    text: "󰣇"
                    color: Theme.accent
                    font.family: Theme.fontMono
                    font.pixelSize: 13
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: bar.toggleControlCenter()
                }
            }

            // Workspaces (1-10 Minimal Badges)
            Repeater {
                model: 6 // 6 main workspaces
                delegate: Rectangle {
                    id: wsBadge
                    required property int index
                    readonly property int wsId: index + 1
                    readonly property bool isFocused: Hyprland.focusedWorkspace && Hyprland.focusedWorkspace.id === wsId

                    width: isFocused ? 26 : 20
                    height: 20
                    radius: Theme.radiusSm
                    color: isFocused ? Theme.accent : Theme.bgSurface
                    border.color: isFocused ? Theme.accent : Theme.borderSubtle
                    border.width: 1

                    Behavior on width {
                        NumberAnimation { duration: 150; easing.type: Easing.OutQuad }
                    }

                    Text {
                        anchors.centerIn: parent
                        text: wsBadge.wsId
                        color: wsBadge.isFocused ? Theme.bgBase : Theme.textSecondary
                        font.family: Theme.fontMono
                        font.pixelSize: 10
                        font.bold: wsBadge.isFocused
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Hyprland.dispatch(`workspace ${wsBadge.wsId}`)
                    }
                }
            }
        }

        // Active Window Title (Muted, Minimal)
        Text {
            Layout.fillWidth: true
            Layout.maximumWidth: 350
            elide: Text.ElideRight
            text: Hyprland.focusedWindow ? (Hyprland.focusedWindow.title || Hyprland.focusedWindow.className) : "Desktop"
            color: Theme.textMuted
            font.family: Theme.fontSans
            font.pixelSize: 11
        }

        Item { Layout.fillWidth: true } // Spacer

        // ================= CENTER: CLOCK & DATE =================
        Rectangle {
            height: 24
            implicitWidth: clockRow.implicitWidth + 16
            radius: Theme.radiusSm
            color: Theme.bgSurface
            border.color: Theme.borderSubtle
            border.width: 1

            RowLayout {
                id: clockRow
                anchors.centerIn: parent
                spacing: 6

                Text {
                    text: "󰥔"
                    color: Theme.accent
                    font.family: Theme.fontMono
                    font.pixelSize: 12
                }

                Text {
                    id: timeText
                    color: Theme.textPrimary
                    font.family: Theme.fontMono
                    font.pixelSize: 11
                    font.bold: true

                    Timer {
                        interval: 1000
                        running: true
                        repeat: true
                        triggeredOnStart: true
                        onTriggered: {
                            const d = new Date();
                            const hours = String(d.getHours()).padStart(2, '0');
                            const mins = String(d.getMinutes()).padStart(2, '0');
                            const dayNames = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];
                            timeText.text = `${dayNames[d.getDay()]} ${hours}:${mins}`;
                        }
                    }
                }
            }

            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                onClicked: bar.toggleControlCenter()
            }
        }

        Item { Layout.fillWidth: true } // Spacer

        // ================= RIGHT: STATUS & QUICK CONTROLS =================
        RowLayout {
            spacing: 8

            // System Tray Items
            RowLayout {
                spacing: 4
                Repeater {
                    model: SystemTray.items
                    delegate: Rectangle {
                        id: trayItem
                        required property SystemTrayItem modelData
                        width: 22
                        height: 22
                        radius: Theme.radiusSm
                        color: "transparent"

                        IconImage {
                            anchors.centerIn: parent
                            width: 16
                            height: 16
                            source: trayItem.modelData.icon || ""
                        }

                        MouseArea {
                            anchors.fill: parent
                            acceptedButtons: Qt.LeftButton | Qt.RightButton
                            cursorShape: Qt.PointingHandCursor
                            onClicked: mouse => {
                                if (mouse.button === Qt.RightButton) {
                                    trayItem.modelData.display(bar, mouse.x, mouse.y);
                                } else {
                                    trayItem.modelData.activate();
                                }
                            }
                        }
                    }
                }
            }

            // Updates Indicator (Pacman / Paru)
            UpdateIndicator {}

            // Audio & Battery Quick Badges
            Rectangle {
                height: 24
                implicitWidth: statusRow.implicitWidth + 16
                radius: Theme.radiusSm
                color: Theme.bgSurface
                border.color: Theme.borderSubtle
                border.width: 1

                RowLayout {
                    id: statusRow
                    anchors.centerIn: parent
                    spacing: 10

                    // Volume Icon
                    Text {
                        text: {
                            const sink = Pipewire.defaultAudioSink;
                            if (!sink || sink.audio.muted) return "󰝟";
                            const vol = Math.round(sink.audio.volume * 100);
                            if (vol > 50) return "󰕾";
                            if (vol > 0) return "󰖀";
                            return "󰕿";
                        }
                        color: Theme.textSecondary
                        font.family: Theme.fontMono
                        font.pixelSize: 12
                    }

                    // Network Icon
                    Text {
                        text: "󰤨"
                        color: Theme.textSecondary
                        font.family: Theme.fontMono
                        font.pixelSize: 12
                    }

                    // Battery Icon
                    BatteryIndicator {}
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: bar.toggleControlCenter()
                }
            }

            // Power Menu Button
            Rectangle {
                width: 24
                height: 24
                radius: Theme.radiusSm
                color: Theme.bgSurface
                border.color: Theme.borderSubtle
                border.width: 1

                Text {
                    anchors.centerIn: parent
                    text: "󰐥"
                    color: Theme.danger
                    font.family: Theme.fontMono
                    font.pixelSize: 12
                }

                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: bar.togglePowerMenu()
                }
            }
        }
    }
}
