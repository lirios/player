import QtQuick 2.5
import QmlVlc 0.1
import QtMultimedia 5.0

Item {

    signal fileSelected()
    onFileSelected: vlcPlayer.mrl = filedialog.fileUrl
    VlcPlayer {
        id: vlcPlayer
    }

    VlcVideoSurface {
        source: vlcPlayer
        anchors.fill: parent
    }
}
