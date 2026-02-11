import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: root
    color: "#1e1e1e"
    clip: true

    property int elapsedSeconds: 0
    property string statusText: "STANDBY"
    property bool isTraining: false

    function formatTime(totalSeconds) {
        let h = Math.floor(totalSeconds / 3600);
        let m = Math.floor((totalSeconds % 3600) / 60);
        let s = totalSeconds % 60;
        return [h, m, s].map(v => v < 10 ? "0" + v : v).join(":");
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            if (isTraining) {
                elapsedSeconds += 1
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 6
        spacing: 2

        Repeater {
            model: ["MARTIN-01", "MARTIN-02", "MARTIN-03"]
            delegate: Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 40 * window.uiScale 
                Layout.minimumHeight: 32
                color: "transparent"
                border.color: "#4CAF50"
                border.width: 1
                radius: 4

                Rectangle {
                    anchors.fill: parent
                    color: "#4CAF50"
                    opacity: 0.1
                    radius: 4
                }

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 8

                    Rectangle {
                        width: 10; height: 10; radius: 5
                        color: "#4CAF50"
                        Layout.alignment: Qt.AlignVCenter
                    }

                    Text {
                        text: modelData
                        color: "#4CAF50"
                        font.pixelSize: Math.max(10, 12 * window.uiScale)
                        font.bold: true
                        Layout.fillWidth: true
                    }

                    Rectangle {
                        width: 50; height: 18; radius: 2
                        color: "#4CAF50"
                        Layout.alignment: Qt.AlignVCenter
                        Text {
                            anchors.centerIn: parent
                            text: "ACTIVE"
                            color: "white"
                            font.pixelSize: 9
                            font.bold: true
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 160 * window.uiScale
            Layout.minimumHeight: 120
            Layout.maximumHeight: 200 * window.uiScale
            color: "#2e3b2e"
            border.color: "#388e3c"
            border.width: 1
            radius: 4

            ColumnLayout {
                anchors.fill: parent
                anchors.margins: 10
                spacing: 4

                Text {
                    text: "TRAINING STATUS"
                    color: "#fdd835"
                    font.bold: true
                    font.pixelSize: Math.max(11, 13 * window.uiScale)
                    font.family: "Segoe UI"
                }

                ColumnLayout {
                    spacing: 2
                    Row {
                        spacing: 4
                        Text { text: "STATUS:"; color: "#bdbdbd"; font.pixelSize: Math.max(9, 11 * window.uiScale); font.bold: true }
                        Text { text: statusText; color: "white"; font.pixelSize: Math.max(9, 11 * window.uiScale) }
                    }
                    Row {
                        spacing: 4
                        Text { text: "MISSION:"; color: "#bdbdbd"; font.pixelSize: Math.max(9, 11 * window.uiScale); font.bold: true }
                        Text { text: "TRAINING EXERCISE"; color: "#81c784"; font.pixelSize: Math.max(9, 11 * window.uiScale) }
                    }
                    Row {
                        spacing: 4
                        Text { text: "ELAPSED:"; color: "#bdbdbd"; font.pixelSize: Math.max(9, 11 * window.uiScale); font.bold: true }
                        Text { text: formatTime(elapsedSeconds); color: "#81c784"; font.pixelSize: Math.max(9, 11 * window.uiScale) }
                    }
                }

                Item { Layout.fillHeight: true }

                RowLayout {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    spacing: 16

                    Repeater {
                        model: [
                            { label: "START", icon: "▶", color: "#66bb6a" },
                            { label: "PAUSE", icon: "II", color: "#ffa726" },
                            { label: "STOP", icon: "■", color: "#ef5350" }
                        ]
                        delegate: Column {
                            spacing: 3
                            Rectangle {
                                width: 30 * window.uiScale
                                height: 22 * window.uiScale
                                color: "#2e2e2e"
                                radius: 2
                                border.color: "#444"
                                border.width: 1
                                anchors.horizontalCenter: parent.horizontalCenter

                                MouseArea {
                                    anchors.fill: parent
                                    onClicked: {
                                        if (modelData.label === "START") {
                                            isTraining = true
                                            statusText = "ACTIVE"
                                        } else if (modelData.label === "PAUSE") {
                                            isTraining = false
                                            statusText = "PAUSED"
                                        } else if (modelData.label === "STOP") {
                                            isTraining = false
                                            elapsedSeconds = 0
                                            statusText = "STANDBY"
                                        }
                                    }
                                }

                                Text {
                                    anchors.centerIn: parent
                                    text: modelData.icon
                                    color: modelData.color
                                    font.pixelSize: Math.max(8, 10 * window.uiScale)
                                }
                            }
                            Text {
                                text: modelData.label
                                color: "#9e9e9e"
                                font.pixelSize: Math.max(8, 10 * window.uiScale)
                                font.bold: true
                                anchors.horizontalCenter: parent.horizontalCenter
                            }
                        }
                    }
                }
            }
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: 4

            Text {
                text: "CONTROL MODE"
                color: "#4CAF50"
                font.bold: true
                font.pixelSize: Math.max(10, 12 * window.uiScale)
                font.family: "Segoe UI"
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 40 * window.uiScale
                Layout.minimumHeight: 32
                color: "#4CAF50"
                radius: height / 2
                border.color: "#4CAF50"

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12

                    Rectangle {
                        width: 24 * window.uiScale; height: 24 * window.uiScale; radius: width / 2
                        color: "#81c784"
                        Text { anchors.centerIn: parent; text: "🎮"; font.pixelSize: 12 * window.uiScale }
                    }

                    Text {
                        Layout.fillWidth: true
                        text: "REMOTE CONTROL"; color: "white"; font.bold: true; font.pixelSize: Math.max(10, 12 * window.uiScale)
                        Layout.leftMargin: 8
                    }

                    Rectangle {
                        width: 14; height: 14; radius: 7
                        border.color: "white"; border.width: 2
                        color: "transparent"
                        Rectangle { width: 8; height: 8; radius: 4; color: "white"; anchors.centerIn: parent }
                    }
                }
            }

            Rectangle {
                Layout.fillWidth: true
                Layout.preferredHeight: 40 * window.uiScale
                Layout.minimumHeight: 32
                color: "transparent"
                radius: height / 2
                border.color: "#333"
                border.width: 1

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12

                    Rectangle {
                        width: 24 * window.uiScale; height: 24 * window.uiScale; radius: width / 2
                        color: "#333"
                        Text { anchors.centerIn: parent; text: "🤖"; font.pixelSize: 12 * window.uiScale }
                    }

                    Text {
                        Layout.fillWidth: true
                        text: "AUTONOMOUS"; color: "#757575"; font.bold: true; font.pixelSize: Math.max(10, 12 * window.uiScale)
                        Layout.leftMargin: 8
                    }

                    Rectangle {
                        width: 14; height: 14; radius: 7
                        border.color: "#757575"; border.width: 1
                        color: "transparent"
                    }
                }
            }
        }

        Text {
            text: "● JOYSTICK: DISCONNECTED"
            color: "#e53935"
            font.pixelSize: Math.max(8, 9 * window.uiScale)
            font.bold: true
            Layout.alignment: Qt.AlignHCenter
            Layout.topMargin: 2
        }

        ColumnLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.minimumHeight: 140 
            spacing: 6

            RowLayout {
                Layout.fillWidth: true
                spacing: 4

                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: 32 * window.uiScale; Layout.minimumHeight: 26
                    color: "#4CAF50"; radius: 4
                    Text { text: "LOW"; color: "white"; anchors.centerIn: parent; font.bold: true; font.pixelSize: Math.max(10, 12 * window.uiScale) }
                }
                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: 32 * window.uiScale; Layout.minimumHeight: 26
                    color: "#2d2d2d"; border.color: "#444"; radius: 4
                    Text { text: "MEDIUM"; color: "#9e9e9e"; anchors.centerIn: parent; font.bold: true; font.pixelSize: Math.max(10, 12 * window.uiScale) }
                }
                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: 32 * window.uiScale; Layout.minimumHeight: 26
                    color: "#2d2d2d"; border.color: "#444"; radius: 4
                    Text { text: "HIGH"; color: "#9e9e9e"; anchors.centerIn: parent; font.bold: true; font.pixelSize: Math.max(10, 12 * window.uiScale) }
                }
            }

            GridLayout {
                columns: 3
                rowSpacing: 4 * window.uiScale
                columnSpacing: 4 * window.uiScale
                Layout.alignment: Qt.AlignHCenter
                Layout.fillWidth: true
                Layout.fillHeight: true

                property real btnHeight: Math.max(40, 56 * window.uiScale) 

                Item { Layout.fillWidth: true; Layout.preferredHeight: parent.btnHeight }
                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: parent.btnHeight
                    color: "#2d2d2d"; border.color: "#333"; radius: 4
                    Text { text: "↑"; color: "white"; anchors.centerIn: parent; font.pixelSize: Math.max(18, 24 * window.uiScale) }
                }
                Item { Layout.fillWidth: true; Layout.preferredHeight: parent.btnHeight }

                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: parent.btnHeight
                    color: "#2d2d2d"; border.color: "#333"; radius: 4
                    Text { text: "←"; color: "white"; anchors.centerIn: parent; font.pixelSize: Math.max(18, 24 * window.uiScale) }
                }
                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: parent.btnHeight
                    color: "#d32f2f"; radius: 4
                    Rectangle { width: 12; height: 12; color: "white"; anchors.centerIn: parent }
                }
                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: parent.btnHeight
                    color: "#2d2d2d"; border.color: "#333"; radius: 4
                    Text { text: "→"; color: "white"; anchors.centerIn: parent; font.pixelSize: Math.max(18, 24 * window.uiScale) }
                }

                Item { Layout.fillWidth: true; Layout.preferredHeight: parent.btnHeight }
                Rectangle {
                    Layout.fillWidth: true; Layout.preferredHeight: parent.btnHeight
                    color: "#2d2d2d"; border.color: "#333"; radius: 4
                    Text { text: "↓"; color: "white"; anchors.centerIn: parent; font.pixelSize: Math.max(18, 24 * window.uiScale) }
                }
                Item { Layout.fillWidth: true; Layout.preferredHeight: parent.btnHeight }
            }
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.leftMargin: 6
            Layout.rightMargin: 6
            spacing: 8
            Layout.topMargin: 4

            Text { 
                text: "MANNEQUIN POSITION"
                color: "#4CAF50"
                font.bold: true
                font.pixelSize: Math.max(9, 11 * window.uiScale)
            }
            
            Item { Layout.fillWidth: true }

            Rectangle {
                width: 70; height: 26
                color: "#2d2d2d"
                radius: 4
                border.color: "#333"

                Text { 
                    anchors.centerIn: parent
                    text: "LOWERED"
                    color: "#ef5350"
                    font.pixelSize: 9
                    font.bold: true
                }
            }
        }

        Item { Layout.fillHeight: true; Layout.maximumHeight: 4 }
    }
}
