/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2019 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

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
