/*
 * This file is part of Terminal.
 *
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
import QtQuick.Controls 2.0
import Fluid.Controls 1.0
import QtQuick.Layouts 1.1
import Liri.Terminal 1.0

Tab {
    id: tab

    property bool __skipConfirmClose: false

    property alias terminal: terminal
    property alias session: terminal.session

    title: {
        var title = session.title ? session.title : "..."

        var titleParts = title.split(/\s+/)

        if (titleParts.length === 2 && titleParts[1].indexOf('/home/') === 0) {
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

    /*
    onClosing: {
        if (__skipConfirmClose)
            return

        confirmClose(close)
    }
    */

    function focus() {
        terminal.forceActiveFocus()
    }

    function confirmClose(close) {
        if (session.hasActiveProcess) {
            close.accepted = false
            confirmCloseDialog.processes = [session.foregroundProcessName]
            confirmCloseDialog.show()
        }
    }

    QMLTermWidget {
        id: terminal

        anchors.fill: parent

        font.family: settings.fontFamily
        font.pointSize: settings.fontSize
        colorScheme: settings.colorScheme

        session: QMLTermSession {
            id: mainsession
            initialWorkingDirectory: "$HOME"
            shellProgram: settings.shellProgram
            onFinished: tabbedPage.removeTab(tab.SwipeView.index)
        }

        function insertText(text) {
            simulateKeyPress(0, Qt.NoModifier, true, 0, text);
        }

        Component.onCompleted: {
            mainsession.startShellProgram();
            tab.focus();
            terminal.setOpacity(settings.opacity/100)
        }

        Keys.onEscapePressed: {
            if (terminal.hasSelection)
                terminal.clearSelection()
            else
                event.accepted = false
        }

        Connections {
            target: settings
            onOpacityChanged: terminal.setOpacity(settings.opacity/100)
        }

        QMLTermScrollbar {
            id: scrollbar
            terminal: terminal
            anchors.margins: 2
            width: 5
            Rectangle {
                anchors.fill: parent
                anchors.topMargin: 1
                anchors.bottomMargin: 1
                color: "white"
                radius: width /2
                opacity: 0.7
            }
        }

        MouseArea {
            anchors.fill: parent
            onPressed: tab.focus()
        }
    }

    // ConfirmCloseDialog {
    //     id: confirmCloseDialog
    //
    //     singleTab: true
    //
    //     onAccepted: {
    //         tab.__skipConfirmClose = true
    //         tab.close()
    //     }
    // }
}
