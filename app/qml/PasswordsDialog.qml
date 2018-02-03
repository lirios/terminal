/*
 * This file is part of Terminal.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import QtQuick.Controls 2.1
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0 as FluidControls

Dialog {
    id: passwordsDialog
    title: qsTr("Passwords")

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    width: 400
    height: 400

    modal: true

    onOpened: passwordsListView.model = wallet.entryList()

    ColumnLayout {
        anchors.fill: parent
        spacing: FluidControls.Units.smallSpacing

        FluidControls.DialogLabel {
            text: qsTr("Add your passwords here for easy access when using sudo, SSH, or other commands that require passwords.")
            wrapMode: Text.Wrap

            Layout.fillWidth: true
        }

        Button {
            text: qsTr("Add Password")
            flat: true
            onClicked: {
                addPasswordDialog.open();
                accepted();
            }
        }

        ListView {
            id: passwordsListView

            delegate: FluidControls.ListItem {
                text: modelData || qsTr("n.a.")

                onClicked: {
                    passwordsDialog.close();
                    activeTab.terminal.insertText(wallet.readPassword(modelData) + '\n');
                }
            }

            Layout.fillWidth: true
            Layout.fillHeight: true

            ScrollBar.vertical: ScrollBar {}
        }
    }

    AddPasswordDialog {
        id: addPasswordDialog
        parent: parent.parent
    }
}
