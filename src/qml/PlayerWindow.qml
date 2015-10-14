import QtQuick.Layouts 1.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick 2.5
import QmlVlc 0.1
import QtMultimedia 5.0
import QtQuick.Dialogs 1.0
import Qt.labs.settings 1.0

MaterialWindow {
    id: root
    width: 750
    height: 430

    property QtObject app


    property var cliFile
    property bool fullscreen: visibility == 5
    property bool forceBars: player.state != "3"
    property bool noMedia: player.state == "0" || player.state == "5"

    property var currentMedia

    property ListModel currentPlaylistModel: ListModel {
        id: currentPlaylistModel
    }

    property bool isAudio

    theme {
            id: theme
            primaryColor: "#F44336"
            primaryDarkColor: "#D32F2F"
            accentColor: "#FF5722"
        }

    visible: true
    property Settings settings: Settings {
        id: settings
        property alias x: root.x
        property alias y: root.y
        property alias accentColor: theme.accentColor
        property alias primaryColor: theme.primaryColor
        property var recents
        /*property alias width: root.width
        property alias height: root.height*/
    }

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
        application.recentlyPlayedModel.append({"name" : currentMedia.title, "url" : player.mrl, "type" : isAudio ? "audio" : "video", "artist": currentMedia.artist})
    }

    initialPage: Page {
        backgroundColor: noMedia ? Palette.colors.grey[100] : "black"
        actionBar.hidden: true

        VlcPlayer {
            id: player
            signal selected()
            onSelected: {
                for(var i in filedialog.fileUrls)
                    playlist.add(filedialog.fileUrls[i])
                console.log(playlist.items)
                currentPlaylistModel.clear()
                for(i in playlist.items){
                    console.log(JSON.stringify(playlist.items))
                    currentPlaylistModel.append({"title": playlist.items[i].title, "artist": playlist.items[i].artist, "url": playlist.items[i].mrl, "cover": playlist.items[i].artworkURL})
                }

                playlist.mode = 1
                playlist.play()
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
            onClicked: filedialog.visible = true
        }

        FileDialog {
            id: filedialog
            title: "Choisir un fichier vidéo"
            visible: false
            folder: shortcuts.home
            selectMultiple: true
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

       Shortcuts {}

       Rectangle {
           id: shadow
           color: Qt.rgba(0,0,0,0.1)
           anchors.fill: parent
           anchors.margins: 10
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


    property Page libraryPage: LibraryPage {}
}
