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

import QtQuick 2.4
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.3
import Fluid.Controls 1.0 as FluidControls

Item {
    id: systemButtons

    signal showMinimized()
    signal showMaximized()
    signal showFullScreen()
    signal showNormal()
    signal close()

    RowLayout {
        anchors{
            right: parent.right
            top: parent.top
        }
        spacing: FluidControls.Units.smallSpacing

        ToolButton {
            icon.source: "qrc:///images/window-minimize.svg"
            icon.width: 20
            icon.height: 20
            onClicked: {
                systemButtons.showMinimized();
            }
        }

        ToolButton {
            icon.source: window.visibility == Window.Maximized ? "qrc:///images/window-restore.svg" : "qrc:///images/window-maximize.svg"
            icon.width: 20
            icon.height: 20
            onClicked: {
                if (window.visibility == Window.Windowed)
                    systemButtons.showMaximized();
                else
                    systemButtons.showNormal();
            }
        }

        ToolButton {
            icon.source: "qrc:///images/window-close.svg"
            icon.width: 20
            icon.height: 20
            onClicked: {
                systemButtons.close();
            }
        }
    }
}
