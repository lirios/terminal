/*
 * Papyros Terminal - The terminal app for Papyros following Material Design
 * Copyright (C) 2016 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
 *               2016 Žiga Patačko Koderman <ziga.patacko@gmail.com>
 *               2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.4
import QtQuick.Window 2.2
import QMLTermWidget 1.0
import Material 0.2
import Material.ListItems 0.1 as ListItem
import QtQuick.Layouts 1.1

Tab {
    id: tab

    title: item && item.session.title ? item.session.title : "..."

    canRemove: true

    function focus() {
        if (item)
            item.terminal.forceActiveFocus()
    }

    Item {
        anchors.fill: parent

        property alias session: mainsession
        property alias terminal: terminal

        QMLTermWidget {
            id: terminal

            anchors.centerIn: parent

            width: tabbedPage.width * Screen.devicePixelRatio + 2
            height: tabbedPage.height * Screen.devicePixelRatio + 2
            scale: 1/Screen.devicePixelRatio

            font.family: settings.fontFamily
            font.pointSize: settings.fontSize * Screen.devicePixelRatio
            colorScheme: "cool-retro-term"

            session: QMLTermSession {
                id: mainsession
                initialWorkingDirectory: "$HOME"
                shellProgram: settings.shellProgram
                onFinished: tabbedPage.tabs.removeTab(index)
            }

            function insertText(text) {
                simulateKeyPress(0, Qt.NoModifier, true, 0, text);
            }

            Component.onCompleted: {
                mainsession.startShellProgram();
            }
        }
    }
}
