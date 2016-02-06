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
import Material 0.2
import Material.ListItems 0.1 as ListItem
import QtQuick.Layouts 1.1
import Papyros.Terminal 1.0

Tab {
    id: tab

    property bool __skipConfirmClose

    title: {
        var title = item && item.session.title ? item.session.title : "..."

        var titleParts = title.split(/\s+/)

        if (titleParts.length == 2 && titleParts[1].indexOf('/home/') == 0) {
            var command = titleParts[0]
            var path = titleParts[1]
            var lastIndex = path.lastIndexOf('/')
            var dirName = path.substring(lastIndex + 1)

            return dirName + " : " + command
        } else {
            return title
        }
    }

    canRemove: true

    onClosing: {
        if (__skipConfirmClose)
            return

        item.confirmClose(close)
    }

    function focus() {
        if (item)
            item.terminal.forceActiveFocus()
    }

    Item {
        anchors.fill: parent

        property alias session: mainsession
        property alias terminal: terminal

        function confirmClose(close) {
            if (session.hasActiveProcess) {
                close.accepted = false
                confirmCloseDialog.processes = [session.foregroundProcessName]
                confirmCloseDialog.show()
            }
        }

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

            Keys.onEscapePressed: {
                if (hasSelection)
                    terminal.clearSelection()
            }

            Connections {
                target: settings
                onOpacityChanged: terminal.setOpacity(settings.opacity/100)
            }

            QMLTermScrollbar {
                id: scrollbar
                terminal: terminal
                anchors.margins: Units.dp(2) * Screen.devicePixelRatio
                width: Units.dp(5) * Screen.devicePixelRatio
                Rectangle {
                    anchors.fill: parent
                    anchors.topMargin: 1
                    anchors.bottomMargin: 1
                    color: "white"
                    radius: width /2
                    opacity: 0.7
                }
            }
        }

        ConfirmCloseDialog {
            id: confirmCloseDialog

            singleTab: true

            onAccepted: {
                tab.__skipConfirmClose = true
                tab.close()
            }
        }
    }
}
