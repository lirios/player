import QtQuick 2.2
import Material 0.2
import Material.ListItems 0.1 as ListItem
import Qt.labs.folderlistmodel 2.1
//import Username 1.0

TabbedPage {
    id: page
    title: "My Library"
    backgroundColor: Palette.colors.grey[200]

    Tab {
        title: "Music"

        ListView {
            y: 150
            width: 200; height: 400

            FolderListModel {
                folder: "/home/Collin/Music"
                //folder: EnvironmentVariable.value("HOME") +"Music/"
                // ^ This kept giving me errors I couldn't fix with my limited C++ knowledge. See qmlenvironemtvarialbe.h and the issue on github. -CN
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
        title: "Videos"

        ListView {
            y: 150
            width: 200; height: 400

            FolderListModel {
                folder: "file:/home/Collin/Torrents/TV/American Dad/Seasons 1-10/"
                //folder: EnvironmentVariable.value("HOME") +"Videos/"
                // ^ This kept giving me errors I couldn't fix with my limited C++ knowledge. See qmlenvironemtvarialbe.h and the issue on github. -CN
                id: folderModel
                nameFilters: ["*.mp4", "*.mkv", "*.wmv"]
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


    //I couldn't figure out what this is supposed to be. Is it just a placeholder or is there a plan for it? -CN
    Tab {
        title: "Projects"

        Rectangle { color: Palette.colors.purple["200"] }
    }
}
