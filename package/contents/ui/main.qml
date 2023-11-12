import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import "sensorFuncs.js" as SensorFuncs

Row {
    property var sensorGroups: [
        {name: "CPU:", unit: "%", source: "cpuUsage"},
        {name: "CPU:", unit: "°C", source: "/sys/class/hwmon/hwmon0/temp1_input", divisor: 1000},
        {name: "Bat:", unit: "°C", source: "/sys/class/hwmon/hwmon1/temp1_input", divisor: 1000},
        {name: "GPU:", unit: "°C", source: "/sys/class/hwmon/hwmon2/temp1_input", divisor: 1000},
        {name: "Mem:", unit: "%", source: "memUsage"}
    ]

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    spacing: 10

    Repeater {
        model: parent.sensorGroups

        delegate: Sensor {
            name: modelData.name
            unit: modelData.unit
            divisor: modelData.divisor ? modelData.divisor : 1
            precision: modelData.precision ? modelData.precision : 1
            source: modelData.source

            Component.onCompleted: update()
        }
    }

    PlasmaComponents.Label {
        id: label
        text: "CPU: 7% | CPU: +61.0°C, Bat: +29.0°C, GPU: +59.0°C | Mem: 71%"
    }
}
