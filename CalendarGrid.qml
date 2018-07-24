import QtQuick 2.0
import QtQuick.Controls.Material 2.2
import QtQuick.Controls 2.2

Column {
    property int currIndx: -1
    spacing: 5
    Row {
        id: calHeader
        spacing: 5

        HeaderTile { info: "MON" }
        HeaderTile { info: "TUE" }
        HeaderTile { info: "WED" }
        HeaderTile { info: "THU" }
        HeaderTile { info: "FRI" }
        HeaderTile {
            info: "SAT"
            color: "steelblue"
        }
        HeaderTile {
            info: "SUN"
            color: "steelblue"
        }
    }

    Grid {
        columns: 7
        spacing: 5
        id: calendar
        Repeater {
            model: 35
            CalendarTile {}
        }
    }
}
