/*
 * Papyros Terminal - The terminal app for Papyros following Material Design
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

Dialog {
    id: sudoWarningDialog

    title: "This command is asking for administrative access to your computer"
    text: "Copying commands from the internet can be dangerous. Be sure you understand what this command does before running it:"

    positiveButtonText: "Paste Anyway"
    negativeButtonText: "Don't Paste"

    positiveButton.textColor: Palette.colors["red"]["500"]

    width: Units.dp(410)

    CommandItem {
        id: commandItem
    }

    onAccepted: activeTab.item.terminal.pasteClipboard()

    onOpened: commandItem.text = clipboard.text().trim()
}
