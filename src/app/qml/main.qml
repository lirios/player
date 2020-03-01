// SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
//
// SPDX-License-Identifier: GPL-3.0-or-later

import QtQuick 2.10

Item {
    id: root

    Component {
        id: windowComponent

        PlayerWindow {}
    }

    function createWindow() {
        var newWindow = windowComponent.createObject(root);
        newWindow.showNormal();
        return newWindow;
    }

    Component.onCompleted: {
        createWindow();
    }
}
