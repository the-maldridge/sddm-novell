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
        // Container to place the login form on the primary screen
        // only
        anchors.fill: parent
        color: "transparent"
        visible: primaryScreen

        Rectangle {
            // Login form
            width: childrenRect.width + 5
            height: childrenRect.height + 5
            color: "#ccc"
            anchors.centerIn: parent

            Column {
                anchors.horizontalCenter: parent.horizontalCenter
                Row {
                    Image {
                        // Blue bar at the top of the "Windows Form"
                        source: "img/bar.png"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                }
                Row {
                    Image {
                        // Box with the logo in it
                        source: "img/novell.png"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter
                    
                }
                Row {
                    Text {
                        text: "Username:"
                    }
                    
                    TextBox {
                        id: user_entry
                    }
                }
                Row {
                    Text {
                        text: "Password:"
                    }
                    
                    PasswordBox {
                        id: pw_entry
                    }
                }
            }
        }
    }
}
