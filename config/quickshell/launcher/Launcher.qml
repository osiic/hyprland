import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import "../config"
import "../components"

PanelWindow {
    id: launcherWindow
    anchors {
        top: true
        bottom: true
        left: true
        right: true
    }
    color: "#80000000"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    signal closeRequested()

    // Key handling to close launcher
    Item {
        focus: true
        Keys.onEscapePressed: launcherWindow.closeRequested()
    }

    MouseArea {
        anchors.fill: parent
        onClicked: launcherWindow.closeRequested()
    }

    Surface {
        anchors.centerIn: parent
        width: Theme.launcherWidth
        height: Theme.launcherHeight
        radius: Theme.radiusMd
        elevated: true

        MouseArea {
            anchors.fill: parent
            // Stop click propagation
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: Theme.spaceLg
            spacing: Theme.spaceMd

            // Search Header
            RowLayout {
                spacing: Theme.spaceSm
                Layout.fillWidth: true

                Text {
                    text: "󰍉"
                    color: Theme.accent
                    font.family: Theme.fontMono
                    font.pixelSize: 16
                }

                TextField {
                    id: searchInput
                    Layout.fillWidth: true
                    placeholderText: "Type to search applications..."
                    placeholderTextColor: Theme.textMuted
                    color: Theme.textPrimary
                    font.family: Theme.fontSans
                    font.pixelSize: 13
                    background: null
                    focus: true
                    onAccepted: {
                        if (appResults.count > 0) {
                            appResults.get(0).execute();
                            launcherWindow.closeRequested();
                        }
                    }
                    Keys.onEscapePressed: launcherWindow.closeRequested()
                }
            }

            Rectangle {
                Layout.fillWidth: true
                height: 1
                color: Theme.borderSubtle
            }

            // Results List
            ListView {
                id: listView
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                spacing: 4

                model: ListModel {
                    id: appResults
                    Component.onCompleted: populateApps()

                    function populateApps() {
                        appResults.clear();
                        const defaultApps = [
                            { name: "Ghostty Terminal", exec: "ghostty", icon: "󰞷", desc: "GPU-accelerated terminal emulator" },
                            { name: "Microsoft Edge", exec: "microsoft-edge-stable", icon: "󰇩", desc: "Web browser" },
                            { name: "Files (Nautilus)", exec: "nautilus", icon: "󰉋", desc: "File manager" },
                            { name: "Neovim", exec: "ghostty -e nvim", icon: "󰅩", desc: "Vim-fork text editor" },
                            { name: "Btop Monitor", exec: "ghostty -e btop", icon: "󰄲", desc: "Resource monitor" },
                            { name: "LibreOffice", exec: "libreoffice", icon: "󰈙", desc: "Office productivity suite" },
                            { name: "MPV Player", exec: "mpv", icon: "󰕼", desc: "Media player" }
                        ];

                        const filter = searchInput.text.toLowerCase();
                        for (let app of defaultApps) {
                            if (!filter || app.name.toLowerCase().includes(filter) || app.desc.toLowerCase().includes(filter)) {
                                appResults.append({
                                    name: app.name,
                                    cmd: app.exec,
                                    icon: app.icon,
                                    desc: app.desc,
                                    execute: function() {
                                        Quickshell.execDetached(app.exec);
                                    }
                                });
                            }
                        }
                    }
                }

                delegate: Surface {
                    width: listView.width
                    height: 44
                    hoverable: true
                    radius: Theme.radiusSm

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: Theme.spaceMd
                        anchors.rightMargin: Theme.spaceMd
                        spacing: Theme.spaceMd

                        Text {
                            text: model.icon
                            color: Theme.accent
                            font.family: Theme.fontMono
                            font.pixelSize: 16
                        }

                        ColumnLayout {
                            spacing: 1
                            Layout.fillWidth: true

                            Text {
                                text: model.name
                                color: Theme.textPrimary
                                font.family: Theme.fontSans
                                font.pixelSize: 12
                                font.bold: true
                            }

                            Text {
                                text: model.desc
                                color: Theme.textSecondary
                                font.family: Theme.fontSans
                                font.pixelSize: 10
                            }
                        }

                        Text {
                            text: "↵"
                            color: Theme.textMuted
                            font.family: Theme.fontMono
                            font.pixelSize: 12
                        }
                    }

                    mouseArea.onClicked: {
                        Quickshell.execDetached(model.cmd);
                        launcherWindow.closeRequested();
                    }
                }
            }
        }
    }

    Connections {
        target: searchInput
        function onTextChanged() {
            appResults.populateApps();
        }
    }
}
