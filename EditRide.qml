import QtQuick 2.9
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.2

Grid {
    readonly property int pixSize: 18
    columns: 2
    spacing: 20
    verticalItemAlignment: Grid.AlignVCenter
    horizontalItemAlignment: Grid.AlignLeft
    Label {
        font.pixelSize: pixSize
        text: "Driver's name: "
    }
    TextField {
        font.pixelSize: pixSize
        id: driversnameIn
        text: ridesListView.currentIndex >= 0 ?
                  ridesModel.get(ridesListView.currentIndex).driversname : ""
    }

    Label {
        font.pixelSize: pixSize
        text: "Passanger's name: "
    }
    TextField {
        font.pixelSize: pixSize
        id: passnameIn
        text: ridesListView.currentIndex >= 0 ?
                  ridesModel.get(ridesListView.currentIndex).passname : ""
    }

    Label {
        font.pixelSize: pixSize
        text: "Time: "
    }
    Row {
        TextField {
            id: hourIn
            width: 50
            font.pixelSize: pixSize
            validator: IntValidator {bottom: 0; top: 23}
            text: ridesListView.currentIndex >= 0 ?
                      ridesModel.get(ridesListView.currentIndex).hour : ""
        }
        Label {
            topPadding: pixSize / 2
            font.pixelSize: pixSize
            text: " : "
        }
        TextField {
            id: minIn
            width: 50
            font.pixelSize: pixSize
            validator: IntValidator {bottom: 0; top: 59}
            text: ridesListView.currentIndex >= 0 ?
                      ridesModel.get(ridesListView.currentIndex).min : ""
        }
    }
    Label {
        font.pixelSize: pixSize
        text: "Duration: "
    }
    Row {
        TextField {
            id: durationIn
            width: 50
            font.pixelSize: pixSize
            validator: IntValidator {bottom: 1; top: 12}
            text: ridesListView.currentIndex >= 0 ?
                      ridesModel.get(ridesListView.currentIndex).duration : ""
        }
        Label {
            topPadding: pixSize / 2
            font.pixelSize: pixSize
            text: " h"
        }
    }
    Label {
        font.pixelSize: pixSize
        text: "Car: "
    }
    ComboBox {
        id: carIn
        textRole: "carDesc"
        model: CarsList {}
        currentIndex: ridesListView.currentIndex >= 0 ?
                          ridesModel.get(ridesListView.currentIndex).car : ""
    }
    Button {
        text: "OK"
        onClicked: {
            if (driversnameIn.text !== "" && passnameIn.text !== "" &&
                hourIn.text !== "" && minIn.text !== "" && durationIn.text !== "") {
                if (ridesListView.currentIndex >= 0) {
                    ridesModel.set(ridesListView.currentIndex, {
                           "rideday": cal.currIndx + 1,
                           "driversname": driversnameIn.text,
                           "passname": passnameIn.text,
                           "hour": parseInt(hourIn.text),
                           "min": parseInt(minIn.text),
                           "duration": parseInt(durationIn.text),
                           "car": carIn.currentIndex
                           });
                }
                else {
                    ridesModel.append({
                           "rideday": cal.currIndx + 1,
                           "driversname": driversnameIn.text,
                           "passname": passnameIn.text,
                           "hour": parseInt(hourIn.text),
                           "min": parseInt(minIn.text),
                           "duration": parseInt(durationIn.text),
                           "car": carIn.currentIndex
                           });
                    driversnameIn.clear();
                    passnameIn.clear();
                    hourIn.clear();
                    minIn.clear();
                    durationIn.clear();
                    carIn.currentIndex = 0;
                }
                popup.close();
            }
            else
                wrongData.visible = true;
        }
    }
    Button {
        id: cancelButton
        text: "Cancel"
        onClicked: popup.close()
    }
}
