/****************************************************************************
 * This file is part of Liri.
 *
 * Copyright (C) 2016 Michael Spencer <sonrisesoftware@gmail.com>
 *
 * $BEGIN_LICENSE:GPL3+$
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * $END_LICENSE$
 ***************************************************************************/

import QtQuick 2.4
import QtQuick.Controls 2.0
import QtQuick.Controls.Material 2.0

Item {
    property alias text: textLabel.text

    width: parent.width
    height: textLabel.height

    Rectangle {
        id: bar
        width: 3
        height: parent.height
        radius: width/2
        color: textLabel.color
    }

    Label {
        id: textLabel

        anchors {
            left: bar.right
            right: parent.right
            leftMargin: 8
        }

        wrapMode: Text.Wrap
        font.family: settings.fontFamily
        font.pixelSize: 16
        color: Material.hintTextColor
    }
}
