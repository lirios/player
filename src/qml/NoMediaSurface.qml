import QtQuick 2.5
import Material 0.2
import Material.ListItems 0.1 as ListItem

Rectangle {
    id: noMediaSurface
    visible: root.noMedia
    anchors{
        margins: Units.gu(1)
        topMargin: Units.dp(10) + topBar.height
        fill: parent
    }
    color: "transparent"
    Column {
        spacing: Units.dp(10)
        Label {
            text: "Recent"
            style: "display2"
        }

        ListView {
            width: noMediaSurface.width
            height:noMediaSurface.height - Units.dp(10) - topBar.height
            model: application.recentlyPlayedModel
            delegate: ListItem.Standard {
                iconName: type == "audio" ? "av/album" : "av/movie"
                text: name + "   <font color='#757575'>"+ (artist ? "- " + artist : "") + "</font>"
                backgroundColor: "white"
                onClicked: player.mrl = url
            }
        }
    }
}

