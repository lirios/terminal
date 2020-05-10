Terminal
========

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/lirios/terminal.svg)](https://github.com/lirios/terminal)
[![GitHub issues](https://img.shields.io/github/issues/lirios/terminal.svg)](https://github.com/lirios/terminal/issues)
[![CI](https://github.com/lirios/terminal/workflows/CI/badge.svg?branch=develop)](https://github.com/lirios/terminal/actions?query=workflow%3ACI)

A Material Design terminal.

## Dependencies

Qt >= 5.10.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
 * [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git)
 * [qttools](http://code.qt.io/cgit/qt/qttools.git/)

The following modules and their dependencies are required:

 * [cmake](https://gitlab.kitware.com/cmake/cmake) >= 3.10.0
 * [cmake-shared](https://github.com/lirios/cmake-shared.git) >= 1.0.0
 * [fluid](https://github.com/lirios/fluid.git) >= 1.1.0
 * [qtgsettings](https://github.com/lirios/qtgsettings) >= 1.1.0

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

## Licensing

Licensed under the terms of the GNU General Public License version 3 or,
at your option, any later version.
