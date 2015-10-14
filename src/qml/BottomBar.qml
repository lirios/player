import QtQuick.Layouts 1.0
import Material 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick 2.5

Rectangle {
    id: bottomBar
    opacity: 1
    anchors {
        bottom: parent.bottom
        right: parent.right
        left: parent.left
    }
    height: Units.dp(88)
    gradient: Gradient {
        GradientStop { position: 0.0; color: "transparent" }
        GradientStop { position: 1.0; color: Qt.rgba(0,0,0,0.6) }
    }
    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }

    function n(n){
        return n > 9 ? "" + n: "0" + n;
    }

    function getTime(ms) {
        var s = Math.round(ms/1000)
        var m = ~~(s/60)
        var h = ~~(m/60)
        return n(h) + ":" + n(m) + ":" + n(s)
    }

    Column {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
            margins: Units.dp(15)
        }
        spacing: -Units.dp(2)

        Slider {
            value: player.position
            visible: player.state != "0"
            darkBackground: true
            width: (bottomBar.width - parent.anchors.leftMargin - parent.anchors.rightMargin)
            onPressedChanged: player.time = value * player.length
        }

        Row {
            spacing: Units.dp(10)
            IconButton {
                id: playButton
                iconName: "av/play_arrow"
                color: "white"
                size: Units.dp(30)
             }
            Rectangle {
                height: playButton.height
                color: "transparent"
                width: (bottomBar.width - bottomBar.anchors.leftMargin - bottomBar.anchors.rightMargin) - playButton.width - rightButtons.width - rightButtons.spacing - Units.dp(20) - Units.dp(60)
                Label {
                    id: time
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    color: "white"
                    text: getTime(player.time) + " / " + getTime(player.length)
                }
            }
            Row {
               id: rightButtons
               width: cropButton.size
               spacing: Units.dp(10)
               IconButton {
                    id: cropButton
                    iconName: "image/crop_16_9"
                    color: "white"
                    size: Units.dp(30)
                    onClicked: {
                        if(player.state == "3")
                            root.height = Math.round((player.video.height / player.video.width) * (root.width + 16))
                    }
                }
               IconButton {
                    id: fsButton
                    iconName: root.fullscreen ? "navigation/fullscreen_exit" : "navigation/fullscreen"
                    color: "white"
                    size: Units.dp(30)
                    onClicked: if(root.fullscreen) showNormal(); else showFullScreen();
                }
            }
        }
    }
    Item{
        state: player.state
        states: [
            State {
                name: "0"
                PropertyChanges { target: playButton; iconName: "file/folder_open"; onClicked: filedialog.visible = true }
                PropertyChanges { target: time; text:  "Open a file" }
            },
            State {
                name: "1"
                PropertyChanges { target: playButton; iconName: "notification/sync"; onClicked: filedialog.visible = true }
                PropertyChanges { target: time; text:  "Opening..." }
            },
            State {
                name: "2"
                PropertyChanges { target: playButton; iconName: "notification/sync"; onClicked: filedialog.visible = true }
                PropertyChanges { target: time; text:  "Buffering..." }
            },
            State {
                name: "3"
                PropertyChanges { target: playButton; iconName: "av/pause"; onClicked: player.pause() }
                PropertyChanges { target: time; text:  getTime(player.time) + " / " + getTime(player.length) }
            },
            State {
                name: "4"
                PropertyChanges { target: playButton; iconName: "av/play_arrow"; onClicked: player.play() }
                PropertyChanges { target: time; text:  getTime(player.time) + " / " + getTime(player.length) }
            },
            State {
                name: "5"
                PropertyChanges { target: playButton; iconName: "file/folder_open"; onClicked: filedialog.visible = true }
                PropertyChanges { target: time; text:  "Open a file" }
            },
            State {
                name: "6"
                PropertyChanges { target: playButton; iconName: "av/replay"; onClicked: player.play(filedialog.fileUrl) }
                PropertyChanges { target: time; text:  "Replay..." }
            },
            State {
                name: "7"
                PropertyChanges { target: playButton; iconName: "alert/error"; onClicked: player.play(filedialog.fileUrl) }
                PropertyChanges { target: time; text:  "Error" }
            }
        ]
    }
}
