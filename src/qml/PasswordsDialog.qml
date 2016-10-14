/*
 * This file is part of Terminal.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
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
import Material 0.2
import Material.ListItems 0.1 as ListItem
import Papyros.Core 0.2

Dialog {
    id: passwordsDialog
    title: "Passwords"

    width: minimumWidth

    positiveButtonText: "Add Password"
    negativeButtonText: "Close"

    onOpened: passwordsListView.model = wallet.entryList()

    onAccepted: addPasswordDialog.show()

    ListView {
        id: passwordsListView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: Units.dp(-24)

        height: Units.dp(250)

        delegate: ListItem.BaseListItem {
            height: Units.dp(48)

            onClicked: {
                passwordsDialog.close()
                terminal.insertText(wallet.readPassword(modelData) + '\n')
            }

            Label {
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    margins: Units.dp(24)
                }

                elide: Text.ElideRight
                style: "subheading"
                text: modelData
            }
        }

        Column {
            anchors.centerIn: parent

            spacing: Units.dp(8)
            opacity: 0.5
            visible: passwordsListView.count == 0

            Icon {
                name: "communication/vpn_key"
                anchors.horizontalCenter: parent.horizontalCenter
                size: Units.dp(48)
            }
            Label {
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                style: "subheading"
                text: "Add your passwords here for easy access when using sudo, SSH, or other commands that require passwords."
                wrapMode: Text.Wrap
                width: passwordsListView.width - Units.dp(16 * 2)
            }
        }
    }

    AddPasswordDialog {
        id: addPasswordDialog
    }
}
