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
        console.log(application.settings.recents)
        for (var i=0; i<application.settings.recents.length; i++)
           application.recentlyPlayedModel.append(settings.recents[i]);
        if(cliFile)
            player.mrl = cliFile
        timer.start()

    }

    Component.onDestruction: {
        var recents = [], r_l = application.recentlyPlayedModel.count, item;
        for (var i=0; i<r_l; i++){
             item = application.recentlyPlayedModel.get(i);
             recents.push({"name": item.name, "url": item.url, "type": item.type, "artist" : item.artist})
        }
        application.settings.recents = recents;
    }

}

