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

    property var cliFile
    property bool fullscreen: visibility == 5
    property bool forceBars: player.state != "3"

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

    initialPage: Page {
        backgroundColor: "black"
        actionBar.hidden: true

        VlcPlayer {
            id: player
            signal selected()
            onSelected: mrl = filedialog.fileUrl
        }

        VlcVideoSurface {
            source: player
            anchors.fill: parent
            MouseArea {
                anchors.fill: parent
                anchors.topMargin:topBar.height
                anchors.bottomMargin:bottomBar.height
                hoverEnabled: true
                onPositionChanged: restartBarsTimer()
                onClicked: player.togglePause()
                onDoubleClicked: fullscreen ? showNormal() : showFullScreen()
            }
        }

        TopBar {
            id: topBar
            opacity: 1
        }

        BottomBar {
            id: bottomBar
        }

        FileDialog {
            id: filedialog
            title: "Choisir un fichier vidéo"
            visible: false
            folder: shortcuts.home
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
               onClicked: settingsDrawer.close()
           }
       }


       SettingsDrawer { id: settingsDrawer }
    }


    Component.onCompleted: {
        if(cliFile)
            player.mrl = cliFile
        console.log(cliFile)
        timer.start()
    }
}
