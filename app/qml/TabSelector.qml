/*
 * This file is part of Terminal.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

ComboBox {
    id: control
    flat: true
    focusPolicy: Qt.NoFocus
    background: Item {
        implicitWidth: 120
        implicitHeight: 48

        // external vertical padding is 6 (to increase touch area)
        y: 6
        height: parent.height - 12
    }
    contentItem: Label {
        padding: 6
        leftPadding: control.mirrored ? 0 : 12
        rightPadding: control.mirrored ? 12 : 0
        text: title
        font: control.font
        color: control.enabled ? control.Material.foreground : control.Material.hintTextColor
        verticalAlignment: Text.AlignVCenter
    }
    delegate: MenuItem {
        width: parent.width
        text: modelData.title
        Material.foreground: control.currentIndex === index ? parent.Material.accent : parent.Material.foreground
        highlighted: control.highlightedIndex === index
        hoverEnabled: control.hoverEnabled
    }
}
