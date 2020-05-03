# SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
#
# SPDX-License-Identifier: CC0-1.0

# Translations
file(GLOB LiriPlayer_TRANSLATIONS "${CMAKE_SOURCE_DIR}/translations/app/*_*.ts")
qt5_add_translation(LiriPlayer_QM_FILES ${LiriPlayer_TRANSLATIONS})
if(WIN32)
    set(_translations_destdir "${CMAKE_CURRENT_BINARY_DIR}/translations")
elseif(APPLE)
    set(_translations_destdir "${CMAKE_CURRENT_BINARY_DIR}/Contents/Resources/data/translations")
elseif(LINUX OR BSD)
    set(_translations_destdir "${INSTALL_DATADIR}/liri-player/translations")
endif()
if(DEFINED _translations_destdir)
    install(FILES ${LiriPlayer_QM_FILES} DESTINATION "${_translations_destdir}")
endif()

if(APPLE OR WIN32)
    set(LiriPlayer_OUTPUT_NAME "LiriPlayer")
else()
    set(LiriPlayer_OUTPUT_NAME "liri-player")
endif()

liri_add_executable("LiriPlayer"
    OUTPUT_NAME
        "${LiriPlayer_OUTPUT_NAME}"
    SOURCES
        main.cpp
        ${LiriPlayer_QM_FILES}
    RESOURCES
        player.qrc
    DEFINES
        QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
	PLAYER_VERSION="${PROJECT_VERSION}"
    APPDATA
        "${CMAKE_CURRENT_SOURCE_DIR}/../../data/appdata/io.liri.Player.appdata.xml"
    DESKTOP
        "${CMAKE_CURRENT_SOURCE_DIR}/../../data/io.liri.Player.desktop"
    LIBRARIES
        Qt5::Core
        Qt5::Gui
        Qt5::Widgets
        Qt5::Qml
        Qt5::Quick
        Qt5::QuickControls2
    GUI
)

set_target_properties(LiriPlayer PROPERTIES
    MACOSX_BUNDLE_GUI_IDENTIFIER "io.liri.Player"
    MACOSX_BUNDLE_ICON_FILE "io.liri.Player"
    MACOSX_BUNDLE_SHORT_VERSION_STRING "${PROJECT_VERSION}"
)
