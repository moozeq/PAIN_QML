import QtQuick 2.9
import QtQuick.Controls 2.2

ListView {
    id: ridesListView

    Component {
        id: ridesDelegate
        Rectangle {
            id: wrapper
            width: mainWindow.width * 0.9
            height: rideInfo.height
            radius: 10
            color: ma.pressed ? "lightsteelblue" : "white"
            Grid {
                verticalItemAlignment: Grid.AlignVCenter
                horizontalItemAlignment: Grid.AlignHCenter
                columns: 5
                id: rideInfo
                spacing: 20
                height: Math.max(driverImg, driverInfo, passImg, passInfo)
                Text {
                    font.pixelSize: 18
                    text: rideday ==
                          cal.currIndx + 1 ?
                              hour < 10 ?
                                  min < 10 ?
                                      "0" + hour + ":0" + min :
                                      "0" + hour + ":" + min
                              :   min < 10 ?
                                      hour + ":0" + min :
                                      hour + ":" + min
                          : ""
                }

                Image {
                    id: driverImg
                    visible: rideday == cal.currIndx + 1
                    source: "resources/wheel.png"
                }
                Text {
                    id: driverInfo
                    font.pixelSize: 25
                    text: rideday == cal.currIndx + 1 ? driversname : ""
                }
                Image {
                    id: passImg
                    visible: rideday == cal.currIndx + 1
                    source: "resources/pass.png"
                }
                Text {
                    id: passInfo
                    font.pixelSize: 25
                    text: rideday == cal.currIndx + 1 ? passname : ""
                }
            }
            MouseArea {
                id: ma
                anchors.fill: parent
                onClicked: {
                    parent.ListView.view.currentIndex = index
                    popup.open()
                }
            }
        }
    }

    model: RidesList { id: ridesModel }
    delegate: ridesDelegate
    focus: true
    currentIndex: -1

    Popup {
        enter: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0.0
                to: 1.0
            }
        }
        exit: Transition {
            NumberAnimation {
                property: "opacity"
                from: 1.0
                to: 0.0
            }
        }
        id: popup
        x: mainWindow.width / 2 - width / 2
        y: mainWindow.height / 2 - height / 2
        width: 400
        height: 400
        modal: true
        focus: true
        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
        onClosed: {
            wrongData.visible = false
            ridesListView.currentIndex = -1
        }
        EditRide {
            id: editRidePopup
            anchors.fill: parent

            Label {
                states: [
                    State {
                        when: wrongData.visible
                        PropertyChanges {
                            target: wrongData
                            opacity: 1.0
                        }
                    },
                    State {
                        when: !wrongData.visible
                        PropertyChanges {
                            target: wrongData
                            opacity: 0.0
                        }
                    }
                ]
                transitions: Transition {
                    NumberAnimation { property: "opacity"; duration: 200}
                }
                id: wrongData
                font.pixelSize: 10
                color: "red"
                text: "Couln't add new ride, try again"
                visible: false
            }
        }
    }

    Row {
        anchors.bottom: buttons.top
        anchors.right: parent.right
        anchors.bottomMargin: 20
        Text {
            font.pixelSize: 15
            text: "Date: " + (cal.currIndx + 1) + ".04.2018"
        }
    }

    Row {
        id: buttons
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        Image {
            source: "resources/return.png"
            MouseArea {
                anchors.fill: parent
                onClicked: cal.currIndx = -1
            }
        }
        Image {
            source: "resources/prev.png"
            MouseArea {
                anchors.fill: parent
                onClicked: cal.currIndx > 0 ? cal.currIndx-- : {}
            }
        }
        Image {
            source: "resources/next.png"
            MouseArea {
                anchors.fill: parent
                onClicked: cal.currIndx < 30 ? cal.currIndx++ : {}
            }
        }
        Image {
            source: "resources/add.png"
            MouseArea {
                anchors.fill: parent
                onClicked: popup.open()
            }
        }
    }
}
