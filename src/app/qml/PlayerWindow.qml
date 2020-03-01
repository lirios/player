// SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.5
import QtQuick.Controls 2.3
import QtQuick.Controls.Material 2.3
import Fluid.Controls 1.0 as FluidControls

FluidControls.ApplicationWindow {
    id: window

    width: 750
    height: 430
    minimumWidth: playerPage.minimumWidth
    visible: true

    Material.primary: Material.Red
    Material.accent: Material.DeepOrange

    header: null

    initialPage: PlayerPage {
        id: playerPage
    }

    function pushPage(component) {
        window.pageStack.push(component);
    }
}
