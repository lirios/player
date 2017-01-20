/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2019 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2015 Pierre Jacquier <pierrejacquier39@gmail.com>
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

import QtQuick 2.5
import QtQuick.Window 2.5
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtMultimedia 5.8
import Fluid.Controls 1.0 as FluidControls

Rectangle {
    id: bottomBar

    Material.theme: Material.Dark

    anchors.left: parent.left
    anchors.right: parent.right
    anchors.bottom: parent.bottom

    implicitWidth: toolButtons.width + time.paintedWidth + rightButtons.width + (FluidControls.Units.smallSpacing * 4)
    implicitHeight: toolButtons.height + slider.height

    gradient: Gradient {
        GradientStop { position: 0.0; color: "transparent" }
        GradientStop { position: 1.0; color: Qt.rgba(0, 0, 0, 0.6) }
    }

    Behavior on opacity {
        NumberAnimation { duration: 500 }
    }

    MouseArea {
        anchors.fill: parent
        z: 1000
        acceptedButtons: Qt.NoButton
        hoverEnabled: true
        onPositionChanged: {
            barsTimer.stop();
            topBar.opacity = 1.0;
            bottomBar.opacity = 1.0;
        }
    }

    ColumnLayout {
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        spacing: -FluidControls.Units.smallSpacing

        Slider {
            id: slider

            Layout.preferredWidth: bottomBar.width - (FluidControls.Units.smallSpacing * 2)
            Layout.alignment: Qt.AlignHCenter

            value: player.position / player.duration
            visible: player.status != MediaPlayer.NoMedia
            onPressedChanged: {
                if (player.seekable)
                    player.seek(value * player.duration);
            }
        }

        RowLayout {
            RowLayout {
                id: toolButtons
                spacing: FluidControls.Units.smallSpacing

                ToolButton {
                    id: prevButton
                    icon.source: FluidControls.Utils.iconUrl("av/skip_previous")
                    focusPolicy: Qt.TabFocus
                    enabled: player.playlist
                    onClicked: {
                        if (player.playlist)
                            player.playlist.previous();
                    }
                }

                ToolButton {
                    id: playButton
                    icon.source: {
                        var iconName;

                        switch (player.playbackState) {
                        case MediaPlayer.PlayingState:
                            iconName = "av/pause";
                            break;
                        case MediaPlayer.StoppedState:
                            iconName = "file/folder_open";
                            break;
                        case MediaPlayer.PausedState:
                            iconName = "av/play_arrow";
                            break;
                        }

                        switch (player.status) {
                        case MediaPlayer.NoMedia:
                            iconName = "file/folder_open";
                            break;
                        case MediaPlayer.Loading:
                        case MediaPlayer.Buffering:
                            iconName = "notification/sync";
                            break;
                        case MediaPlayer.EndOfMedia:
                            iconName = "av/replay";
                            break;
                        case MediaPlayer.Stalled:
                        case MediaPlayer.InvalidMedia:
                        case MediaPlayer.UnknownStatus:
                            iconName = "alert/error";
                            break;
                        default:
                            break;
                        }

                        return FluidControls.Utils.iconUrl(iconName);
                    }
                    focusPolicy: Qt.TabFocus
                    onClicked: {
                        switch (player.status) {
                        case MediaPlayer.NoMedia:
                        case MediaPlayer.EndOfMedia:
                        case MediaPlayer.Stalled:
                        case MediaPlayer.InvalidMedia:
                        case MediaPlayer.UnknownStatus:
                            fileDialog.open();
                            return;
                        default:
                            break;
                        }

                        if (player.playbackState == MediaPlayer.PlayingState)
                            player.pause();
                        else
                            player.play();
                    }
                }

                ToolButton {
                    id: nextButton
                    icon.source: FluidControls.Utils.iconUrl("av/skip_next")
                    focusPolicy: Qt.TabFocus
                    enabled: player.playlist
                    onClicked: {
                        if (player.playlist)
                            player.playlist.next();
                    }
                }
            }

            Item {
                Layout.fillWidth: true

                Label {
                    id: time

                    property bool h: ~~(player.position / 1000 / 3600) == 0

                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    text: {
                        if (player.playbackState == MediaPlayer.StoppedState)
                            return qsTr("Open a file");

                        switch (player.status) {
                        case MediaPlayer.NoMedia:
                            return qsTr("Open a file");
                        case MediaPlayer.Loading:
                            return qsTr("Opening...");
                        case MediaPlayer.Buffering:
                            return qsTr("Buffering...");
                        default:
                            break;
                        }

                        return qsTr("%1 / %2").arg(getTime(player.position, h)).arg(getTime(player.duration, h));
                    }
                }
            }

            RowLayout {
                id: rightButtons

                Layout.preferredWidth: cropButton.size * 5 + 50 + 100

                spacing: FluidControls.Units.smallSpacing

                ToolButton {
                    id: volumeButton
                    icon.source: FluidControls.Utils.iconUrl(player.muted ? "av/volume_mute" : "av/volume_up")
                    focusPolicy: Qt.TabFocus
                    onClicked: {
                        player.volume =
                                QtMultimedia.convertVolume(player.muted ? 100 : 0,
                                                           QtMultimedia.LogarithmicVolumeScale,
                                                           QtMultimedia.LinearVolumeScale);
                    }
                }

                Slider {
                    Layout.preferredWidth: 100

                    from: 0.0
                    to: 1.0
                    onVisualPositionChanged: {
                        player.volume =
                                QtMultimedia.convertVolume(visualPosition,
                                                           QtMultimedia.LogarithmicVolumeScale,
                                                           QtMultimedia.LinearVolumeScale);
                    }

                    Component.onCompleted: {
                        value = QtMultimedia.convertVolume(player.volume,
                                                           QtMultimedia.LinearVolumeScale,
                                                           QtMultimedia.LogarithmicVolumeScale);
                    }
                }

                ToolButton {
                    id: playlistButton
                    icon.source: FluidControls.Utils.iconUrl("av/queue_music")
                    focusPolicy: Qt.TabFocus
                    onClicked: {
                        playlistDrawer.open();
                    }
                }

                ToolButton {
                    id: cropButton
                    icon.source: FluidControls.Utils.iconUrl("image/crop_16_9")
                    focusPolicy: Qt.TabFocus
                    enabled: window.visibility != Window.FullScreen && player.playbackState == MediaPlayer.PlayingState
                    onClicked: {
                        window.height = Math.round((player.metaData.resolution.height / player.metaData.resolution.width) * (window.width + (FluidControls.Units.smallSpacing * 2)));
                    }
                }

                ToolButton {
                    id: fsButton
                    icon.source: FluidControls.Utils.iconUrl(window.visibility == Window.FullScreen ? "navigation/fullscreen_exit" : "navigation/fullscreen")
                    focusPolicy: Qt.TabFocus
                    onClicked: {
                        if (window.visibility == Window.FullScreen)
                            window.visibility = Window.Windowed;
                        else
                            window.visibility = Window.FullScreen;
                    }
                }
            }
        }
    }

    function getTime (ms, h) {
        ms = ms / 1000 + "";
        var sec_num = parseInt(ms, 10);
        var hours   = Math.floor(sec_num / 3600);
        var minutes = Math.floor((sec_num - (hours * 3600)) / 60);
        var seconds = sec_num - (hours * 3600) - (minutes * 60);
        if (hours < 10)
            hours = "0" + hours;
        if (minutes < 10)
            minutes = "0" + minutes;
        if (seconds < 10)
            seconds = "0" + seconds;
        var time = h ? hours + ':' + minutes + ':' + seconds : minutes + ':' + seconds;
        return time;
    }
}
