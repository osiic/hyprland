import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pipewire
import Quickshell.Io
import ".."

PanelWindow {
    id: ccWindow
    anchors {
        top: true
        right: true
    }
    margins {
        top: 44
        right: 12
    }
    implicitWidth: 320
    implicitHeight: 380
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
            anchors.margins: 14
            spacing: 12

            // Header
            RowLayout {
                Text {
                    text: "Quick Controls"
                    color: Theme.textPrimary
                    font.family: Theme.fontSans
                    font.pixelSize: 13
                    font.bold: true
                }

                Item { Layout.fillWidth: true }

                Rectangle {
                    width: 20
                    height: 20
                    radius: Theme.radiusSm
                    color: Theme.bgSurface

                    Text {
                        anchors.centerIn: parent
                        text: "󰅖"
                        color: Theme.textSecondary
                        font.family: Theme.fontMono
                        font.pixelSize: 10
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: ccWindow.closeRequested()
                    }
                }
            }

            // Quick Toggles (Wi-Fi, Bluetooth)
            RowLayout {
                spacing: 8

                // Wi-Fi Card
                Rectangle {
                    Layout.fillWidth: true
                    height: 48
                    radius: Theme.radiusSm
                    color: Theme.bgSurface
                    border.color: Theme.borderSubtle
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 8

                        Text {
                            text: "󰤨"
                            color: Theme.accent
                            font.family: Theme.fontMono
                            font.pixelSize: 16
                        }

                        ColumnLayout {
                            spacing: 1
                            Text {
                                text: "Wi-Fi"
                                color: Theme.textPrimary
                                font.pixelSize: 11
                                font.bold: true
                            }
                            Text {
                                text: "Connected"
                                color: Theme.textSecondary
                                font.pixelSize: 9
                            }
                        }
                    }
                }

                // Bluetooth Card
                Rectangle {
                    Layout.fillWidth: true
                    height: 48
                    radius: Theme.radiusSm
                    color: Theme.bgSurface
                    border.color: Theme.borderSubtle
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 8

                        Text {
                            text: "󰂯"
                            color: Theme.textSecondary
                            font.family: Theme.fontMono
                            font.pixelSize: 16
                        }

                        ColumnLayout {
                            spacing: 1
                            Text {
                                text: "Bluetooth"
                                color: Theme.textPrimary
                                font.pixelSize: 11
                                font.bold: true
                            }
                            Text {
                                text: "Active"
                                color: Theme.textSecondary
                                font.pixelSize: 9
                            }
                        }
                    }
                }
            }

            // Volume Slider (PipeWire Native)
            ColumnLayout {
                spacing: 4

                RowLayout {
                    Text {
                        text: "󰕾 Volume"
                        color: Theme.textSecondary
                        font.family: Theme.fontMono
                        font.pixelSize: 11
                    }
                    Item { Layout.fillWidth: true }
                    Text {
                        text: {
                            const sink = Pipewire.defaultAudioSink;
                            if (!sink) return "0%";
                            return `${Math.round(sink.audio.volume * 100)}%`;
                        }
                        color: Theme.textPrimary
                        font.family: Theme.fontMono
                        font.pixelSize: 11
                    }
                }

                Slider {
                    id: volSlider
                    Layout.fillWidth: true
                    from: 0.0
                    to: 1.0
                    value: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio.volume : 0.5
                    onMoved: {
                        if (Pipewire.defaultAudioSink) {
                            Pipewire.defaultAudioSink.audio.volume = value;
                        }
                    }
                }
            }

            // Brightness Slider (brightnessctl)
            ColumnLayout {
                spacing: 4

                RowLayout {
                    Text {
                        text: "󰃠 Brightness"
                        color: Theme.textSecondary
                        font.family: Theme.fontMono
                        font.pixelSize: 11
                    }
                    Item { Layout.fillWidth: true }
                    Text {
                        id: brightLabel
                        text: "80%"
                        color: Theme.textPrimary
                        font.family: Theme.fontMono
                        font.pixelSize: 11
                    }
                }

                Slider {
                    id: brightSlider
                    Layout.fillWidth: true
                    from: 10
                    to: 100
                    value: 80
                    onMoved: {
                        brightLabel.text = `${Math.round(value)}%`;
                        Quickshell.execDetached(["brightnessctl", "set", `${Math.round(value)}%`]);
                    }
                }
            }

            Item { Layout.fillHeight: true }

            // Bottom Actions (Terminal / Settings)
            RowLayout {
                spacing: 8

                Rectangle {
                    Layout.fillWidth: true
                    height: 32
                    radius: Theme.radiusSm
                    color: Theme.bgSurface
                    border.color: Theme.borderSubtle
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "󰆍 Terminal"
                        color: Theme.textPrimary
                        font.family: Theme.fontMono
                        font.pixelSize: 11
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(["ghostty"]);
                            ccWindow.closeRequested();
                        }
                    }
                }

                Rectangle {
                    Layout.fillWidth: true
                    height: 32
                    radius: Theme.radiusSm
                    color: Theme.bgSurface
                    border.color: Theme.borderSubtle
                    border.width: 1

                    Text {
                        anchors.centerIn: parent
                        text: "󰉋 Files"
                        color: Theme.textPrimary
                        font.family: Theme.fontMono
                        font.pixelSize: 11
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            Quickshell.execDetached(["nautilus"]);
                            ccWindow.closeRequested();
                        }
                    }
                }
            }
        }
    }
}
