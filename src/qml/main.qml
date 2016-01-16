/*
 * Papyros Terminal - The terminal app for Papyros following Material Design
 * Copyright (C) 2016 Ricardo Vieira <ricardo.vieira@tecnico.ulisboa.pt>
 *               2016 Žiga Patačko Koderman <ziga.patacko@gmail.com>
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
import Material 0.1
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0

ApplicationWindow {
    id: mainWindow

    property int defaultOpacity: 100
    property int defaultFontSize: 11
    property string defaultFontFamily: "RobotoMono"

    title: mainsession.title
    visible: true

    theme {
        primaryColor: Palette.colors.blueGrey["800"]
        primaryDarkColor: Palette.colors.blueGrey["900"]
    }

    Component.onCompleted: terminal.forceActiveFocus();

    Settings {
        id: settings

        property string fontFamily: defaultFontFamily
        property int fontSize: defaultFontSize
        property int opacity: defaultOpacity

        // TODO: This is the way to do it, but the method is not invokable from QML
        // onOpacityChanged: terminal.setOpacity(opacity)
    }

    Action {
        shortcut: "Ctrl+Shift+C"
        onTriggered: terminal.copyClipboard();
    }

    Action {
        shortcut: "Ctrl+Shift+V"
        onTriggered: terminal.pasteClipboard();
    }

    Action {
        shortcut: "Ctrl+F"
        onTriggered: searchButton.visible = !searchButton.visible
    }

    Action {
        shortcut: StandardKey.FullScreen

        onTriggered: {
            if (visibility === Window.Windowed) {
                showFullScreen()
            } else {
                showNormal()
            }
        }
    }

    Action {
        shortcut: StandardKey.ZoomIn
        onTriggered: terminal.font.pointSize++
    }

    Action {
        shortcut: StandardKey.ZoomOut
        onTriggered: terminal.font.pointSize--
    }

    initialPage: Page {
        title: "Terminal"

        actions: [
            Action {
                iconName: "content/add"
                text: qsTr("Open new tab")
                shortcut: StandardKey.AddTab

                onTriggered: console.log("New tab");
            },
            Action {
                iconName: "action/open_in_new"
                text: qsTr("Open new window")
                shortcut: "ctrl+Shift+N"
                onTriggered: {
                    actionHandler.newWindow();
                    console.log("New window")
                }
            },
            Action {
                iconName: "content/content_paste"
                text: qsTr("Paste")
                shortcut: StandardKey.Paste
                onTriggered: terminal.pasteClipboard();
            },
            Action {
                iconName: "action/search"
                text: qsTr("Search")
            },
            Action {
                iconName: "action/settings"
                text: qsTr("Settings")
                onTriggered: settingsDialog.show();
            }
        ]

        QMLTermWidget {
            id: terminal

            anchors.centerIn: parent

            width: parent.width * Screen.devicePixelRatio
            height: parent.height * Screen.devicePixelRatio
            scale: 1/Screen.devicePixelRatio

            font.family: settings.fontFamily
            font.pointSize: settings.fontSize * Screen.devicePixelRatio
            colorScheme: "cool-retro-term"

            session: QMLTermSession {
                id: mainsession
                initialWorkingDirectory: "$HOME"
                onFinished: Qt.quit()
            }

            Component.onCompleted: {
                mainsession.startShellProgram();
            }
        }
    }

    SettingsDialog {
        id: settingsDialog
    }
}
