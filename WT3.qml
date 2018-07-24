import QtQuick 2.9
import QtQuick.Window 2.3
import QtQuick.Controls.Material 2.2
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.2

ApplicationWindow  {
    id: mainWindow
    visible: true
    minimumWidth: 540
    minimumHeight: 560
    title: qsTr("BORowick application")

    StackLayout {
        anchors.fill: parent
        id: layout
        anchors.margins: 20
        currentIndex: cal.currIndx >= 0 ? 1 : 0

        CalendarGrid {
            id: cal
        }

        RidesWindow {
            id: rides
        }

    }
}
