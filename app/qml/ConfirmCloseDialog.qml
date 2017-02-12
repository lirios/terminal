/*
 * This file is part of Terminal.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import Fluid.Controls 1.0 as FluidControls

FluidControls.AlertDialog {
    id: confirmCloseDialog

    property var processes: []
    property bool singleTab

    title: singleTab ? qsTr("Close tab?") : qsTr("Close Terminal?")
    text: singleTab
            ? qsTr("There is a process running in this tab. If you close the tab, the process will end.")
            : processes.length > 1
                    ? qsTr("There are %1 processes running in this window. If you quit Terminal, the processes will end.").arg(processes.length)
                    : qsTr("There is a process running in this window. If you quit Terminal, the process will end.")

    width: 400

    standardButtons: Dialog.Yes | Dialog.No

    Repeater {
        model: processes

        CommandItem {
            text: modelData
        }
    }
}
