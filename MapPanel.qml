import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import QtQuick.Shapes

Rectangle {
    id: root
    color: "#e0e0e0"
    
    ColumnLayout {
        anchors.fill: parent
        spacing: 0
        
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: topFlow.implicitHeight + 16
            color: "white"
            clip: true
            
            Flow {
                id: topFlow
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 8
                spacing: 8 * window.uiScale
                
                ComboBox {
                    model: ["hyd.mbtiles"]
                    currentIndex: 0
                    Layout.preferredWidth: 140 * window.uiScale
                    implicitHeight: 32 * window.uiScale
                    
                    background: Rectangle {
                        color: "#f5f5f5"
                        border.color: "#e0e0e0"
                        radius: 4
                    }
                    contentItem: Text {
                        leftPadding: 10
                        text: parent.displayText
                        color: "#333"
                        font.pixelSize: 11 * window.uiScale
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                
                Button {
                    text: "Load Map"
                    implicitHeight: 32 * window.uiScale
                    implicitWidth: 80 * window.uiScale
                    background: Rectangle { color: "#2196F3"; radius: 4 }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 10 * window.uiScale
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }
                
                Button {
                    text: "↺"
                    implicitWidth: 32 * window.uiScale
                    implicitHeight: 32 * window.uiScale
                    background: Rectangle { color: "#4CAF50"; radius: 4 }
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        font.pixelSize: 16 * window.uiScale
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                }

                Button {
                    implicitHeight: 32 * window.uiScale
                    implicitWidth: 110 * window.uiScale
                    background: Rectangle { color: "#4CAF50"; radius: 4 }
                    contentItem: RowLayout {
                        spacing: 4
                        Text { text: "⦿"; color: "white"; font.pixelSize: 14 * window.uiScale; Layout.leftMargin: 8 }
                        Text {
                            text: "USB Upload"
                            color: "white"
                            font.pixelSize: 10 * window.uiScale
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
                
               Button {
                    implicitHeight: 32 * window.uiScale
                    implicitWidth: 140 * window.uiScale
                    background: Rectangle { color: "#795548"; radius: 4 }
                    contentItem: RowLayout {
                        spacing: 4
                        Text { text: "🗑"; color: "white"; font.pixelSize: 14 * window.uiScale; Layout.leftMargin: 8 }
                        Text {
                            text: "Clear Waypoints"
                            color: "white"
                            font.pixelSize: 10 * window.uiScale
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
                
                Button {
                    implicitHeight: 32 * window.uiScale
                    implicitWidth: 130 * window.uiScale
                    background: Rectangle { color: "#4CAF50"; radius: 4 }
                    contentItem: RowLayout {
                        spacing: 4
                        Text { text: "🛰"; color: "white"; font.pixelSize: 14 * window.uiScale; Layout.leftMargin: 8 }
                        Text {
                            text: "Send Waypoints"
                            color: "white"
                            font.pixelSize: 10 * window.uiScale
                            font.bold: true
                            verticalAlignment: Text.AlignVCenter
                        }
                    }
                }
            }
        }

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: statusFlow.implicitHeight + 12
            color: "#f5f5f5"
            
            Flow {
                id: statusFlow
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.verticalCenter: parent.verticalCenter
                anchors.margins: 8
                spacing: 12 * window.uiScale
                
                Rectangle {
                    implicitWidth: gpsText.implicitWidth + 16
                    implicitHeight: 24 * window.uiScale
                    color: "#e8f5e9"
                    radius: 4
                    Text {
                        id: gpsText
                        anchors.centerIn: parent
                        text: "GPS: Waiting for telemetry data..."
                        color: "#2e7d32"
                        font.pixelSize: 10 * window.uiScale
                        font.bold: true
                    }
                }
                
                Rectangle {
                    implicitWidth: waypointsText.implicitWidth + 16
                    implicitHeight: 24 * window.uiScale
                    color: "#fff3e0"
                    radius: 4
                    Text {
                        id: waypointsText
                        anchors.centerIn: parent
                        text: "Waypoints: 0 points | Mode: OFF"
                        color: "#e65100"
                        font.pixelSize: 10 * window.uiScale
                        font.bold: true
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true
            
            Rectangle {
                anchors.fill: parent
                color: "#e1e2e1"
                clip: true
                
                Shape {
                    anchors.fill: parent
                    Repeater {
                        model: parent.width / 100
                        ShapePath {
                            strokeColor: "white"
                            strokeWidth: 2
                            startX: index * 100; startY: 0
                            PathLine { x: index * 100; y: parent.height }
                        }
                    }
                    Repeater {
                        model: parent.height / 100
                        ShapePath {
                            strokeColor: "white"
                            strokeWidth: 2
                            startX: 0; startY: index * 100
                            PathLine { x: parent.width; y: index * 100 }
                        }
                    }
                }
                
                Rectangle {
                    x: 100; y: 150
                    width: 200; height: 150
                    color: "#c8e6c9"
                }
                Rectangle {
                    x: 400; y: 300
                    width: 250; height: 200
                    color: "#c8e6c9"
                }
                
                 Rectangle { x: 350; y: 100; width: 60; height: 60; color: "#d7ccc8" }
                 Rectangle { x: 420; y: 100; width: 80; height: 100; color: "#d7ccc8" }
                  Rectangle { x: 50; y: 400; width: 50; height: 50; color: "#d7ccc8" }
            }

            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 12
                width: 40
                height: 200
                color: "white"
                radius: 4
                border.color: "#c0c0c0"
                border.width: 1

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    spacing: 0
                    
                    Rectangle {
                        width: 40
                        height: 40
                        color: "transparent"
                        Canvas {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.strokeStyle = "#555";
                                ctx.lineWidth = 2.5;
                                ctx.lineCap = "round";
                                ctx.lineJoin = "miter";
                                ctx.beginPath();
                                ctx.moveTo(6, 18);
                                ctx.lineTo(18, 6);
                                ctx.moveTo(14, 6);
                                ctx.lineTo(18, 6);
                                ctx.lineTo(18, 10);
                                ctx.stroke();
                            }
                        }
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width - 8
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 1
                            color: "#e0e0e0"
                        }
                    }
                    
                    Rectangle {
                        width: 40
                        height: 40
                        color: "transparent"
                        Canvas {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.fillStyle = "#555";
                                ctx.beginPath();
                                var centerX = 12;
                                var centerY = 13;
                                var radius = 9;
                                for (var i = 0; i < 5; i++) {
                                    var angle = (Math.PI * 2 / 5) * i - Math.PI / 2;
                                    var x = centerX + radius * Math.cos(angle);
                                    var y = centerY + radius * Math.sin(angle);
                                    if (i === 0) ctx.moveTo(x, y);
                                    else ctx.lineTo(x, y);
                                }
                                ctx.closePath();
                                ctx.fill();
                            }
                        }
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width - 8
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 1
                            color: "#e0e0e0"
                        }
                    }
                    
                    Rectangle {
                        width: 40
                        height: 40
                        color: "transparent"
                        Rectangle {
                            anchors.centerIn: parent
                            width: 18
                            height: 18
                            color: "#555"
                            radius: 2
                        }
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width - 8
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 1
                            color: "#e0e0e0"
                        }
                    }
                    
                    Rectangle {
                        width: 40
                        height: 40
                        color: "transparent"
                        Rectangle {
                            anchors.centerIn: parent
                            width: 18
                            height: 18
                            radius: 9
                            color: "#555"
                        }
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width - 8
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 1
                            color: "#e0e0e0"
                        }
                    }
                    
                    Rectangle {
                        width: 40
                        height: 40
                        color: "transparent"
                        Rectangle {
                            anchors.centerIn: parent
                            width: 18
                            height: 18
                            radius: 9
                            color: "transparent"
                            border.color: "#555"
                            border.width: 2.5
                        }
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width - 8
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 1
                            color: "#e0e0e0"
                        }
                    }
                }
            }
            
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 224
                anchors.margins: 12
                width: 40
                height: 80
                color: "white"
                radius: 4
                border.color: "#c0c0c0"
                border.width: 1

                Column {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: parent.top
                    anchors.topMargin: 0
                    spacing: 0
                    
                    Rectangle {
                        width: 40
                        height: 40
                        color: "transparent"
                        Canvas {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.strokeStyle = "#555";
                                ctx.lineWidth = 2;
                                ctx.beginPath();
                                ctx.rect(6, 6, 12, 12);
                                ctx.moveTo(14, 10);
                                ctx.lineTo(18, 6);
                                ctx.moveTo(16, 6);
                                ctx.lineTo(18, 6);
                                ctx.lineTo(18, 8);
                                ctx.stroke();
                            }
                        }
                        Rectangle {
                            anchors.bottom: parent.bottom
                            width: parent.width - 8
                            anchors.horizontalCenter: parent.horizontalCenter
                            height: 1
                            color: "#e0e0e0"
                        }
                    }
                    
                    Rectangle {
                        width: 40
                        height: 40
                        color: "transparent"
                        Canvas {
                            anchors.centerIn: parent
                            width: 24
                            height: 24
                            onPaint: {
                                var ctx = getContext("2d");
                                ctx.strokeStyle = "#555";
                                ctx.lineWidth = 2;
                                ctx.lineCap = "round";
                                ctx.lineJoin = "round";
                                ctx.beginPath();
                                ctx.moveTo(7, 8);
                                ctx.lineTo(7, 19);
                                ctx.lineTo(17, 19);
                                ctx.lineTo(17, 8);
                                ctx.stroke();
                                ctx.beginPath();
                                ctx.moveTo(5, 8);
                                ctx.lineTo(19, 8);
                                ctx.stroke();
                                ctx.beginPath();
                                ctx.moveTo(10, 5);
                                ctx.lineTo(14, 5);
                                ctx.stroke();
                                ctx.beginPath();
                                ctx.moveTo(10, 11);
                                ctx.lineTo(10, 16);
                                ctx.moveTo(14, 11);
                                ctx.lineTo(14, 16);
                                ctx.stroke();
                            }
                        }
                    }
                }
            }
            
            Rectangle {
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.topMargin: 316
                anchors.margins: 12
                width: 40
                height: 52
                color: "white"
                radius: 4
                border.color: "#c0c0c0"
                border.width: 1
            }
            
             Rectangle {
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.margins: 12
                width: 32
                height: 60
                color: "white"
                radius: 4
                border.color: "#bdbdbd"
                border.width: 1

                Column {
                    anchors.centerIn: parent
                    spacing: 0
                    Item {
                        width: 30; height: 29
                        Text { anchors.centerIn: parent; text: "+"; color: "#555"; font.pixelSize: 18 }
                    }
                     Rectangle { width: 30; height: 1; color: "#eee" }
                    Item {
                        width: 30; height: 29
                        Text { anchors.centerIn: parent; text: "−"; color: "#555"; font.pixelSize: 18 }
                    }
                }
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.margins: 4
                width: 60
                height: 34
                color: "white"
                border.color: "#333"
                border.width: 1
                
                Column {
                    anchors.centerIn: parent
                    spacing: 2
                    
                    Text { 
                        text: "30 m"
                        color: "black"
                        font.pixelSize: 10
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    
                    Rectangle {
                        width: 50
                        height: 1
                        color: "#333"
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                    
                    Text { 
                        text: "100 ft"
                        color: "black"
                        font.pixelSize: 10
                        font.bold: true
                        anchors.horizontalCenter: parent.horizontalCenter
                    }
                }
            }
        }
    }
}
