/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2016 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
 * Copyright (C) 2016 Žiga Patačko Koderman <ziga.patacko@gmail.com>
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 2.0
import Liri.Terminal 1.0

Item {
    id: tab

    readonly property int index: SwipeView.index

    property alias terminal: terminal
    property alias session: terminal.session
    property ColorScheme colorScheme: ColorSchemeManager.findColorScheme(settings.colorScheme)

    property string title: {
        var title = terminal.session.displayedTitle ? terminal.session.displayedTitle : qsTr("Terminal %1").arg(SwipeView.index + 1);

        var titleParts = title.split(/\s+/);

        if (titleParts.length === 2 && titleParts[1].indexOf('/home/') === 0) {
            var command = titleParts[0];
            var path = titleParts[1];
            var lastIndex = path.lastIndexOf('/');
            var dirName = path.substring(lastIndex + 1);

            return dirName + " : " + command;
        } else {
            return title;
        }
    }

    function focus() {
        terminal.forceActiveFocus();
    }

    function confirmClose(close) {
        if (terminal.session.hasActiveProcess) {
            close.accepted = false;
            confirmCloseDialog.processes = [terminal.session.foregroundProcessName];
            confirmCloseDialog.show();
        }
    }

    QMLTermWidget {
        id: terminal

        anchors.fill: parent

        font.family: settings.fontFamily
        font.pointSize: settings.fontSize
        colorScheme: settings.colorScheme

        session: QMLTermSession {
            initialWorkingDirectory: "$HOME"
            shellProgram: settings.shellProgram
            onFinished: {
                tabsModel.remove(tab.index);
                tabsView.takeItem(tab.index);
            }
        }

        Keys.onEscapePressed: {
            if (terminal.hasSelection)
                terminal.clearSelection();
            else
                event.accepted = false;
        }

        Component.onCompleted: {
            terminal.session.startShellProgram();
            tab.colorScheme.setOpacity(settings.opacity/100);
            tab.focus();
        }

        Connections {
            target: settings
            onOpacityChanged: tab.colorScheme.setOpacity(settings.opacity/100)
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

        function insertText(text) {
            simulateKeyPress(0, Qt.NoModifier, true, 0, text);
        }
    }
}
