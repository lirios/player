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
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import QtMultimedia 5.0
import Fluid.Controls 1.0 as FluidControls

Rectangle {
    id: topBar

    Material.theme: Material.Dark

    anchors {
        top: parent.top
        left: parent.left
        right: parent.right
    }

    implicitHeight: 48

    gradient: Gradient {
        GradientStop {
            position: 0.0
            color: player.status == MediaPlayer.NoMedia
                   ? Material.primaryColor : Qt.rgba(0, 0, 0, 0.6)
        }
        GradientStop {
            position: 1.0
            color: player.status == MediaPlayer.NoMedia
                   ? Material.primaryColor : "transparent"
        }
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

    RowLayout {
        anchors {
            left: parent.left
            top: parent.top
        }
        spacing: FluidControls.Units.smallSpacing

        ToolButton {
            id: menuButton
            icon.source: FluidControls.Utils.iconUrl("navigation/menu")
            focusPolicy: Qt.TabFocus
            onClicked: {
                temporaryForceBars = true;
                menu.open(menuButton, menu.width - menuButton.width, 0);
            }
        }

        ToolButton {
            id: lockButton
            icon.source: FluidControls.Utils.iconUrl(forceBars ? "action/lock_open" : "action/lock")
            focusPolicy: Qt.TabFocus
            onClicked: {
                forceBars = !forceBars;
            }
        }

        ToolButton {
            id: libraryButton
            icon.source: FluidControls.Utils.iconUrl("av/library_music")
            focusPolicy: Qt.TabFocus
            onClicked: {
                libraryDrawer.open();
            }
        }

        FluidControls.TitleLabel {
            text: "Liri Player"
            visible: player.status == MediaPlayer.NoMedia

            Layout.alignment: Qt.AlignVCenter
        }

        FluidControls.TitleLabel {
            text: player.metaData ? player.metaData.title || "" : ""
            visible: player.status != MediaPlayer.NoMedia

            Layout.alignment: Qt.AlignVCenter
        }
    }

    Menu {
        id: menu
        onClosed: {
            temporaryForceBars = false;
        }

        MenuItem {
            text: qsTr("Open")
            icon.source: FluidControls.Utils.iconUrl("file/folder_open")
            focusPolicy: Qt.TabFocus
            action: FluidControls.Action {
                shortcut: StandardKey.Open
            }
            onClicked: {
                fileDialog.open();
            }
        }
        MenuItem {
            text: qsTr("Open and add to queue")
            icon.source: FluidControls.Utils.iconUrl("av/queue_music")
            focusPolicy: Qt.TabFocus
            onClicked: {
                fileDialog.open();
            }
        }
        MenuItem {
            text: qsTr("Stop")
            icon.source: FluidControls.Utils.iconUrl("av/stop")
            focusPolicy: Qt.TabFocus
            height: visible ? implicitHeight : 0
            visible: player.status != MediaPlayer.NoMedia
            onClicked: {
                player.stop();
            }
        }
        MenuItem {
            text: qsTr("Quit")
            icon.source: FluidControls.Utils.iconUrl("action/exit_to_app")
            focusPolicy: Qt.TabFocus
            action: FluidControls.Action {
                shortcut: StandardKey.Quit
            }
            onClicked: {
                Qt.quit();
            }
        }
    }

    SystemButtons {
        anchors {
            right: parent.right
            top: parent.top
        }
        onShowMinimized: window.showMinimized()
        onShowMaximized: window.showMaximized()
        onShowNormal: window.showNormal()
        onClose: Qt.quit()
    }
}
