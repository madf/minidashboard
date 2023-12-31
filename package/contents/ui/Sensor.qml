import QtQuick 2.0
import org.kde.plasma.components 2.0 as PlasmaComponents

import "sensorFuncs.js" as SensorFuncs

PlasmaComponents.Label {
    property var model

    property double value

    text: renderValue(value)

    function update() {
        value = parseFloat(SensorFuncs.readFile(model.source))
    }

    function renderValue(v) {
        let precision = 1
        if (typeof model.precision !== "undefined")
            precision = model.precision
        if (typeof v !== "undefined")
            return model.name + " " + (v / model.divisor).toFixed(precision) + model.unit
        return model.name + " -"
    }

    Timer {
        interval: parent.model.interval * 1000
        running: true
        repeat: true
        onTriggered: {
            update()
        }
    }
}
