// SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

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
