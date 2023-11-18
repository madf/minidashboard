import QtQuick 2.5
import QtQuick.Controls 2.5 as QQC2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami 2.5 as Kirigami

ColumnLayout {
    id: root

    signal configurationChanged

    property var cfg_sensorList: []

    function addSensor(object) {
        sensorModel.appendRow( object )
        cfg_sensorList.push( JSON.stringify(object) )
        configurationChanged();
    }

    function removeSensor(index) {
        if(sensorModel.count > 0) {
            sensorModel.removeRow(index, 1)
            cfg_sensorList.splice(index,1)
            configurationChanged();
        }
    }

    Component.onCompleted: {
        // Load the list back in
        var list = plasmoid.configuration.sensorList
        cfg_sensorList = []
        for(var i in list) {
            addSensor( JSON.parse(list[i]) )
        }
    }

    SensorDialog {
        id: sensorDialog
        visible: false

        onAccepted: addSensor({type: type, name: name})
    }

    SimpleDialog {
        id: simpleDialog
        visible: false

        onAccepted: addSensor({type: type, name: name})
    }

    TableModel {
        id: sensorModel

        TableModelColumn { display: "Tame" }
        TableModelColumn { display: "Name" }
        TableModelColumn { display: "Path" }
        TableModelColumn { display: "Unit" }
        TableModelColumn { display: "Divisor" }
        TableModelColumn { display: "Precision" }
        TableModelColumn { display: "Interval" }
    }

    QQC2.ScrollView {
        Layout.fillWidth: true
        Layout.fillHeight: true
        Component.onCompleted: background.visible = true;

        ListView {
            id: sensorList

            anchors.margins: 4
            model: sensorModel

            delegate: Kirigami.SwipeListItem {
                id: sensorDelegate

                width: sensorList.width
                height: paintedHeight;

                QQC2.Label {
                    Layout.fillWidth: true
                    text: "Type: " + model.type + ", Name: " + model.name
                }

                actions: [
                    Kirigami.Action {
                        iconName: "list-remove"
                        tooltip: i18nd("plasma_wallpaper_org.kde.image", "Remove path")
                        onTriggered: removeSensor(model.index)
                    }
                ]
            }
        }
    }

    RowLayout {
        Layout.fillWidth: true

        QQC2.Button {
            id: addSensorButton
            icon.name: "folder-new"
            text: i18nc("@action:button", "Add Sensor…")
            onClicked: addSensorMenu.open()

            QQC2.Menu {
                id: addSensorMenu
                y: addSensorButton.height

                QQC2.MenuItem {
                    text: "CPU usage, %"
                    onTriggered: () => { simpleDialog.type = "cpuUsage"; simpleDialog.open() }
                }

                QQC2.MenuItem {
                    text: "Mem usage, %"
                    onTriggered: () => { simpleDialog.type = "memUsage"; simpleDialog.open() }
                }

                QQC2.MenuItem {
                    text: "Custom"
                    onTriggered: () => { sensorDialog.type = "custom"; sensorDialog.open() }
                }
            }
        }
    }
}
