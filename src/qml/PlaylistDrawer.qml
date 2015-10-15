import QtQuick 2.5
import Material 0.1
import Material.ListItems 0.1 as ListItem

View {
    id: playlistRoot
    z:2
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
    }

    function close() {
        anchors.rightMargin = -width - 20
        shadow.visible = false
    }

    Column {
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
            margins: Units.dp(15)
        }
        spacing: Units.dp(15)
        Button {
            text: "add"
            elevation: 0
            onClicked: {
                filedialog.toPlay = false;
                filedialog.visible = true;
            }
        }
    }
}

