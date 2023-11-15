import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

import "sensorFuncs.js" as SensorFuncs

PlasmaComponents.Label {
    property var model
    property var old

    property double value

    text: renderValue(value)

    function update() {
        const res = SensorFuncs.calcCPUUsage(old)
        old = res.values
        value = res.usage
    }

    function renderValue(v) {
        if (typeof v !== "undefined")
            return model.name + " " + v + "%"
        return model.name + " -"
    }

    Timer {
        function calcInterval(m) {
            if (!m)
                return 1000
            if (typeof m.interval === "undefined")
                return 1000
            return m.interval * 1000
        }
        interval: calcInterval(parent.model)
        running: true
        repeat: true
        onTriggered: {
            update()
        }
    }
}
