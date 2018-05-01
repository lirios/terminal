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
import QtQuick.Controls.Material 2.1
import Fluid.Controls 1.1 as FluidControls

FluidControls.AlertDialog {
    id: sudoWarningDialog

    title: qsTr("Paste this command?")
    text: qsTr("This command is asking for administrative access to your computer.\n" +
               "Copying commands from the internet can be dangerous.\nBe sure you understand what this command does before running it:")

    footer: DialogButtonBox {
        Button {
            text: qsTr("Paste Anyway")
            flat: true

            Material.foreground: Material.color(Material.Red, Material.Shade500)
            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }

        Button {
            text: qsTr("Don't Paste")
            flat: true

            DialogButtonBox.buttonRole: DialogButtonBox.AcceptRole
        }
    }

    width: 410

    CommandItem {
        id: commandItem
    }

    onAccepted: activeTab.item.terminal.pasteClipboard()

    onOpened: commandItem.text = clipboard.text.trim()
}
