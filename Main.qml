import QtQuick 2.0
import SddmComponents 2.0

Rectangle {
    color: "#027f82"
    Background {
        anchors.fill: parent
        source: config.background
        fillMode: Image.PreserveAspectCrop
        onStatusChanged: {
            if (status == Image.Error && source != config.defaultBackground) {
                source = config.defaultBackground
            }
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "transparent"
        visible: primaryScreen

        Rectangle {
            width: 200
            height: 200
            color: "#000"

            anchors.centerIn: parent
        }
    }
}
