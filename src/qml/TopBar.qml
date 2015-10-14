import QtQuick.Layouts 1.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick 2.5

Rectangle {
    id: top_bar
    opacity: 1
    anchors {
        top: parent.top
        right: parent.right
        left: parent.left
    }
    height: Units.dp(60)
    gradient: Gradient {
        GradientStop { position: 0.0; color: root.noMedia ? theme.primaryColor :  Qt.rgba(0,0,0,0.4) }
        GradientStop { position: 1.0; color: root.noMedia ? theme.primaryColor :  "transparent" }
    }
    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }

    Row {
        anchors {
            left: parent.left
            top: parent.top
            margins: Units.dp(15)
        }
        spacing: Units.dp(10)
        IconButton {
            id: menuButton
            iconName: "navigation/menu"
            color: "white"
            size: Units.dp(30)
            onClicked: menu.open(menuButton,menu.width - menuButton.width,0)
        }
        IconButton {
            id: lockButton
            visible: false
            iconName: "action/lock"
            color: "white"
            size: Units.dp(20)
            onClicked: forceBars = !forceBars
        }
        IconButton {
            id: libraryButton
            visible: false
            iconName: "av/my_library_music"
            color: "white"
            size: Units.dp(30)
            onClicked: pageStack.push(libraryPage)
        }
        Label {
            text: "Liri Player"
            style: "title"
            color: "white"
            visible: root.noMedia
        }

    }

    Dropdown {
        id: menu
        objectName: "menu"

        width: Units.dp(250)
        height: columnView.height + Units.dp(16)

        ColumnLayout {
            id: columnView
            width: parent.width
            anchors.centerIn: parent
            ListItem.Standard {
                text: "Open"
                iconName: "file/folder_open"
                onClicked: {
                    menu.close();
                    filedialog.visible = true;
                }
            }
            ListItem.Standard {
                text: "Settings"
                iconName: "action/settings"
                onClicked: {
                    menu.close();
                    settingsDrawer.open()
                }
            }
            ListItem.Standard {
                text: "Quit"
                iconName: "action/exit_to_app"
                onClicked: {
                    menu.close()
                    Qt.quit()
                }
            }
        }
    }

    SystemButtons {
        id: sysbuttons
        z:90
        color: "transparent"
        onShowMinimized: root.showMinimized();
        onShowMaximized: root.showMaximized();
        onShowNormal: root.showNormal();
        onClose: Qt.quit();
        iconsColor: "white"
        anchors {
            right: parent.right
            top: parent.top
            margins: Units.dp(15)
        }
    }
}
