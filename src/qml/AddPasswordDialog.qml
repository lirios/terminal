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
import Papyros.Core 0.2

Dialog {
    id: addPasswordDialog

    title: "Add Password"
    positiveButtonText: "Save"

    onOpened: {
        titleField.text = ""
        passwordField.text = ""
    }

    onAccepted: {
        wallet.writePassword(titleField.text, passwordField.text)
        passwordsDialog.show()
    }

    Item { height: Units.dp(8); width: parent.width }

    TextField {
        id: titleField
        floatingLabel: true
        width: parent.width
        placeholderText: "Title"
    }

    Item { height: Units.dp(8); width: parent.width }

    TextField {
        id: passwordField
        floatingLabel: true
        width: parent.width
        placeholderText: "Password"
        echoMode: TextInput.Password
    }
}
