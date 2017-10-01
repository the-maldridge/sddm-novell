import QtQuick 2.0
import QtQuick.Layouts 1.3
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
            width: childrenRect.width
            height: childrenRect.height
            color: "#ccc"
            anchors.centerIn: parent

            ColumnLayout {
                anchors.horizontalCenter: parent.horizontalCenter
                Row {
                    Image {
                        // Blue bar at the top of the "Windows Form"
                        source: "img/bar.png"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter

                }
                Row {
                    id: novell_logo
                    Image {
                        // Box with the logo in it
                        source: "img/novell.png"
                    }
                    anchors.horizontalCenter: parent.horizontalCenter

                }
                Row {
                    anchors.left: novell_logo.left
                    anchors.right: novell_logo.right
                    GridLayout {
                        id: login_grid
                        columns: 2
                        rows: 2

                        Text {
                            text: "Username:"
                            anchors.verticalCenter: user_entry.verticalCenter
                        }

                        TextBox {
                            id: user_entry
                            font.pixelSize: 11
                            font.family: "monospace"
                            height: 20
                            anchors.right: parent.right
                        }
                        Text {
                            text: "Password:"
                            anchors.verticalCenter: pw_entry.verticalCenter
                        }

                        PasswordBox {
                            id: pw_entry
                            font.pixelSize: 11
                            font.family: "monospace"
                            height: 20

                            Keys.onPressed: {
                                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                    sddm.login(user_entry.text, pw_entry.text)
                                    event.accepted = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
