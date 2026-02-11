import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    property string title: ""
    default property alias content: container.data

    color: "#2b2b2b"
    border.color: "#333"
    border.width: 1
    radius: 4

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 6
        spacing: 2
        
        Text {
            text: root.title
            color: "#4CAF50"
            font.pixelSize: 10 * window.uiScale
            font.bold: true
            font.family: "Segoe UI"
            font.letterSpacing: 1
            Layout.alignment: Qt.AlignHCenter
        }
        
        Rectangle {
            Layout.fillWidth: true
            height: 1
            color: "#222"
            visible: false
        }
        
        Item {
            id: container
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
