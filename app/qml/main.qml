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
import QtQuick.Controls.Material 2.0
import QtQuick.Layouts 1.1
import Fluid.Core 1.0
import Fluid.Controls 1.0
import QtGSettings 1.0
import Vibe.Wallet 1.0

FluidWindow {
    id: mainWindow

    property TerminalTab activeTab: tabbedPage.selectedTab
    property bool __skipConfirmClose: false

    title: activeTab ? activeTab.title : "Terminal"
    minimumWidth: 250
    minimumHeight: 250
    width: 800
    height: 600
    visible: true

    Material.primary: Material.color(Material.BlueGrey, Material.Shade800)
    Material.accent: Material.color(Material.LightBlue, Material.Shade800)
    decorationColor: Material.color(Material.BlueGrey, Material.Shade900)

    function pasteClipboard() {
        if (clipboard.text.indexOf("sudo") === 0 && !settings.hideSudoWarning) {
            sudoWarningDialog.open()
        } else {
            activeTab.terminal.pasteClipboard()
        }
    }

    function addNewTab() {
        console.log("Adding tab...")
        var tab = terminalTabComponent.createObject(tabbedPage)
        tabbedPage.addTab(tab)
        tab.focus()
    }

    onActiveTabChanged: {
        if (activeTab)
            activeTab.focus()
    }

    onClosing: {
        if (__skipConfirmClose)
            return

        var activeProcesses = []

        for (var i = 0; i < tabbedPage.tabs.count; i++) {
            var tab = tabbedPage.tabs.getTab(i)

            if (tab.session.hasActiveProcess) {
                activeProcesses.push(tab.session.foregroundProcessName)
            }
        }

        if (activeProcesses.length > 0) {
            close.accepted = false
            confirmCloseDialog.processes = activeProcesses
            confirmCloseDialog.show()
        }
    }

    Component.onCompleted: activeTab.focus()

    Action {
        shortcut: settings.smartCopyPaste ? StandardKey.Copy : "Ctrl+Shift+C"
        enabled: activeTab.terminal.hasSelection || !settings.smartCopyPaste
        onTriggered: activeTab.terminal.copyClipboard()
    }

    Action {
        shortcut: settings.smartCopyPaste ? StandardKey.Paste : "Ctrl+Shift+V"
        onTriggered: pasteClipboard()
    }

    // TODO: Implement search
    // Action {
    //     shortcut: "Ctrl+F"
    //     onTriggered: searchButton.visible = !searchButton.visible
    // }

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
        onTriggered: settings.fontSize++
    }

    Action {
        shortcut: StandardKey.ZoomOut
        onTriggered: settings.fontSize--
    }

    initialPage: TabbedPage {
        id: tabbedPage
        title: qsTr("Terminal")

    //     actionBar.tabBar.visible: tabs.count > 1
    //     actionBar.integratedTabBar: true
    //
        actions: [
            // TODO: Only show when a physical keyboard is not available
            // Action {
            //     iconName: "content/content_paste"
            //     text: qsTr("Paste")
            //     shortcut: StandardKey.Paste
            //     onTriggered: pasteClipboard()
            // },
            Action {
                iconName: "content/add"
                text: qsTr("Open new tab")
                shortcut: StandardKey.AddTab

                onTriggered: addNewTab()
            },
            Action {
                iconName: "action/open_in_new"
                text: qsTr("Open new window")
                shortcut: "Ctrl+Shift+N"
                onTriggered: {
                    actionHandler.newWindow();
                    console.log("New window")
                }
            },
            Action {
                visible: wallet.enabled
                enabled: wallet.status === KQuickWallet.Open
                iconName: "communication/vpn_key"
                text: qsTr("Passwords")
                onTriggered: passwordsDialog.open()
            },
            // TODO: Implement search
            // Action {
            //     iconName: "action/search"
            //     text: qsTr("Search")
            // },
            Action {
                iconName: "action/settings"
                text: qsTr("Settings")
                onTriggered: settingsDialog.open();
            }
        ]

        TerminalTab {}

        onSelectedTabChanged: selectedTab.focus()

        onCountChanged: {
            if (count == 0)
                Qt.quit()
        }
    }

    Clipboard {
        id: clipboard
    }

    GSettings {
        id: settings
        // TODO: This is the way to do it, but the method is not invokable from QML
        // onOpacityChanged: terminal.setOpacity(opacity)
    }

    KQuickWallet {
        id: wallet

        folder: "Terminal Passwords"
    }

    ConfirmCloseDialog {
        id: confirmCloseDialog

        onAccepted: {
            __skipConfirmClose = true
            mainWindow.close()
        }
    }

    PasswordsDialog {
        id: passwordsDialog
    }

    SettingsDialog {
        id: settingsDialog
    }

    SudoWarningDialog {
        id: sudoWarningDialog
    }

    Component {
        id: terminalTabComponent

        TerminalTab {}
    }
}
