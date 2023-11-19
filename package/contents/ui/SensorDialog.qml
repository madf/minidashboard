import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Layouts 1.15

QQC2.Dialog {
    property var index
    property string type
    property alias name: sensorName.text
    property alias label: sensorLabel.text
    property alias path: sensorPath.text
    property alias unit: sensorUnit.text
    property alias divisor: sensorDivisor.text
    property alias precision: sensorPrecision.text
    property alias interval: sensorInterval.text

    signal done(int index, var object)

    onAccepted: done(index, {type: type, name: name, label: label, path: "", unit: "%", divisor: 1000, precision: 0, interval: interval})

    function add(object) {
        index = undefined
        type = object.type
        label = ""
        path = ""
        unit = ""
        divisor = 1000
        precision = 1
        interval = 1
        title = "Add sensor"
        open()
    }

    function edit(i, object) {
        index = i
        type = object.type
        name = object.name
        label = object.label
        path = object.path
        unit = object.unit
        divisor = object.divisor
        precision = object.precision
        interval = object.interval
        title = "Edit sensor"
        open()
    }

    title: "Add sensor"
    standardButtons: QQC2.Dialog.Ok | QQC2.Dialog.Cancel

    GridLayout {
        columns: 2
        anchors.fill: parent
        anchors.margins: 10
        rowSpacing: 10
        columnSpacing: 10

        QQC2.Label {
            text: "Name:"
        }
        QQC2.TextField {
            id: sensorName
            Layout.fillWidth: true
        }

        QQC2.Label {
            text: "Label:"
        }
        QQC2.TextField {
            id: sensorLabel
            Layout.fillWidth: true
        }

        QQC2.Label {
            text: "Path:"
        }
        QQC2.TextField {
            id: sensorPath
            Layout.fillWidth: true
        }

        QQC2.Label {
            text: "Unit:"
        }
        QQC2.TextField {
            id: sensorUnit
            Layout.fillWidth: true
        }

        QQC2.Label {
            text: "Divisor:"
        }
        QQC2.TextField {
            id: sensorDivisor
            text: "1000"
            Layout.fillWidth: true
            validator: IntValidator { bottom: 1 }
        }

        QQC2.Label {
            text: "Precision:"
        }
        QQC2.TextField {
            id: sensorPrecision
            text: "1"
            Layout.fillWidth: true
            validator: IntValidator { bottom: 0 }
        }

        QQC2.Label {
            text: "Query interval:"
        }
        QQC2.TextField {
            id: sensorInterval
            text: "1"
            Layout.fillWidth: true
            validator: IntValidator { bottom: 1 }
        }
    }
}
