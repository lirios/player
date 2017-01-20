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
import QtQuick.Layouts 1.0
import Qt.labs.platform 1.0
import Fluid.Controls 1.0 as FluidControls

FluidControls.NavigationDrawer {
    id: playlistDrawer

    topContent: RowLayout {
        spacing: FluidControls.Units.smallSpacing

        FluidControls.TitleLabel {
            Layout.alignment: Qt.AlignVCenter

            text: qsTr("Playlist")
        }

        ToolButton {
            icon.source: FluidControls.Utils.iconUrl("action/done_all")

            onClicked: {
                player.playlist.clear();
            }
        }
    }

    width: window.width * 0.5

    modal: true
    interactive: true
    position: 0.0
    visible: false

    FileDialog {
        id: playlistFileDialog

        folder: StandardPaths.writableLocation(StandardPaths.MoviesLocation)
        onAccepted: {
            player.playlist.addItem(file);
        }
    }

    ColumnLayout  {
        anchors.fill: parent

        ListView {
            Layout.fillWidth: true
            Layout.fillHeight: true

            model: playlistModel
            delegate: FluidControls.ListItem {
                icon.source: FluidControls.Utils.iconUrl(index === player.playlist.currentIndex ? "av/play_arrow" : "")
                text: model.source
                highlighted: index === player.playlist.currentIndex
                onClicked: {
                    player.playlist.currentIndex = index;
                    player.play();
                    playlistDrawer.close();
                }
            }
        }

        Button {
            Layout.fillWidth: true

            text: qsTr("Add")

            onClicked: {
                playlistFileDialog.open();
            }
        }
    }
}
