Terminal app for Papryos
========================

[![Join the chat at https://gitter.im/papyros/terminal-app](https://badges.gitter.im/papyros/terminal-app.svg)](https://gitter.im/papyros/terminal-app?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

This is the terminal app for Papyros. The UI is build with our [Material Design framework](https://github.com/papyros/qml-material), and the backend is based on the [QMLTermWidget](https://github.com/Swordfish90/qmltermwidget) used in [cool-retro-term](https://github.com/Swordfish90/cool-retro-term).

Brought to you by the [Papyros development team](https://github.com/papyros/terminal-app/graphs/contributors).

### Dependencies

 * Qt 5.3 or higher
 * [QML Material](https://github.com/papyros/qml-material)
 * [QMLTermWidget](https://github.com/Swordfish90/qmltermwidget)

### Installation

From the root of the repository, run:

    $ mkdir build; cd build
    $ cmake -DCMAKE_INSTALL_PREFIX=/usr ..
    $ make
    $ sudo make install

### Licensing

Papyros terminal is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.
