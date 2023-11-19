import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

import org.kde.plasma.plasmoid 2.0
import org.kde.kirigami 2.5 as Kirigami

ColumnLayout {
    id: root

    signal configurationChanged

    property var cfg_sensorList: []

    function addSensor(object) {
        console.log("Add sensor " + JSON.stringify(object))
        sensorModel.append( object )
        cfg_sensorList.push( JSON.stringify(object) )
        configurationChanged();
    }

    function removeSensor(index) {
        if(sensorModel.count > 0) {
            sensorModel.remove(index, 1)
            cfg_sensorList.splice(index,1)
            configurationChanged();
        }
    }

    function setSensor(index, object) {
        console.log("Set sensor " + JSON.stringify(object) + " at " + index)
        sensorModel.set(index, object)
    }

    function renderSensor(object) {
        if (object.type === "custom") {
            return object.type + ", " + object.name + ", " + object.path + ", " + object.unit
        } else {
            return object.type + ", " + object.name + ", " + object.unit
        }
    }

    function editSensor(index) {
        const object = sensorModel.get(index)
        console.log("At " + index + ": " + JSON.stringify(object))
        if (object.type === "custom") {
            sensorDialog.edit(index, object)
        } else {
            simpleDialog.edit(index, object)
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

        onDone: (index, object) => typeof index === "undefined" ? addSensor(object) : setSensor(index, object)
    }

    SimpleDialog {
        id: simpleDialog
        visible: false

        onDone: (index, object) => typeof index === "undefined" ? addSensor(object) : setSensor(index, object)
    }

    ListModel {
        id: sensorModel
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
                    text: renderSensor(model)
                }

                actions: [
                    Kirigami.Action {
                        iconName: "edit-entry"
                        tooltip: i18nd("plasma_wallpaper_org.kde.image", "Edit sensor")
                        onTriggered: editSensor(model.index)
                    },
                    Kirigami.Action {
                        iconName: "list-remove"
                        tooltip: i18nd("plasma_wallpaper_org.kde.image", "Remove sensor")
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
                    onTriggered: () => { simpleDialog.add({type: "cpuUsage", name: "CPU Usage"}) }
                }

                QQC2.MenuItem {
                    text: "Mem usage, %"
                    onTriggered: () => { simpleDialog.add({type: "memUsage", name: "Mem Usage"}) }
                }

                QQC2.MenuItem {
                    text: "Custom"
                    onTriggered: () => { sensorDialog.add({type: "custom"}) }
                }
            }
        }
    }
}
