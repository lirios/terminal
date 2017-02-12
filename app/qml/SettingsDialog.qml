/*
 * This file is part of Terminal.
 *
 * Copyright (C) 2017 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
 * Copyright (C) 2016 Žiga Patačko Koderman <ziga.patacko@gmail.com>
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

import QtQuick 2.2
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.1
import Fluid.Controls 1.0 as FluidControls

Dialog {
    title: qsTr("Settings")

    x: (parent.width - width) / 2
    y: (parent.height - height) / 2

    modal: true

    width: Math.min(parent.width * 0.7, 600)
    height: Math.min(parent.height * 0.7, 400)

    onAccepted: {
        settings.fontSize = fontSizeSlider.value
        settings.fontFamily = fontListItem.subText
        settings.shellProgram = shellProgramTextField.text
        settings.smartCopyPaste = smartCopyPasteSwitch.checked
    }

    ColumnLayout {
        id: settingsList

        width: parent.width

        Item {
            height: FluidControls.Units.largeSpacing
        }

        // TODO: The opacity setting doesn't work, so hide it
        // ListItem.Subtitled {
        //     text: "Background opacity"
        //
        //     content: Slider {
        //         id: opacitySlider
        //         width: parent.width
        //         anchors.verticalCenter: parent.verticalCenter
        //
        //         stepSize: 10
        //         minimumValue: 10
        //         maximumValue: 100
        //         value: settings.opacity
        //
        //         onValueChanged: settings.opacity = value
        //     }
        // }

        FluidControls.ListItem {
            text: qsTr("Font size")
            valueText: fontSizeSlider.value

            secondaryItem: Slider {
                id: fontSizeSlider

                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                stepSize: 1
                value: settings.fontSize
                from: 2
                to: 32
            }
        }

        FluidControls.ListItem {
            text: qsTr("Font family")

            rightItem: ComboBox {
                anchors.centerIn: parent
                model: fontFamilies
                textRole: "text"
                currentIndex: find(settings.fontFamily)
            }
        }

        FluidControls.ListItem {
            text: qsTr("Smart copy/paste")

            onClicked: smartCopyPasteSwitch.checked = !smartCopyPasteSwitch.checked

            rightItem: Switch {
                id: smartCopyPasteSwitch
                anchors.centerIn: parent
                checked: settings.smartCopyPaste
            }
        }

        FluidControls.ListItem {
            secondaryItem: TextField {
                id: shellProgramTextField

                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                //floatingLabel: true
                placeholderText: qsTr("Shell program")
                text: settings.shellProgram
            }
        }
    }
}
