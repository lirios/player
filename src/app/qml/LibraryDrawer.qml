// SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtQuick.Layouts 1.3
import Qt.labs.folderlistmodel 2.1
import Qt.labs.platform 1.0
import Fluid.Controls 1.0 as FluidControls

FluidControls.NavigationDrawer {
    id: libraryDrawer

    topContent: FluidControls.TitleLabel {
        text: qsTr("Library")
    }

    width: window.width * 0.5

    modal: true
    interactive: true
    position: 0.0
    visible: false

    TabBar {
        id: bar

        width: parent.width

        TabButton {
            text: qsTr("Music")
        }
        TabButton {
            text: qsTr("Videos")
        }
    }

    StackLayout {
        anchors.fill: parent
        anchors.topMargin: bar.height
        currentIndex: bar.currentIndex

        Item {
            ScrollView {
                anchors.fill: parent
                clip: true

                ListView {
                    model: FolderListModel {
                        folder: StandardPaths.writableLocation(StandardPaths.MusicLocation)
                        nameFilters: ["*.mp3"]
                    }
                    delegate: FluidControls.ListItem {
                        text: model.fileName
                        highlighted: player.source === model.fileURL
                        onClicked: {
                            player.source = model.fileURL;
                            player.play();
                            libraryDrawer.close();
                        }
                    }
                }
            }
        }

        Item {
            ScrollView {
                anchors.fill: parent
                clip: true

                ListView {
                    model: FolderListModel {
                        folder: StandardPaths.writableLocation(StandardPaths.MoviesLocation)
                        nameFilters: ["*.mp4", "*.mkv", "*.wmv"]
                    }
                    delegate: FluidControls.ListItem {
                        text: model.fileName
                        highlighted: player.source === model.fileURL
                        onClicked: {
                            player.source = model.fileURL;
                            player.play();
                            libraryDrawer.close();
                        }
                    }
                }
            }
        }
    }
}
