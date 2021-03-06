# SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
#
# SPDX-License-Identifier: CC0-1.0

if(UNIX AND NOT APPLE AND NOT ANDROID)
    file(GLOB png_icons "${CMAKE_CURRENT_SOURCE_DIR}/hicolor/*/*/*.png")
    file(GLOB svg_icons "${CMAKE_CURRENT_SOURCE_DIR}/hicolor/*/*/*.svg")
    foreach(source_path IN LISTS png_icons svg_icons)
        string(REPLACE "${CMAKE_CURRENT_SOURCE_DIR}/hicolor/" "" icon_basename "${source_path}")
        get_filename_component(icon_directory "${icon_basename}" DIRECTORY)
        string(REPLACE "${icon_directory}/" "" icon_filename "${icon_basename}")
        string(REGEX REPLACE "\.(png|svg)" "" icon_filename "${icon_filename}")
        set(dest_path "${INSTALL_DATADIR}/icons/hicolor/${icon_directory}/")
        install(FILES "${source_path}" DESTINATION "${dest_path}")
    endforeach()
endif()
