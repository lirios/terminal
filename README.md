Terminal
========

[![ZenHub.io](https://img.shields.io/badge/supercharged%20by-zenhub.io-blue.svg)](https://zenhub.io)

[![License](https://img.shields.io/badge/license-GPLv3.0-blue.svg)](https://www.gnu.org/licenses/gpl-3.0.html)
[![GitHub release](https://img.shields.io/github/release/lirios/terminal.svg)](https://github.com/lirios/terminal)
[![Build Status](https://travis-ci.org/lirios/terminal.svg?branch=develop)](https://travis-ci.org/lirios/terminal)
[![GitHub issues](https://img.shields.io/github/issues/lirios/terminal.svg)](https://github.com/lirios/terminal/issues)
[![Maintained](https://img.shields.io/maintenance/yes/2018.svg)](https://github.com/lirios/terminal/commits/develop)

Terminal for Liri OS.

## Dependencies

Qt >= 5.8.0 with at least the following modules is required:

 * [qtbase](http://code.qt.io/cgit/qt/qtbase.git)
 * [qtdeclarative](http://code.qt.io/cgit/qt/qtdeclarative.git)
 * [qtquickcontrols2](http://code.qt.io/cgit/qt/qtquickcontrols2.git)
 * [qttools](http://code.qt.io/cgit/qt/qttools.git/)

The following modules and their dependencies are required:

 * [qbs-shared](https://github.com/lirios/qbs-shared.git)
 * [fluid](https://github.com/lirios/fluid)
 * [qtgsettings](https://github.com/lirios/qtgsettings)
 * [vibe](https://github.com/lirios/vibe)

## Installation

Qbs is a new build system that is much easier to use compared to qmake or CMake.

If you want to learn more, please read the [Qbs manual](http://doc.qt.io/qbs/index.html),
especially the [setup guide](http://doc.qt.io/qbs/configuring.html) and how to install artifacts
from the [installation guide](http://doc.qt.io/qbs/installing-files.html).

From the root of the repository, run:

```sh
qbs setup-toolchains --type gcc /usr/bin/g++ gcc
qbs setup-qt /usr/bin/qmake-qt5 qt5
qbs config profiles.qt5.baseProfile gcc
qbs -d build -j $(nproc) profile:qt5 # use sudo if necessary
```

On the last `qbs` line, you can specify additional configuration parameters at the end:

 * `qbs.installRoot:/path/to/install` (for example `/`)
 * `qbs.installPrefix:path/to/install` (for example `opt/liri` or `usr`)

The installation path is given by concatenating `qbs.installRoot` and `qbs.installPrefix`.

The following are only needed if `qbs.installRoot` is a system-wide path such as `/`
and the default value doesn't suit your needs. All are relative to the installation path:

 * `lirideployment.libDir:path/to/lib` where libraries are installed (default: `lib`)
 * `lirideployment.qmlDir:path/to/qml` where QML plugins are installed (default: `lib/qml`)

See [lirideployment.qbs](https://github.com/lirios/qbs-shared/blob/develop/modules/lirideployment/lirideployment.qbs)
for more deployment-related parameters.

If you specify `qbs.installRoot` you might need to prefix the entire line with `sudo`,
depending on whether you have permissions to write there or not.

## Licensing

Licensed under the terms of the GNU General Public License version 3 or,
at your option, any later version.
