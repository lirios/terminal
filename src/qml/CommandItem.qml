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

Item {
    property alias text: textLabel.text

    width: parent.width
    height: textLabel.height

    Rectangle {
        id: bar
        width: Units.dp(3)
        height: parent.height
        radius: width/2
        color: textLabel.color
    }

    Label {
        id: textLabel

        anchors {
            left: bar.right
            right: parent.right
            leftMargin: Units.dp(8)
        }

        wrapMode: Text.Wrap
        font.family: settings.fontFamily
        font.pixelSize: Units.dp(16)
        color: Theme.light.subTextColor
    }
}
