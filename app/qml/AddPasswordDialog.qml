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
import QtQuick.Layouts 1.0
import Fluid.Controls 1.0 as Controls

Controls.Dialog {
    id: addPasswordDialog

    title: qsTr("Add Password")
    positiveButtonText: qsTr("Save")

    onOpened: {
        titleField.text = ""
        passwordField.text = ""
    }

    onAccepted: {
        wallet.writePassword(titleField.text, passwordField.text)
        passwordsDialog.open()
    }

    ColumnLayout {
        width: parent.width

        TextField {
            id: titleField
            //floatingLabel: true
            placeholderText: qsTr("Title")
            focus: true

            Layout.fillWidth: true
        }

        TextField {
            id: passwordField
            //floatingLabel: true
            placeholderText: qsTr("Password")
            echoMode: TextInput.Password

            Layout.fillWidth: true
        }
    }
}
