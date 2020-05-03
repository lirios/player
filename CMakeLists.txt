# SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
#
# SPDX-License-Identifier: CC0-1.0

cmake_minimum_required(VERSION 3.10.0)

project("Player"
    VERSION "0.1.0"
    DESCRIPTION "Media player"
    LANGUAGES CXX C
)

## Shared macros and functions:
if(PLAYER_WITH_FLUID AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/fluid/CMakeLists.txt")
    set(LIRI_LOCAL_ECM TRUE)
    set(FLUID_WITH_DOCUMENTATION FALSE)
    set(FLUID_WITH_DEMO FALSE)
endif()
if(LIRI_LOCAL_ECM)
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/fluid/cmake/shared/modules")
else()
    find_package(LiriCMakeShared "1.0.0" REQUIRED NO_MODULE)
    list(APPEND CMAKE_MODULE_PATH "${LCS_MODULE_PATH}")
endif()

## Set minimum versions required.
set(QT_MIN_VERSION "5.10.0")

## Liri specific setup common for all modules:
include(LiriSetup)

## Features:
option(PLAYER_WITH_FLUID "Build together with Fluid" OFF)
add_feature_info("Player::WithFluid" PLAYER_WITH_FLUID "Build together with Fluid")

## Find Qt 5.
find_package(Qt5 "${QT_MIN_VERSION}"
    CONFIG REQUIRED
    COMPONENTS
        Core
        Gui
        Widgets
        Multimedia
        Qml
        Quick
        QuickControls2
)

## Add subdirectories:
add_subdirectory(src/app)
