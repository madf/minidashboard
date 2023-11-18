import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Layouts 1.15

QQC2.Dialog {
    property string type
    property alias name: sensorName.text
    property alias interval: sensorInterval.text

    title: "Add sensor"
    standardButtons: QQC2.Dialog.Ok | QQC2.Dialog.Cancel

    GridLayout {
        columns: 2
        anchors.fill: parent
        anchors.margins: 10
        rowSpacing: 10
        columnSpacing: 10

        QQC2.Label {
            Layout.rowSpan: 2
            text: "Type: " + type
        }

        QQC2.Label {
            text: "Name:"
        }
        QQC2.TextField {
            id: sensorName
            Layout.fillWidth: true
        }

        QQC2.Label {
            text: "Query interval:"
        }
        QQC2.TextField {
            id: sensorInterval
            text: "1"
            Layout.fillWidth: true
        }
    }
}
