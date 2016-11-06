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
import QtQuick.Controls 2.0
import Fluid.Controls 1.0 as Controls

Controls.Dialog {
    id: passwordsDialog
    title: qsTr("Passwords")

    width: minimumWidth

    positiveButtonText: qsTr("Add Password")
    negativeButtonText: qsTr("Close")

    onOpened: passwordsListView.model = wallet.entryList()

    onAccepted: addPasswordDialog.open()

    ListView {
        id: passwordsListView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: -24

        height: 250

        delegate: Controls.ListItem {
            height: 48

            onClicked: {
                passwordsDialog.close()
                terminal.insertText(wallet.readPassword(modelData) + '\n')
            }

            Controls.SubheadingLabel {
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    margins: 24
                }

                elide: Text.ElideRight
                text: modelData
            }
        }

        Column {
            anchors.centerIn: parent

            spacing: 8
            opacity: 0.5
            visible: passwordsListView.count == 0

            Controls.Icon {
                name: "communication/vpn_key"
                anchors.horizontalCenter: parent.horizontalCenter
                size: 48
            }
            Controls.SubheadingLabel {
                horizontalAlignment: Text.AlignHCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: qsTr("Add your passwords here for easy access when using sudo, SSH, or other commands that require passwords.")
                wrapMode: Text.Wrap
                width: passwordsListView.width - (16 * 2)
            }
        }
    }

    AddPasswordDialog {
        id: addPasswordDialog
    }
}
