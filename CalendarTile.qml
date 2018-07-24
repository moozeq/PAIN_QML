import QtQuick 2.0

Rectangle {
    width: 60
    height: width
    color: ma.pressed && index < 30 ? "grey" : "lightgrey"

    Text {
        text: index < 30 ? index + 1 : ""
        anchors.centerIn: parent
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        onClicked: if (index < 30) currIndx = index
    }
}
