<!--
SPDX-FileCopyrightText: 2020 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>

SPDX-License-Identifier: CC0-1.0
-->

Player
======

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/lirios/player.svg)](https://github.com/lirios/player)
[![GitHub issues](https://img.shields.io/github/issues/lirios/player.svg)](https://github.com/lirios/player/issues)
[![CI](https://github.com/lirios/player/workflows/CI/badge.svg?branch=develop&event=push)](https://github.com/lirios/player/actions?query=workflow%3ACI)

Liri Player is a cross-platform, Material Design video player.

We aim to create a minimalistic, slick and simple video player
providing all the features you would expect from a modern player.

Following Google's Material Design allows us to make interface
clean and beautiful.

![Screenshot](https://raw.githubusercontent.com/lirios/player/develop/data/appdata/player1.png)

## Dependencies

Qt >= 5.10.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
 * [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git)
 * [qtmultimedia](http://code.qt.io/cgit/qt/qtmultimedia.git)

The following modules and their dependencies are required:

 * [cmake](https://gitlab.kitware.com/cmake/cmake) >= 3.10.0
 * [cmake-shared](https://github.com/lirios/cmake-shared.git) >= 1.0.0
 * [fluid](https://github.com/lirios/fluid) >= 1.0.0

## Installation

```sh
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=/path/to/prefix ..
make
make install # use sudo if necessary
```

Replace `/path/to/prefix` to your installation prefix.
Default is `/usr/local`.

## Credits

The icon is a different coloring of `multimedia-video-player.svg` from
[paper-icon-theme](https://github.com/snwh/paper-icon-theme) under the
terms of the [CC BY-SA 4.0](https://creativecommons.org/licenses/by-sa/4.0/)
license.

## Licensing

Licensed under the terms of the GNU General Public License version 3 or,
at your option, any later version.
