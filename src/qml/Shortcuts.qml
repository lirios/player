import QtQuick 2.0
import QtQuick.Controls 1.2 as Controls
import Material.Extras 0.1


Item {
    Controls.Action {
        shortcut: "Space"
        onTriggered: {
            player.togglePause()
        }
    }
    Controls.Action {
        shortcut: "Ctrl+N"
        onTriggered: {
            root.app.createWindow()
        }
    }
    Controls.Action {
        shortcut: "Esc"
        onTriggered: {
        if(root.fullscreen) showNormal(); else null();
        }
    }

}
