import QtQuick
import "../config"

Rectangle {
    id: root
    property bool elevated: false
    property bool hoverable: false
    property bool active: false
    property alias mouseArea: mArea

    color: active ? Theme.bgActive : (elevated ? Theme.bgElevated : (hoverable && mArea.containsMouse ? Theme.bgHover : Theme.bgSurface))
    border.color: active ? Theme.accent : (mArea.containsMouse ? Theme.borderFocus : Theme.borderSubtle)
    border.width: 1
    radius: Theme.radiusSm

    Behavior on color { ColorAnimation { duration: Theme.animFast } }
    Behavior on border.color { ColorAnimation { duration: Theme.animFast } }

    MouseArea {
        id: mArea
        anchors.fill: parent
        hoverEnabled: root.hoverable
        cursorShape: root.hoverable ? Qt.PointingHandCursor : Qt.ArrowCursor
    }
}
