import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

import "sensorFuncs.js" as SensorFuncs

Row {
    property var sensorGroups: [
        {name: "CPU:", type: "cpuUsage"},
        {name: "CPU:", type: "custom", unit: "°C", source: "/sys/class/hwmon/hwmon1/temp1_input", divisor: 1000},
        {name: "Bat:", type: "custom", unit: "°C", source: "/sys/class/hwmon/hwmon3/temp1_input", divisor: 1000},
        {name: "GPU:", type: "custom", unit: "°C", source: "/sys/class/hwmon/hwmon5/temp1_input", divisor: 1000},
        {name: "Mem:", type: "memUsage"}
    ]

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    spacing: 10

    Component {
        id: cpuUsageSensor
        CPUUsageSensor {
        }
    }

    Component {
        id: memUsageSensor
        MemUsageSensor {
        }
    }

    Component {
        id: genericSensor
        Sensor {
        }
    }

    Repeater {
        model: parent.sensorGroups

        delegate: Loader {
            sourceComponent: {
                if (modelData.type === "cpuUsage") {
                    return cpuUsageSensor
                }
                if (modelData.type === "memUsage") {
                    return memUsageSensor
                }
                return genericSensor
            }
            onLoaded: {
                item.model = modelData
                item.update()
            }
        }
    }

    PlasmaComponents.Label {
        id: label
        text: "CPU: 7% | CPU: +61.0°C, Bat: +29.0°C, GPU: +59.0°C | Mem: 71%"
    }
}
