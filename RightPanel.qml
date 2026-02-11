import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Rectangle {
    id: root
    color: "#1e1e1e"

    property int batteryLevel: 100
    property double lat: 0.0000
    property double lon: 0.0000
    property double speed: 0.0
    property double yaw: 0.0
    property double pitch: 0.0
    property double roll: 0.0
    property var lidar: {"front": 0, "left": 0, "right": 0, "rear": 0, "closest": 0}
    property int linkQuality: 85
    property int signalBars: 4

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            if (batteryLevel > 0 && Math.random() > 0.95) batteryLevel -= 1
            
            lat += (Math.random() - 0.5) * 0.0001
            lon += (Math.random() - 0.5) * 0.0001
            
            speed = Math.max(0, speed + (Math.random() - 0.45) * 2)
            
            yaw = (yaw + (Math.random() - 0.5) * 5) % 360
            pitch = (pitch + (Math.random() - 0.5) * 2) % 360
            roll = (roll + (Math.random() - 0.5) * 2) % 360
            
            lidar.front = Math.floor(Math.random() * 10)
            lidar.left = Math.floor(Math.random() * 10)
            lidar.right = Math.floor(Math.random() * 10)
            lidar.rear = Math.floor(Math.random() * 10)
            lidar.closest = Math.min(lidar.front, lidar.left, lidar.right, lidar.rear)
            
            linkQuality = Math.max(0, Math.min(100, linkQuality + (Math.random() - 0.5) * 5))
            signalBars = Math.ceil(linkQuality / 20)
            
            lidarChanged()
        }
    }

    ScrollView {
        anchors.fill: parent
        ScrollBar.vertical.policy: ScrollBar.AsNeeded
        contentWidth: availableWidth
        clip: true

        ColumnLayout {
            width: root.width - (root.width > 0 ? 16 : 0)
            height: root.height
            spacing: 14
            anchors.horizontalCenter: parent.horizontalCenter

            Item { height: 10 }

            ColumnLayout {
                Layout.fillWidth: true
                Layout.leftMargin: 12
                Layout.rightMargin: 12
                spacing: 2
                
                RowLayout {
                    Layout.fillWidth: true
                    Text {
                        text: "LIVE VIDEO FEED" 
                        color: "#4CAF50"
                        font.bold: true
                        font.pixelSize: 16 * window.uiScale
                        font.family: "Segoe UI"
                    }
                    Item { Layout.fillWidth: true }
                }

                Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 300 * window.uiScale
                    color: "black"
                    border.color: "#333"
                    border.width: 1
                    radius: 2
                    
                    Item {
                        anchors.fill: parent
                        anchors.margins: 1
                        
                        Rectangle { anchors.centerIn: parent; width: 20; height: 1; color: "#333" }
                        Rectangle { anchors.centerIn: parent; width: 1; height: 20; color: "#333" }
                        
                        Text {
                            anchors.centerIn: parent
                            text: "NO SIGNAL"
                            color: "#555"
                            font.pixelSize: 14
                            font.family: "Segoe UI"
                        }
                    }

                    RowLayout {
                        anchors.top: parent.top
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.margins: 8
                        
                        Text {
                            text: "UNIT-01 - CAM"
                            color: "white"
                            font.pixelSize: 11
                            font.bold: true
                            font.family: "Segoe UI"
                        }
                        
                        Item { Layout.fillWidth: true }
                        
                         Row {
                            spacing: 6
                            Rectangle {
                                width: 8; height: 8; radius: 4
                                color: "#d32f2f"
                                anchors.verticalCenter: parent.verticalCenter
                                SequentialAnimation on opacity {
                                    loops: Animation.Infinite
                                    PropertyAnimation { to: 0.2; duration: 800 }
                                    PropertyAnimation { to: 1.0; duration: 800 }
                                }
                            }
                            Text { text: "LIVE"; color: "#d32f2f"; font.pixelSize: 10; font.bold: true; font.family: "Segoe UI" }
                        }
                    }
                    
                    Item {
                        anchors.fill: parent
                        anchors.margins: 4
                        Rectangle { width: 10; height: 2; color: "#4CAF50"; anchors.top: parent.top; anchors.left: parent.left }
                        Rectangle { width: 2; height: 10; color: "#4CAF50"; anchors.top: parent.top; anchors.left: parent.left }
                        Rectangle { width: 10; height: 2; color: "#4CAF50"; anchors.bottom: parent.bottom; anchors.right: parent.right }
                        Rectangle { width: 2; height: 10; color: "#4CAF50"; anchors.bottom: parent.bottom; anchors.right: parent.right }
                    }
                }
            }

            Item { height: 4 }

            Text {
                text: "PLATFORM TELEMETRY"
                color: "#4CAF50"
                font.bold: true
                font.pixelSize: 12
                font.family: "Segoe UI"
                Layout.alignment: Qt.AlignHCenter
                Layout.topMargin: 4
                Layout.bottomMargin: 4
            }

            GridLayout {
                columns: root.width > 500 * window.uiScale ? 3 : (root.width > 300 * window.uiScale ? 2 : 1)
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.leftMargin: 12 * window.uiScale
                Layout.rightMargin: 12 * window.uiScale
                rowSpacing: 8 * window.uiScale
                columnSpacing: 8 * window.uiScale

                TelemetryBox {
                    title: "BATTERY"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 8
                        
                        Text { 
                            text: batteryLevel + "%" 
                            color: "white" 
                            font.pixelSize: 24 
                            font.bold: true 
                            Layout.alignment: Qt.AlignHCenter 
                        }
                        
                        Text { 
                            text: "EST. RUNTIME: 3h 00m" 
                            color: "#4CAF50"
                            font.pixelSize: 10 
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter 
                        }
                    }
                }

                TelemetryBox {
                    title: "POSITION"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                     ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 4
                        
                        Item { Layout.fillHeight: true }
                        
                        RowLayout {
                             Layout.fillWidth: true
                             Text { text: "LAT:"; color: "white"; font.pixelSize: 12; font.bold: true }
                             Item { Layout.fillWidth: true }
                             Text { text: lat.toFixed(4) + "° N"; color: "white"; font.pixelSize: 12; font.family: "Consolas" }
                        }
                        RowLayout {
                             Layout.fillWidth: true
                             Text { text: "LON:"; color: "white"; font.pixelSize: 12; font.bold: true }
                             Item { Layout.fillWidth: true }
                             Text { text: lon.toFixed(4) + "° E"; color: "white"; font.pixelSize: 12; font.family: "Consolas" }
                        }
                        
                        Item { Layout.fillHeight: true }

                         Rectangle {
                            Layout.alignment: Qt.AlignHCenter
                            width: 24; height: 24; radius: 12
                            color: "transparent"
                            border.color: "#4CAF50"
                            border.width: 1
                            Text { anchors.centerIn: parent; text: "GPS"; color: "#4CAF50"; font.pixelSize: 8; font.bold: true }
                        }
                        
                        Item { height: 4 }
                    }
                }
                
                TelemetryBox {
                    title: "TRAINING FEEDBACK"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 8
                        
                         Rectangle {
                            Layout.alignment: Qt.AlignHCenter
                            width: 80
                            height: 24
                            radius: 12
                            color: "#1b5e20"
                            border.color: "#388e3c"
                            Text {
                                anchors.centerIn: parent
                                text: "NO HIT"
                                color: "white"
                                font.pixelSize: 10
                                font.bold: true
                            }
                        }

                        Text { 
                            text: "No of Hits: 0"
                            color: "white"
                            font.pixelSize: 12
                            font.bold: true
                            Layout.alignment: Qt.AlignHCenter
                        }
                        
                        Rectangle {
                            Layout.fillWidth: true
                            Layout.preferredHeight: 14
                            color: "#333"
                            radius: 7
                            Text { anchors.centerIn: parent; text: "0%"; color: "white"; font.pixelSize: 9 }
                        }
                        
                        Item { Layout.fillHeight: true }

                        Text { text: "MANNEQUIN POSITION"; color: "white"; font.pixelSize: 9; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                        Text { text: "DOWN"; color: "#26c6da"; font.pixelSize: 14; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                    }
                }

                 TelemetryBox {
                    title: "LIDAR SENSOR"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                     ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 2
                        
                        GridLayout {
                            columns: 2
                            Layout.fillWidth: true
                            rowSpacing: 2
                            Text { text: "Front: " + lidar.front + "m"; color: "white"; font.pixelSize: 9 }
                            Text { text: "Left: " + lidar.left + "m"; color: "white"; font.pixelSize: 9; Layout.alignment: Qt.AlignRight }
                            Text { text: "Right: " + lidar.right + "m"; color: "white"; font.pixelSize: 9 }
                            Text { text: "Rear: " + lidar.rear + "m"; color: "white"; font.pixelSize: 9; Layout.alignment: Qt.AlignRight }
                        }
                        Text { text: "Closest: " + lidar.closest + " m"; color: "#ef5350"; font.pixelSize: 10; font.bold: true; Layout.alignment: Qt.AlignHCenter }

                        Item { height: 2 } 
                        
                        Text { text: "ULTRASONIC SENSOR"; color: "#4CAF50"; font.pixelSize: 9; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                        
                        GridLayout {
                             columns: 2
                             Layout.fillWidth: true
                             Text { text: "Front:"; color: "white"; font.pixelSize: 10; font.bold: true }
                             Text { text: "Back:"; color: "white"; font.pixelSize: 10; font.bold: true; Layout.alignment: Qt.AlignRight }
                             
                             Text { text: "250 cm"; color: "white"; font.pixelSize: 10 }
                             Text { text: "250 cm"; color: "white"; font.pixelSize: 10; Layout.alignment: Qt.AlignRight }
                        }
                    }
                }
                
                TelemetryBox {
                    title: "SPEED & ORIENTATION"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                    ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 8
                        spacing: 0
                        
                        Item { Layout.fillHeight: true }

                        Item {
                             Layout.alignment: Qt.AlignHCenter
                             width: 60; height: 60
                             
                             Rectangle {
                                 anchors.centerIn: parent
                                 width: 50; height: 50; radius: 25
                                 color: "transparent"
                                 border.color: "#333"; border.width: 4
                             }
                             Rectangle {
                                 width: 50; height: 25; radius: 25
                                 color: "transparent"
                                 border.color: "#4CAF50"; border.width: 4
                                 anchors.centerIn: parent
                                 clip: true
                                 visible: false
                             }
                             
                             Text { 
                                 anchors.centerIn: parent
                                 text: speed.toFixed(1) + " km/h"
                                 color: "#4CAF50"
                                 font.pixelSize: 10; font.bold: true
                            }
                        }
                        
                        Item { Layout.fillHeight: true }
                        
                         RowLayout {
                             Layout.fillWidth: true
                             Layout.alignment: Qt.AlignHCenter
                             spacing: 8
                             Text { text: "YAW"; color: "#03a9f4"; font.pixelSize: 9; font.bold: true }
                             Text { text: "PITCH"; color: "#4CAF50"; font.pixelSize: 9; font.bold: true }
                             Text { text: "ROLL"; color: "#ef5350"; font.pixelSize: 9; font.bold: true }
                        }
                        
                         RowLayout {
                             Layout.fillWidth: true
                             Layout.alignment: Qt.AlignHCenter
                             spacing: 8
                             Text { text: yaw.toFixed(1) + "°"; color: "white"; font.pixelSize: 10; font.bold: true }
                             Text { text: pitch.toFixed(1) + "°"; color: "white"; font.pixelSize: 10; font.bold: true }
                             Text { text: roll.toFixed(1) + "°"; color: "white"; font.pixelSize: 10; font.bold: true }
                        }
                        
                        Item { height: 8 }
                    }
                }
                
                TelemetryBox {
                    title: "LINK & SYSTEM"
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    
                     ColumnLayout {
                        anchors.fill: parent
                        anchors.margins: 12
                        spacing: 4
                        
                        Text { text: "LINK QUALITY: " + linkQuality.toFixed(0) + "%"; color: "white"; font.pixelSize: 10; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                        
                        Row {
                            Layout.alignment: Qt.AlignHCenter
                            spacing: 3
                            Repeater {
                                model: 5
                                Rectangle {
                                    width: 6
                                    height: 10 + (index * 4)
                                    color: index < signalBars ? "#4CAF50" : "#333"
                                    radius: 1
                                    anchors.bottom: parent.bottom
                                }
                            }
                        }
                        
                        Item { Layout.fillHeight: true }

                        Text { text: "SYSTEM MODE"; color: "white"; font.pixelSize: 10; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                        
                        Rectangle {
                             Layout.alignment: Qt.AlignHCenter
                             width: 40; height: 16
                             radius: 8
                             color: "transparent"
                             border.color: "#fbc02d"
                             Text { 
                                 anchors.centerIn: parent
                                 text: "MANUAL"
                                 color: "#fbc02d"
                                 font.pixelSize: 8
                                 font.bold: true 
                            }
                        }
                        
                        Item { height: 8 }
                    }
                }
            }

            Item { height: 10 }
        }
    }
}
