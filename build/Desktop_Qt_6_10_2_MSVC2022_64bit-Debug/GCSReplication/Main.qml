import QtQuick
import QtQuick.Controls
import QtQuick.Layouts

ApplicationWindow {
    id: window
    visible: true
    width: 1280
    height: 800
    minimumWidth: 640
    minimumHeight: 480
    title: "MARTIN GCS"
    color: "#121212"

    property real uiScale: Math.max(0.8, Math.min(1.5, window.height / 900))

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        TopBar {
            Layout.fillWidth: true
            Layout.preferredHeight: 56
        }

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 2

            LeftPanel {
                Layout.preferredWidth: 320
                Layout.minimumWidth: 280
                Layout.fillHeight: true
            }

            MapPanel {
                Layout.fillWidth: true
                Layout.fillHeight: true
            }

            RightPanel {
                Layout.preferredWidth: 480
                Layout.minimumWidth: 320
                Layout.fillHeight: true
            }
        }
    }
}
