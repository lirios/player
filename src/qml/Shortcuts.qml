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

}
