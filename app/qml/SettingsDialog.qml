/*
 * This file is part of Terminal.
 *
 * Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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

    width: 560
    height: 450

    ColumnLayout {
        id: settingsList

        anchors.fill: parent
        anchors.leftMargin: -leftPadding
        anchors.rightMargin: -rightPadding

        /* Opacity doesn't work
        FluidControls.ListItem {
            text: qsTr("Background opacity")
            hoverEnabled: false
            valueText: opacitySlider.value

            secondaryItem: Slider {
                id: opacitySlider

                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                stepSize: 10
                snapMode: Slider.SnapAlways
                from: 10
                to: 100
                value: settings.opacity
                onMoved: settings.opacity = opacitySlider.value
            }
        }
        */

        FluidControls.ListItem {
            text: qsTr("Font size")
            valueText: fontSizeSlider.value
            hoverEnabled: false

            secondaryItem: Slider {
                id: fontSizeSlider

                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                stepSize: 1
                snapMode: Slider.SnapAlways
                value: settings.fontSize
                from: 8
                to: 32
                onMoved: settings.fontSize = fontSizeSlider.value
            }
        }

        FluidControls.ListItem {
            text: qsTr("Font family")
            hoverEnabled: false

            rightItem: ComboBox {
                id: fontFamily
                anchors.centerIn: parent
                width: 350
                model: fontFamilies
                textRole: "text"
                currentIndex: find(settings.fontFamily)
                onCurrentTextChanged: settings.fontFamily = fontFamily.currentText
            }
        }

        FluidControls.ListItem {
            text: qsTr("Color scheme")
            hoverEnabled: false

            rightItem: ComboBox {
                id: colorScheme
                anchors.centerIn: parent
                width: 350
                model: ListModel {
                    id: colorSchemeModel
                    ListElement { name: "BlackOnLightYellow"; description: "Black on Yellow Lights" }
                    ListElement { name: "BlackOnRandomLight"; description: "Black on Random Light" }
                    ListElement { name: "BlackOnWhite"; description: "Black on White" }
                    ListElement { name: "Breeze"; description: "Breeze" }
                    ListElement { name: "cool-retro-term"; description: "Cool Retro Terminal" }
                    ListElement { name: "DarkPastels"; description: "Dark Pastels" }
                    ListElement { name: "GreenOnBlack"; description: "Green on Black" }
                    ListElement { name: "Linux Colors"; description: "Linux" }
                    ListElement { name: "Solarized"; description: "Solarized" }
                    ListElement { name: "Solarized Light"; description: "Solarized Light" }
                    ListElement { name: "Tango"; description: "Tango" }
                    ListElement { name: "WhiteOnBlack"; description: "White on Black" }
                }
                textRole: "description"
                currentIndex: find(settings.colorScheme)
                onCurrentTextChanged: settings.colorScheme = colorSchemeModel.get(colorScheme.currentIndex).name
            }
        }

        FluidControls.ListItem {
            text: qsTr("Smart copy/paste")
            hoverEnabled: false

            onClicked: smartCopyPasteSwitch.checked = !smartCopyPasteSwitch.checked

            rightItem: Switch {
                id: smartCopyPasteSwitch
                anchors.centerIn: parent
                checked: settings.smartCopyPaste
                onVisualPositionChanged: settings.smartCopyPaste = smartCopyPasteSwitch.checked
            }
        }

        FluidControls.ListItem {
            hoverEnabled: false
            secondaryItem: TextField {
                id: shellProgramTextField

                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                //floatingLabel: true
                placeholderText: qsTr("Shell program")
                text: settings.shellProgram
                onAccepted: settings.shellProgram = shellProgramTextField.text
            }
        }

        Item {
            Layout.fillHeight: true
        }
    }
}
