import QtQuick 2.5
import Material 0.1
import Material.ListItems 0.1 as ListItem

View {
    id: settingsRoot
    z:2
    backgroundColor: "white"
    width: Units.dp(300)
    anchors {
        left: parent.left
        top: parent.top
        bottom: parent.bottom
        leftMargin: -width - 20
    }

    Behavior on anchors.leftMargin {
        NumberAnimation {
            duration: 300
        }
    }

    function open() {
        anchors.leftMargin = 0
        shadow.visible = true
    }

    function close() {
        anchors.leftMargin = -width - 20
        shadow.visible = false
    }

    Column {
        anchors.fill: parent
        Item {
            height: Units.dp(50)
            width: parent.width
            Label {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    margins: Units.dp(15)
                }

                text: "Settings"
                style: "headline"
            }
        }
        ListItem.Standard {
            text: "Accent Color"
            Rectangle {
                id: accentcolorSample
                width: Units.dp(30)
                height: width
                radius: width*0.5
                color: accentColorPicker.color
                anchors {
                        top: parent.top
                        right: parent.right
                        topMargin:5
                        rightMargin: Units.dp(15)
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: accentColorPicker.open(accentcolorSample, Units.dp(30), Units.dp(-4))
                }
            }
        }
        ColorPicker {
            id: accentColorPicker
            color: theme.accentColor
        }
        ListItem.Standard {
            text: "Primary Color"
            Rectangle {
                id: primarycolorSample
                width: Units.dp(30)
                height: width
                radius: width*0.5
                color: primaryColorPicker.color
                anchors {
                        top: parent.top
                        right: parent.right
                        topMargin:5
                        rightMargin: Units.dp(15)
                }
                MouseArea {
                    anchors.fill: parent
                    onPressed: primaryColorPicker.open(primarycolorSample, Units.dp(30), Units.dp(-4))
                }
            }
        }
        ColorPicker {
            id: primaryColorPicker
            color: theme.primaryColor
        }
    }
    Row {
        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            margins: Units.dp(15)
        }
        spacing: Units.dp(15)
        Button {
            text: "Save"
            elevation: 1
            backgroundColor: theme.accentColor
            onClicked: {
                theme.accentColor = accentColorPicker.color
                theme.primaryColor = primaryColorPicker.color
                close()
            }
        }
        Button {
            text: "reset"
            elevation: 1
            onClicked: {
                accentColorPicker.color = theme.accentColor
                primaryColorPicker.color = theme.primaryColor
                close()
            }
        }
    }
}

