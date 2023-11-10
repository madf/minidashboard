import QtQuick 2.0
import QtQuick.Layouts 1.0
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents

Row {
    spacing: 10

    Plasmoid.preferredRepresentation: Plasmoid.fullRepresentation

    Item {
        width: label.width + 3
        height: label.height + 2

        PlasmaComponents.Label {
            id: label
            text: "CPU: 7%"
        }

        Rectangle {
            width: 1
            color: 'green'
            anchors {
                top: parent.top
                bottom: parent.bottom
                margins: 1
            }
        }
    }

    PlasmaComponents.Label {
        text: "CPU: +61.0°C, Bat: +29.0°C, GPU: +59.0°C"
    }

    Item {
        Rectangle {
            width: 1
            color: 'green'
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
        }
    }

    PlasmaComponents.Label {
        text: "Mem: 71%"
    }
}
