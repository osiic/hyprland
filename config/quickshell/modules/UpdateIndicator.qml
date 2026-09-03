import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import ".."

Item {
    id: updateRoot
    implicitWidth: updateRow.implicitWidth
    implicitHeight: 24
    visible: count > 0

    property int count: 0

    Process {
        id: checkProcess
        command: ["sh", "-c", "checkupdates 2>/dev/null | wc -l"]
        stdout: SplitParser {
            onRead: data => {
                const n = parseInt(data.trim(), 10);
                updateRoot.count = isNaN(n) ? 0 : n;
            }
        }
    }

    Timer {
        interval: 1800000 // 30 minutes
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: checkProcess.running = true
    }

    Rectangle {
        anchors.fill: parent
        radius: Theme.radiusSm
        color: Theme.bgSurface
        border.color: Theme.warning
        border.width: 1

        RowLayout {
            id: updateRow
            anchors.centerIn: parent
            anchors.leftMargin: 6
            anchors.rightMargin: 6
            spacing: 4

            Text {
                text: "󰣇"
                color: Theme.warning
                font.family: Theme.fontMono
                font.pixelSize: 11
            }

            Text {
                text: `${updateRoot.count}`
                color: Theme.textPrimary
                font.family: Theme.fontMono
                font.pixelSize: 10
                font.bold: true
            }
        }

        MouseArea {
            anchors.fill: parent
            cursorShape: Qt.PointingHandCursor
            onClicked: {
                // Open Ghostty with paru update prompt
                Quickshell.execDetached(["ghostty", "-e", "paru", "-Syu"]);
            }
        }
    }
}
