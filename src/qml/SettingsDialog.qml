/*
 * Papyros Terminal - The terminal app for Papyros following Material Design
 * Copyright (C) 2016 Žiga Patačko Koderman <ziga.patacko@gmail.com>
 *               2016 Michael Spencer <sonrisesoftware@gmail.com>
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
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import Material 0.2
import Material.Extras 0.1
import Material.ListItems 0.1 as ListItem
import QtQuick.Controls 1.3 as QuickControls

Dialog {
    title: "Settings"

    height: Math.min(parent.height * 0.7, Units.dp(400))

    onAccepted: {
        settings.fontSize = fontSizeSlider.value
        settings.fontFamily = fontListItem.subText
        settings.shellProgram = shellProgramTextField.text
    }

    Column {
        id: settingsList
        anchors.left: parent.left
        anchors.right: parent.right

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

        ListItem.Subtitled {
            text: "Font size"
            valueText: fontSizeSlider.value

            content: Slider {
                id: fontSizeSlider

                width: parent.width
                anchors.verticalCenter: parent.verticalCenter

                stepSize: 1
                value: settings.fontSize
                minimumValue: 2
                maximumValue: 32
            }
        }

        ListItem.Subtitled {
            id: fontListItem
            text: "Font family"
            subText: settings.fontFamily
            onClicked: fontDialog.open()
        }

        ListItem.Subtitled {
            content: TextField {
                id: shellProgramTextField

                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                floatingLabel: true
                placeholderText: "Shell program"
                text: settings.shellProgram
            }
        }
    }

    //TODO: only monospaced fonts should be displayed
    Dialog {
            id: fontDialog
            title: "Select Font"
            hasActions: false
            height: settingsDialog.height - 32
            width: settingsDialog.width - 32

            ListView {
                anchors.left: parent.left
                anchors.right: parent.right
                height: fontDialog.height

                model: Qt.fontFamilies()
                delegate: ListItem.Standard {
                    width: ListView.view.width
                    text: modelData
                    onClicked: {
                        fontListItem.subText = text;
                        fontDialog.close();
                    }
                }
            }
        }
}
