import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Mpris
import "../config"
import "../components"

PanelWindow {
    id: mediaWindow
    anchors {
        top: true
    }
    margins {
        top: 44
    }
    implicitWidth: 320
    implicitHeight: 140
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

    signal closeRequested()

    readonly property MprisPlayer player: Mpris.players.values[0] || null

    Surface {
        anchors.fill: parent
        radius: Theme.radiusMd
        elevated: true

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Theme.spaceMd
            spacing: Theme.spaceSm

            RowLayout {
                spacing: Theme.spaceMd
                Layout.fillWidth: true

                // Art/Icon placeholder
                Rectangle {
                    width: 48
                    height: 48
                    radius: Theme.radiusSm
                    color: Theme.bgSurface
                    border.color: Theme.borderSubtle
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "󰎆"
                        color: Theme.accent
                        font.family: Theme.fontMono
                        font.pixelSize: 20
                    }
                }

                // Track Info
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 2

                    Text {
                        text: mediaWindow.player ? (mediaWindow.player.trackTitle || "No Track") : "No Active Media"
                        color: Theme.textPrimary
                        font.family: Theme.fontSans
                        font.pixelSize: 12
                        font.bold: true
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }

                    Text {
                        text: mediaWindow.player ? (mediaWindow.player.trackArtist || "Unknown Artist") : "Play something in browser or mpv"
                        color: Theme.textSecondary
                        font.family: Theme.fontSans
                        font.pixelSize: 10
                        elide: Text.ElideRight
                        Layout.fillWidth: true
                    }
                }
            }

            // Controls
            RowLayout {
                Layout.alignment: Qt.AlignHCenter
                spacing: Theme.spaceLg

                Text {
                    text: "󰒮"
                    color: Theme.textSecondary
                    font.family: Theme.fontMono
                    font.pixelSize: 16
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: if (mediaWindow.player && mediaWindow.player.canGoPrevious) mediaWindow.player.previous()
                    }
                }

                Surface {
                    width: 32
                    height: 32
                    radius: Theme.radiusFull
                    hoverable: true

                    Text {
                        anchors.centerIn: parent
                        text: (mediaWindow.player && mediaWindow.player.playbackState === MprisPlaybackState.Playing) ? "󰏤" : "󰐊"
                        color: Theme.accent
                        font.family: Theme.fontMono
                        font.pixelSize: 14
                    }

                    mouseArea.onClicked: {
                        if (mediaWindow.player) mediaWindow.player.togglePlaying();
                    }
                }

                Text {
                    text: "󰒭"
                    color: Theme.textSecondary
                    font.family: Theme.fontMono
                    font.pixelSize: 16
                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: if (mediaWindow.player && mediaWindow.player.canGoNext) mediaWindow.player.next()
                    }
                }
            }
        }
    }
}
