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

#include <QApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>

int main(int argc, char **argv)
{
    // Set the X11 WM_CLASS so X11 desktops can find the desktop file
    qputenv("RESOURCE_NAME", "io.liri.Player");

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv); // For file dialog
    app.setOrganizationName(QStringLiteral("Liri"));
    app.setOrganizationDomain(QStringLiteral("liri.io"));
    app.setApplicationName(QStringLiteral("Player"));
    app.setApplicationVersion(QStringLiteral(PLAYER_VERSION));
    app.setApplicationDisplayName(QStringLiteral("Player"));
    app.setDesktopFileName(QStringLiteral("io.liri.Player.desktop"));
    app.setQuitOnLastWindowClosed(true);

    QQuickStyle::setStyle(QStringLiteral("Material"));

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
