import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

import "sensorFuncs.js" as SensorFuncs

PlasmaComponents.Label {
    property string name
    property string unit
    property string source
    property double divisor: 1
    property int precision: 1
    property int interval: 1

    property double value

    text: renderValue(value)

    function cpuUsage() {
        return SensorFuncs.calcCPUUsage()
    }

    function memUsage() {
        return SensorFuncs.calcMemUsage()
    }

    function update() {
        console.log("On update")
        if (typeof this[source] === "function")
            value = this[source]()
        else
            value = parseFloat(SensorFuncs.readFile(source))
    }

    function renderValue(v) {
        console.log(v)
        if (typeof v !== "undefined")
            return name + " " + (v / divisor).toFixed(precision) + unit
        return name + " -"
    }

    Timer {
        interval: parent.interval * 1000
        running: true
        repeat: true
        onTriggered: {
            update()
        }
    }
}
