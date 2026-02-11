import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: root
    color: "#1e1e1e"
    border.color: "#333"
    border.width: 0

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        spacing: 20

        Row {
            spacing: 12
            Layout.alignment: Qt.AlignVCenter
            
            Text {
                text: "MARTIN"
                color: "#4CAF50"
                font.pixelSize: 15
                font.bold: true
                font.family: "Segoe UI"
                anchors.verticalCenter: parent.verticalCenter
            }

            Rectangle {
                width: 90
                height: 24
                color: "#7b1fa2"
                radius: 4
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    anchors.centerIn: parent
                    text: "Diagnostics"
                    color: "white"
                    font.pixelSize: 11
                    font.bold: true
                    font.family: "Segoe UI"
                }
            }

            Rectangle {
                width: 90
                height: 24
                color: "#ff6f00"
                radius: 4
                anchors.verticalCenter: parent.verticalCenter
                Text {
                    anchors.centerIn: parent
                    text: "Convoy: OFF"
                    color: "white"
                    font.pixelSize: 11
                    font.bold: true
                    font.family: "Segoe UI"
                }
            }
        }

        Item { Layout.fillWidth: true }

        Text {
            text: "MARTIN GCS"
            color: "#e0e0e0"
            font.pixelSize: 16 * window.uiScale
            font.bold: true
            font.family: "Segoe UI"
            Layout.alignment: Qt.AlignCenter
        }

        Item { Layout.fillWidth: true }

        Row {
            spacing: 20
            Layout.alignment: Qt.AlignVCenter

            Text {
                id: clock
                color: "white"
                font.pixelSize: 16 * window.uiScale
                font.bold: true
                font.family: "Consolas"
                anchors.verticalCenter: parent.verticalCenter
                
                function updateTime() {
                    var d = new Date()
                    text = Qt.formatTime(d, "HH:mm:ss")
                }
                
                Component.onCompleted: updateTime()
                
                Timer {
                    interval: 1000
                    running: true
                    repeat: true
                    onTriggered: clock.updateTime()
                }
            }

            Button {
                text: "EMERGENCY"
                Layout.preferredHeight: 32
                Layout.preferredWidth: 120
                
                background: Rectangle {
                    color: parent.pressed ? "#b71c1c" : "#d32f2f"
                    radius: 3
                    border.color: "#ff5252"
                    border.width: 1
                }
                
                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.bold: true
                    font.pixelSize: 11
                    font.family: "Segoe UI"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }
            }
        }
    }
}
