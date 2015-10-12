import QtQuick 2.2
import Material 0.1
import Material.ListItems 0.1 as ListItem
import Qt.labs.folderlistmodel 2.1

TabbedPage {
    id: page
    title: "My Library"
    backgroundColor: Palette.colors.grey[200]

    Tab {
        title: "Songs"

        ListView {
            y: 150
            width: 200; height: 400

            FolderListModel {
                folder: "file:/home/pierremtb/Musique"
                id: folderModel
                nameFilters: ["*.mp3"]
            }

            Component {
                id: fileDelegate
                View {
                    height: Units.dp(40)
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: Units.gu(1)
                    }

                    backgroundColor: "white"
                    elevation: 1
                    Label {
                        anchors {
                            left: parent.left
                            right: parent.right
                            verticalCenter: parent.verticalCenter
                            margins: Units.dp(10)
                        }
                        text: fileName
                        MouseArea {
                            anchors.fill: parent
                            onClicked: player.mrl = fileURL
                        }
                    }
                }
            }

            model: folderModel
            delegate: fileDelegate
        }
    }

    Tab {
        title: "Projects"

        Rectangle { color: Palette.colors.purple["200"] }
    }
}
