Terminal app for Papryos
========================

[![Join the chat at https://gitter.im/papyros/core-apps](https://badges.gitter.im/papyros/core-apps.svg)](https://gitter.im/papyros/core-apps?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This is the terminal app for Papyros. The UI is built with our [Material Design framework](https://github.com/papyros/qml-material), and the backend is based on [QMLTermWidget](https://github.com/Swordfish90/qmltermwidget) used in [cool-retro-term](https://github.com/Swordfish90/cool-retro-term).

Brought to you by the [Papyros development team](https://github.com/papyros/terminal-app/graphs/contributors).

### Dependencies

 * Qt 5.3 or higher
 * [QML Material](https://github.com/papyros/qml-material)
 * [libpapyros](https://github.com/papyros/libpapyros)
 * [Our fork of QMLTermWidget](https://github.com/papyros/qmltermwidget)
 * [Extra CMake Modules](https://projects.kde.org/projects/kdesupport/extra-cmake-modules)
 * Roboto Mono for Powerline font

### Installation

From the root of the repository, run:

    mkdir build; cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr ..
    make
    sudo make install

And then run the terminal app:

    papyros-terminal

### Licensing

Papyros terminal is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
