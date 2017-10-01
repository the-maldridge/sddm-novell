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
            // White part of the drop shadow
            color: "#fff"
            width: login_form.width
            height: login_form.height
            anchors.right: login_form.right
            anchors.rightMargin: 1
            anchors.bottom: login_form.bottom
            anchors.bottomMargin: 1
        }

        Rectangle {
            // Black part of the drop shadow
            color: "#000"
            width: login_form.width + 1
            height: login_form.height + 1
            anchors.left: login_form.left
            anchors.leftMargin: 1
            anchors.top: login_form.top
            anchors.topMargin: 1
        }

        Rectangle {
            // Login form
            id: login_form
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
                    anchors.right: novell_logo.right

                    GridLayout {
                        columns: 2
                        rows: 2
                        Text {
                            id: username_label
                            text: "Username:"
                            anchors.verticalCenter: user_entry.verticalCenter
                            anchors.left: parent.left
                        }

                        TextBox {
                            id: user_entry
                            font.pixelSize: 11
                            font.family: "monospace"
                            height: 20
                            width: 385
                        }

                        Text {
                            text: "Password:"
                            anchors.verticalCenter: pw_entry.verticalCenter
                            anchors.left: username_label.left
                        }

                        PasswordBox {
                            id: pw_entry
                            font.pixelSize: 11
                            font.family: "monospace"
                            height: 20
                            width: user_entry.width

                            Keys.onPressed: {
                                if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
                                    sddm.login(user_entry.text, pw_entry.text)
                                    event.accepted = true
                                }
                            }
                            KeyNavigation.backtab: user_entry
                            KeyNavigation.tab: ok_button
                        }
                    }
                }

                RowLayout {
                    spacing: 5
                    id: button_row
                    anchors.right: novell_logo.right
                    Layout.bottomMargin: 5

                    ImageButton {
                        id: ok_button
                        source: "img/ok.png"
                        KeyNavigation.backtab: pw_entry
                        KeyNavigation.tab: cancel_button
                        opacity: 1

                        onClicked: sddm.login(user_entry.text, pw_entry.text, session.index)
                    }

                    ImageButton {
                        id: cancel_button
                        source: "img/cancel.png"
                        KeyNavigation.backtab: ok_button
                        KeyNavigation.tab: advanced_button
                        opacity: 1

                        onClicked: cancel()

                        function cancel() {
                            user_entry.text = ""
                            pw_entry.text = ""
                        }
                    }

                    ImageButton {
                        id: advanced_button
                        source: "img/advanced.png"
                        KeyNavigation.backtab: cancel_button
                        opacity: 1

                        onClicked: toggle()

                        function toggle() {
                            if (advanced_panel.visible) advanced_panel.visible = false;
                            else advanced_panel.visible = true;
                        }
                    }
                }

                RowLayout {
                    // This is the "advanced" row.  It contains things
                    // that netware wouldn't have had and doesn't
                    // necessarily use the correct styling, but it
                    // tries to get close.
                    id: advanced_panel
                    visible: false

                    Layout.margins: 5
                    ComboBox {
                        id: session
                        width: 150
                        height: 20

                        model: sessionModel
                        index: sessionModel.lastIndex

                        font.pixelSize: 11
                        font.family: "monospace"
                    }
                }
            }
        }
    }
}
