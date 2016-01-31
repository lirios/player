import QtQuick 2.5
import Material 0.2
import Material.ListItems 0.1 as ListItem

View {
    id: playlistRoot
    z:10
    backgroundColor: "white"
    width: Units.dp(350)
    anchors {
        right: parent.right
        top: parent.top
        bottom: parent.bottom
        rightMargin: -width - 20
    }

    Behavior on anchors.rightMargin {
        NumberAnimation {
            duration: 300
        }
    }
    function open() {
        anchors.rightMargin = 0
        shadow.visible = true
        topBar.opacity = 100
    }

    function close() {
        anchors.rightMargin = -width - 20
        shadow.visible = false
    }

    Column  {
        anchors.fill: parent
        Item {
            height: Units.dp(50)
            width: parent.width
            Label {
                id: label
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                    margins: Units.dp(15)
                }

                text: "Playlist"
                style: "headline"
            }
            IconButton {
                id: clearPlaylist

                anchors {
                    left: label.right
                    leftMargin: Units.dp(16)
                    verticalCenter: parent.verticalCenter
                }
                iconName: "action/done_all"

                onClicked: {
                    root.currentPlaylistModel.clear()
                    player.playlist.clear()
                }
            }
            Label {
                id: labelclr
                anchors {
                    left: clearPlaylist.right
                    leftMargin: Units.dp(8)
                    verticalCenter: parent.verticalCenter
                }


                text: "Clear"
            }

            SystemButtons {
                id: sysbuttons
                z:90
                visible: !plugin
                color: "transparent"
                onShowMinimized: root.showMinimized();
                onShowMaximized: root.showMaximized();
                onShowNormal: root.showNormal();
                onClose: Qt.quit();
                iconsColor: "grey"
                anchors {
                    top: parent.top
                    margins: Units.dp(15)
                    right: parent.right
                }
            }
        }
        ListView {
            model: root.currentPlaylistModel
            width: playlistRoot.width
            height: playlistRoot.height
            delegate: ListItem.Standard {
                id: delegate
                text: title
                iconName: index == player.playlist.currentItem ? "av/play_arrow" : ""
                onClicked: player.playlist.playItem(index)
            }
        }
    }
    Row {
        anchors{
            bottom: parent.bottom
            horizontalCenter: parent.horizontalCenter
            margins: Units.dp(0)
        }
        spacing: Units.dp(0)

        Rectangle {
            color: "white"
            width: playlistDrawer.width
            height: Units.dp(50)


        Button {
            text: "add"
            anchors {
                left: parent.left
                right: parent.right
                top: parent.top
                bottom: parent.bottom

                rightMargin: Units.dp(30)
                leftMargin: Units.dp(30)
                bottomMargin: Units.dp(5)
                topMargin: Units.dp(7)
            }
            id: addbutton
            elevation: 2
            onClicked: {
                filedialog.toPlay = false;
                filedialog.visible = true;
            }
        }
        }
    }

}

