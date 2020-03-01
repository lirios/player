// SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.5
import QtQuick.Window 2.5
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtMultimedia 5.8
import Qt.labs.platform 1.0
import Fluid.Controls 1.0 as FluidControls

FluidControls.Page {
    readonly property real minimumWidth: bottomBar.implicitWidth
    readonly property bool barsActive: topBar.opacity == 1.0 && bottomBar.opacity == 1.0
    property bool forceBars: false
    property bool temporaryForceBars: false

    onForceBarsChanged: {
        if (forceBars) {
            barsTimer.stop();
            topBar.opacity = 1.0;
            bottomBar.opacity = 1.0;
        }
    }
    onTemporaryForceBarsChanged: {
        if (temporaryForceBars) {
            barsTimer.stop();
            topBar.opacity = 1.0;
            bottomBar.opacity = 1.0;
        }
    }

    ListModel {
        id: playlistModel
        dynamicRoles: true
    }

    MediaPlayer {
        id: player

        playlist: Playlist {
            playbackMode: itemCount == 1 ? Playlist.CurrentItemOnce : Playlist.Loop
            onItemInserted: {
                for (var i = start; i <= end; i++)
                    playlistModel.append({ "source": this.itemSource(i) });
            }
            onItemRemoved: {
                for (var i = start; i <= end; i++)
                    playlistModel.remove(i);
            }
        }
        onPlaybackStateChanged: {
            if (playbackState != MediaPlayer.PlayingState) {
                barsTimer.stop();
                topBar.opacity = 1.0;
                bottomBar.opacity = 1.0;
            } else if (!forceBars && !temporaryForceBars) {
                barsTimer.restart();
                topBar.opacity = 1.0;
                bottomBar.opacity = 1.0;
            }
        }
    }

    PlaylistDrawer {
        id: playlistDrawer
    }

    LibraryDrawer {
        id: libraryDrawer
    }

    FileDialog {
        id: fileDialog

        currentFile: player.playlist.currentItemSource
        folder: StandardPaths.writableLocation(StandardPaths.MoviesLocation)
        onAccepted: {
            player.playlist.addItem(file);
            player.play();
        }
    }

    /*
     * Shortcuts
     */

    FluidControls.Action {
        shortcut: "Space"
        onTriggered: {
            if (player.playbackState == MediaPlayer.PlayingState)
                player.pause();
            else
                player.play();
        }
    }

    FluidControls.Action {
        shortcut: StandardKey.New
        onTriggered: {
            root.createWindow();
        }
    }

    FluidControls.Action {
        shortcut: StandardKey.Cancel
        onTriggered: {
            if (window.visibility == Window.FullScreen)
                showNormal();
        }
    }

    FluidControls.Action {
        shortcut: StandardKey.FullScreen
        onTriggered: {
            if (window.visibility == Window.FullScreen)
                showNormal();
            else
                showFullScreen();
        }
    }

    /*
     * Player
     */

    Rectangle {
        anchors.fill: parent
        color: player.status == MediaPlayer.NoMedia ? "white" : "black"

        VideoOutput {
            anchors.fill: parent
            source: player

            Column {
                Material.theme: Material.Dark

                anchors.left: parent.left
                anchors.leftMargin: FluidControls.Units.smallSpacing * 2
                anchors.topMargin: topBar.height + (FluidControls.Units.smallSpacing * 2)
                anchors.bottomMargin: bottomBar.height + (FluidControls.Units.smallSpacing * 2)
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - artwork.width - (FluidControls.Units.smallSpacing * 2 * 3)
                visible: player.hasAudio && !player.hasVideo && player.status != MediaPlayer.NoMedia

                FluidControls.DisplayLabel {
                    wrapMode: Text.WordWrap
                    text: player.metaData ? player.metaData.title || "" : ""
                    width: parent.width
                }

                FluidControls.HeadlineLabel {
                    wrapMode: Text.WordWrap
                    text: player.metaData ? player.metaData.albumArtist || "" : ""
                    width: parent.width
                    opacity: 0.8
                }

                FluidControls.HeadlineLabel {
                    wrapMode: Text.WordWrap
                    text: player.metaData ? player.metaData.albumTitle || "" : ""
                    width: parent.width
                    opacity: 0.6
                }
            }

            Image {
                id: artwork
                anchors {
                    top: parent.top
                    right: parent.right
                    bottom: parent.bottom
                }
                source: {
                    if (player.metaData)
                        return player.metaData.coverArtUrlLarge || player.metaData.coverArtUrlSmall || player.metaData.posterUrl || "";
                    return "";
                }
                width: height
                visible: player.status != MediaPlayer.NoMedia
            }
        }

        MouseArea {
            anchors.fill: parent
            anchors.topMargin: topBar.height
            anchors.bottomMargin: bottomBar.height
            hoverEnabled: true
            cursorShape: barsActive ? Qt.ArrowCursor : Qt.BlankCursor
            onPositionChanged: {
                if (!forceBars && !temporaryForceBars && player.playbackState == MediaPlayer.PlayingState)
                    barsTimer.restart();

                topBar.opacity = 1.0;
                bottomBar.opacity = 1.0;
            }
            onClicked: {
                if (player.playbackState == MediaPlayer.PlayingState)
                    player.pause();
                else
                    player.play();
            }
            onDoubleClicked: {
                if (window.visibility == Window.FullScreen)
                    window.showNormal();
                else
                    window.showFullScreen();
            }
        }

        Timer {
            id: barsTimer
            interval: 1500
            repeat: false
            onTriggered: {
                topBar.opacity = 0.0;
                bottomBar.opacity = 0.0;
            }
        }
    }

    /*
     * Bars
     */

    TopBar {
        id: topBar
    }

    BottomBar {
        id: bottomBar
    }
}
