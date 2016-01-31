import QtQuick.Layouts 1.0
import Material 0.2
import Material.ListItems 0.1 as ListItem
import QtQuick 2.5
import QtQuick.Dialogs 1.0
import Qt.labs.settings 1.0

MaterialWindow {
    id: root
    width: 750
    height: 430

    property QtObject app

    property var player: playerRoot.player

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

    initialPage: Page {
        backgroundColor: noMedia ? Palette.colors.grey[100] : "black"
        actionBar.hidden: true

        PlayerRoot { id: playerRoot}

        Shortcuts {}

    }


    property Page libraryPage: LibraryPage {}
}
