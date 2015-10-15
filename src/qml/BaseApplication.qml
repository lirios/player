import QtQuick 2.1
import Qt.labs.settings 1.0

Item {
    id: application

    property ListModel recentlyPlayedModel: ListModel {
        id: recentlyPlayedModel
        dynamicRoles: true
    }

    property Settings settings: Settings {
        id: settings
        property var recents
    }

    PlayerWindow { id: root }

    Component.onCompleted: {
        var recents = application.settings.recents, r_l = recents.length;
        for (var i=r_l-1; i>=0; i--) {
           application.recentlyPlayedModel.append(recents[i]);
           console.log(JSON.stringify(recents[i]))
        }
        if(cliFile)
            player.mrl = cliFile
        timer.start()

    }

    Component.onDestruction: {
        var recents = [], r_l = application.recentlyPlayedModel.count, item;
        for (var i=0; i<r_l; i++){
             item = application.recentlyPlayedModel.get(i);
             recents.push({"name": item.name, "url": item.url, "type": item.type, "artist" : item.artist})

            console.log(JSON.stringify(item))
        }
        recents.reverse()
        application.settings.recents = recents;
        console.log(JSON.stringify(application.settings.recents))
        //application.settings.recents = [];
    }

}

