import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import ".."

Item {
    id: batRoot
    implicitWidth: batText.implicitWidth
    implicitHeight: 16

    property int capacity: 100
    property string status: "Discharging"

    Timer {
        interval: 15000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: batProcess.running = true
    }

    Process {
        id: batProcess
        command: ["sh", "-c", "cat /sys/class/power_supply/BAT*/capacity 2>/dev/null | head -n1; cat /sys/class/power_supply/BAT*/status 2>/dev/null | head -n1"]
        stdout: SplitParser {
            onRead: data => {
                const lines = data.trim().split('\n');
                if (lines.length > 0 && lines[0]) {
                    batRoot.capacity = parseInt(lines[0], 10) || 100;
                }
                if (lines.length > 1 && lines[1]) {
                    batRoot.status = lines[1];
                }
            }
        }
    }

    Text {
        id: batText
        anchors.centerIn: parent
        text: {
            const isCharging = batRoot.status === "Charging" || batRoot.status === "Full";
            if (isCharging) return `󰂄 ${batRoot.capacity}%`;
            if (batRoot.capacity <= 20) return `󰂃 ${batRoot.capacity}%`;
            if (batRoot.capacity <= 50) return `󰁾 ${batRoot.capacity}%`;
            return `󰁹 ${batRoot.capacity}%`;
        }
        color: batRoot.capacity <= 20 ? Theme.danger : (batRoot.status === "Charging" ? Theme.success : Theme.textSecondary)
        font.family: Theme.fontMono
        font.pixelSize: 11
    }
}
