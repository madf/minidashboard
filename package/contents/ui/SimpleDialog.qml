import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Layouts 1.15

QQC2.Dialog {
    property var index
    property string type
    property string name
    property alias label: sensorLabel.text
    property alias interval: sensorInterval.text

    signal done(int index, var object)

    onAccepted: done(index, {type: type, name: name, label: label, path: "", unit: "%", divisor: 1000, precision: 0, interval: interval})

    function add(object) {
        console.log("Adding " + JSON.stringify(object))
        index = undefined
        type = object.type
        name = object.name
        label = ""
        interval = 1
        title = "Add sensor"
        open()
    }

    function edit(i, object) {
        console.log("Editing " + JSON.stringify(object) + " at " + index)
        index = i
        type = object.type
        name = object.name
        label = object.label
        interval = object.interval
        title = "Edit sensor"
        open()
    }

    standardButtons: QQC2.Dialog.Ok | QQC2.Dialog.Cancel

    GridLayout {
        columns: 2
        anchors.fill: parent
        anchors.margins: 10
        rowSpacing: 10
        columnSpacing: 10

        QQC2.Label {
            text: "Type:"
        }
        QQC2.Label {
            text: type
        }

        QQC2.Label {
            text: "Name:"
        }
        QQC2.Label {
            text: name
        }

        QQC2.Label {
            text: "Label:"
        }
        QQC2.TextField {
            id: sensorLabel
            Layout.fillWidth: true
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
