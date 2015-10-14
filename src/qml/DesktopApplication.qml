import QtQuick 2.1
import QtWebEngine 1.1
import Qt.labs.settings 1.0
import Material.Extras 0.1

BaseApplication {
    id: app

    property Component playerWindowComponent: PlayerWindow {
        app: application
    }

    function createWindow() {
        var newWindow = playerWindowComponent.createObject(application)
        return newWindow
    }

 }
