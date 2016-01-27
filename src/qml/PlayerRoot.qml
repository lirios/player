import QtQuick.Layouts 1.0
import Material 0.2
import Material.ListItems 0.1 as ListItem
import QtQuick 2.5
import QtQuick.Dialogs 1.0
import QmlVlc 0.1
import QtMultimedia 5.0

Item {
    anchors.fill: parent
    property alias player: player

    property bool plugin: false

    function showBars() {
        topBar.opacity = 1
        bottomBar.opacity = 1
    }

    function hideBars() {
          topBar.opacity = 0
        bottomBar.opacity = 0
     }

    function restartBarsTimer() {
        showBars()
        timer.restart()
    }

    function addCurrentToRecentlyPlayed () {
        var l = recentlyPlayedModel.count
        for(var i=0; i<l; i++)
            if(recentlyPlayedModel.get(i).url == player.mrl)
                return
        recentlyPlayedModel.append({"name" : currentMedia.title, "url" : player.mrl, "type" : isAudio ? "audio" : "video", "artist": currentMedia.artist})
    }

    VlcPlayer {
        id: player
        signal selected()
        onSelected: filedialog.toPlay ? addToPlay() : addToPlaylist()

        function addToPlaylist() {
            for(var i in filedialog.fileUrls)
                playlist.add(filedialog.fileUrls[i])
            currentPlaylistModel.clear()
            for(i in playlist.items){
                currentPlaylistModel.append({"title": playlist.items[i].title, "artist": playlist.items[i].artist, "url": playlist.items[i].mrl, "cover": playlist.items[i].artworkURL})
            }

            playlist.mode = 1

        }

        function addToPlay() {
            currentPlaylistModel.clear()
            playlist.clear()
            player.mrl = filedialog.fileUrls[0]
            console.log("\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n\n\nnrstauie\n")

        }

        onMediaPlayerPlaying: {
            currentMedia = mediaDescription;
            isAudio = (video.height == 0) ? true : false
            addCurrentToRecentlyPlayed();
        }
    }

    PlayerSurface { }

    NoMediaSurface { }

    TopBar {
        id: topBar
        opacity: 1
    }

    BottomBar {
        id: bottomBar
        visible: !noMedia
    }

    ActionButton {
        iconName: "file/folder_open"
        visible: noMedia
        anchors{
            right: parent.right
            bottom: parent.bottom
            margins: Units.dp(20)
        }
        onClicked: {
            filedialog.toPlay = true
            filedialog.visible = true
        }
    }

    FileDialog {
        id: filedialog
        title: "Choisir un fichier vidéo"
        visible: false
        folder: shortcuts.home
        selectMultiple: true
        property bool toPlay
        Component.onCompleted : {
              filedialog.accepted.connect(player.selected)
        }
    }

    Timer {
      id: timer
      interval: forceBars ? 9999999999 : 1500
      repeat: false
      onTriggered: hideBars()
    }

    Rectangle {
      id: shadow
      color: Qt.rgba(0,0,0,0.1)
      anchors.fill: parent
      visible: false
      MouseArea {
          anchors.fill: parent
          onClicked: {
              playlistDrawer.close()
              settingsDrawer.close()
          }
      }
    }

    SettingsDrawer { id: settingsDrawer }

    PlaylistDrawer { id: playlistDrawer }
}
