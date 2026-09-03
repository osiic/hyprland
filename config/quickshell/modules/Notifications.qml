import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import ".."

Item {
    id: notifRoot

    // Floating Notification Popup Window
    PanelWindow {
        id: notifWindow
        anchors {
            top: true
            right: true
        }
        margins {
            top: 44
            right: 12
        }
        implicitWidth: 320
        implicitHeight: notifCol.implicitHeight
        color: "transparent"
        visible: notifModel.count > 0

        WlrLayershell.layer: WlrLayer.Overlay
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.None

        // Notification Tracked Model
        ListModel {
            id: notifModel
        }

        Connections {
            target: NotificationServer
            function onNotification(notif) {
                notifModel.append({
                    "id": notif.id,
                    "appName": notif.appName || "Notification",
                    "summary": notif.summary || "",
                    "body": notif.body || ""
                });
            }
        }

        ColumnLayout {
            id: notifCol
            anchors.fill: parent
            spacing: 8

            Repeater {
                model: notifModel
                delegate: Rectangle {
                    id: notifCard
                    required property int index
                    required property string appName
                    required property string summary
                    required property string body

                    Layout.fillWidth: true
                    implicitHeight: cardCol.implicitHeight + 20
                    radius: Theme.radiusMd
                    color: Theme.bgSurface
                    border.color: Theme.borderSubtle
                    border.width: 1

                    ColumnLayout {
                        id: cardCol
                        anchors.fill: parent
                        anchors.margins: 10
                        spacing: 4

                        // Header (App Name + Close)
                        RowLayout {
                            Text {
                                text: notifCard.appName
                                color: Theme.accent
                                font.family: Theme.fontSans
                                font.pixelSize: 10
                                font.bold: true
                            }

                            Item { Layout.fillWidth: true }

                            Rectangle {
                                width: 16
                                height: 16
                                radius: 4
                                color: "transparent"

                                Text {
                                    anchors.centerIn: parent
                                    text: "󰅖"
                                    color: Theme.textMuted
                                    font.family: Theme.fontMono
                                    font.pixelSize: 9
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    cursorShape: Qt.PointingHandCursor
                                    onClicked: notifModel.remove(notifCard.index)
                                }
                            }
                        }

                        // Summary / Title
                        Text {
                            Layout.fillWidth: true
                            text: notifCard.summary
                            color: Theme.textPrimary
                            font.family: Theme.fontSans
                            font.pixelSize: 12
                            font.bold: true
                            wrapMode: Text.WordWrap
                        }

                        // Body
                        Text {
                            Layout.fillWidth: true
                            text: notifCard.body
                            color: Theme.textSecondary
                            font.family: Theme.fontSans
                            font.pixelSize: 11
                            wrapMode: Text.WordWrap
                            visible: text.length > 0
                        }
                    }

                    // Auto-dismiss timer per card
                    Timer {
                        interval: 6000
                        running: true
                        onTriggered: notifModel.remove(notifCard.index)
                    }
                }
            }
        }
    }
}
