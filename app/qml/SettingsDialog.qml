/*
 * This file is part of Terminal.
 *
 * Copyright (C) Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
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
import QtQuick.Controls 2.0
import Fluid.Controls 1.0 as Controls

Controls.Dialog {
    title: qsTr("Settings")

    height: Math.min(parent.height * 0.7, 400)
    width: 30

    onAccepted: {
        settings.fontSize = fontSizeSlider.value
        settings.fontFamily = fontListItem.subText
        settings.shellProgram = shellProgramTextField.text
        settings.smartCopyPaste = smartCopyPasteSwitch.checked
    }

    Column {
        id: settingsList

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.margins: -24

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

        Controls.ListItem {
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

        Controls.ListItem {
            id: fontListItem

            text: qsTr("Font family")
            subText: settings.fontFamily

            onClicked: fontDialog.open()
        }

        Controls.ListItem {
            text: qsTr("Smart copy/paste")

            onClicked: smartCopyPasteSwitch.checked = !smartCopyPasteSwitch.checked

            rightItem: Switch {
                id: smartCopyPasteSwitch
                anchors.centerIn: parent
                checked: settings.smartCopyPaste
            }
        }

        Controls.ListItem {
            rightItem: TextField {
                id: shellProgramTextField

                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                //floatingLabel: true
                placeholderText: qsTr("Shell program")
                text: settings.shellProgram
            }
        }
    }

    Controls.Dialog {
        id: fontDialog
        title: qsTr("Select Font")
        //hasActions: false
        height: settingsDialog.height - 32
        width: settingsDialog.width - 32

        ListView {
            id: fontListView
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: -24
            height: fontDialog.height

            model: Qt.fontFamilies()
            delegate: Controls.ListItem {
                id: listItem
                text: modelData
                highlighted: fontListItem.subText === text

                // TODO: Is there a better way to do this
                visible: text.toLowerCase().indexOf('mono') !== -1
                height: visible ? implicitHeight : 0

                secondaryItem: [
                    Controls.Icon {
                        anchors.centerIn: parent
                        name: "navigation/check"
                        visible: listItem.highlighted
                    }
                ]

                onClicked: {
                    fontListItem.subText = text;
                    fontDialog.close();
                }
            }
        }
    }
}
