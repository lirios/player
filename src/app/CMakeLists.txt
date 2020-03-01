# SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
#
# SPDX-License-Identifier: CC0-1.0

liri_add_executable(LiriPlayer
    OUTPUT_NAME
        "liri-player"
    SOURCES
        main.cpp
    RESOURCES
        player.qrc
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
	PLAYER_VERSION="${PROJECT_VERSION}"
    APPDATA
        "${CMAKE_CURRENT_SOURCE_DIR}/io.liri.Player.appdata.xml"
    DESKTOP
        "${CMAKE_CURRENT_SOURCE_DIR}/io.liri.Player.desktop"
    LIBRARIES
        Qt5::Core
        Qt5::Gui
        Qt5::Widgets
        Qt5::Qml
        Qt5::Quick
        Qt5::QuickControls2
    GUI
)