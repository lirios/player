// SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
// SPDX-FileCopyrightText: 2015 Pierre Jacquier <pierrejacquier39@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

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
