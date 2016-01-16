import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QMLTermWidget 1.0
import Material 0.1
import QtQuick.Layouts 1.1
import Qt.labs.settings 1.0

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    id: mainWindow
    title: mainsession.title

    property var defaultOpacity: 100
    property var defaultFontSize: 10
    property var defaultPrimaryColor: Palette.colors["orange"]["500"]
    property var defaultAccentColor: Palette.colors["blue"]["500"]
    property string defaultFontFamily: "RobotoMono"

    Settings {
        id: settings
        property alias opacity: mainWindow.opacity
        property var primaryColor: defaultPrimaryColor
        property var accentColor: defaultAccentColor
        property var fontFamily: defaultFontFamily
        property var fontSize: defaultFontSize
    }

    theme {
        primaryColor: settings.primaryColor
        accentColor: settings.accentColor
    }

    Action{
        shortcut: "Ctrl+Shift+C"
        onTriggered: terminal.copyClipboard();
    }

    Action{
        shortcut: "Ctrl+Shift+V"
        onTriggered: terminal.pasteClipboard();
    }

    Action{
        shortcut: "Ctrl+F"
        onTriggered: searchButton.visible = !searchButton.visible
    }

    Action{
        shortcut: StandardKey.FullScreen

        onTriggered: {
            if (visibility === Window.Windowed) {
                showFullScreen()
            } else {
                showNormal()
            }
        }
    }


    Action{
        shortcut: StandardKey.ZoomIn
        onTriggered: terminal.font.pointSize++
    }


    Action{
        shortcut: StandardKey.ZoomOut
        onTriggered: terminal.font.pointSize--
    }

    initialPage: Page {

        title: "Terminal"
        actions: [
            Action {
                iconName: "content/add"
                text: qsTr("Open new tab")
                shortcut: StandardKey.AddTab

                onTriggered: console.log("New tab");
            },
            Action {
                iconName: "action/open_in_new"
                text: qsTr("Open new window")
                shortcut: "ctrl+Shift+N"
                onTriggered: {
                    actionHandler.newWindow();
                    console.log("New window")
                }
            },
            Action {
                iconName: "content/content_paste"
                text: qsTr("Paste")
                shortcut: StandardKey.Paste
                onTriggered: terminal.pasteClipboard();
            },
            Action {
                iconName: "action/search"
                text: qsTr("Search")
            },
            Action {
                iconName: "action/settings"
                text: qsTr("Settings")
                onTriggered: settingsWindow.show();
            }
        ]

        QMLTermWidget {
            id: terminal
            anchors.fill: parent
            font.family: settings.fontFamily
            font.pointSize: settings.fontSize
            colorScheme: "cool-retro-term"
            session: QMLTermSession{
                id: mainsession
                initialWorkingDirectory: "$HOME"
                onFinished: Qt.quit()
            }
            Component.onCompleted: {
                mainsession.startShellProgram();
                opacitySlider.value = 100 * mainWindow.opacity
            }
        }
    }
    Component.onCompleted: terminal.forceActiveFocus();

    //TODO: settings are not saved yet
    ApplicationWindow {
        width: 300
        height: 350
        visible: false
        id: settingsWindow
        title: "Settings"

        theme {
                primaryColor: "orange"
        }

        initialPage: Page {
            title: "Settings"
            //TODO: this should change background opacity, not entire window opacity
            Slider {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                id: opacitySlider
                stepSize: 1
                numericValueLabel: true
                minimumValue: 10
                maximumValue: 100
                onValueChanged: mainWindow.opacity = 0.01 * value
            }
            Label {
                id: opacityLabel
                text: "Opacity"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: opacitySlider.bottom
            }

            Slider {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: opacityLabel.bottom
                id: fontSizeSlider
                stepSize: 1
                value: settings.fontSize
                numericValueLabel: true
                minimumValue: 2
                maximumValue: 32
                onValueChanged: settings.fontSize = value
            }
            Label {
                id: fontSizeLabel
                text: "Font size"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: fontSizeSlider.bottom
            }
            //TODO: create custom font dialog (optionally it should only display monospaced fonts)
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: fontSizeLabel.bottom
                anchors.topMargin: 24
                id: fontButton
                text: "FONT FAMILY: " + settings.fontFamily
                elevation: 1
                onClicked: fontDialog.open()
            }
            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: fontButton.bottom
                anchors.topMargin: 8
                id: themeButton
                text: "SET THEME COLORS"
                elevation: 1
                onClicked: colorPicker.open()
            }

            Button {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: themeButton.bottom
                anchors.topMargin: 24
                id: resetButton
                text: "RESET ALL TO DEFAULT"
                elevation: 1
                onClicked: {
                    settings.fontFamily = defaultFontFamily
                    opacitySlider.value = defaultOpacity
                    fontSizeSlider.value = defaultFontSize
                    settings.primaryColor = defaultPrimaryColor
                    settings.accentColor = defaultAccentColor
                }
            }
        }

        //TODO: either create simple interface for changing terminal colors or support switching terminal color schemes
        Dialog {
            id: colorPicker
            title: "Pick color"

            positiveButtonText: "Done"

            MenuField {
                id: selection
                model: ["Primary color", "Accent color"]
                width: Units.dp(160)
            }

            Grid {
                columns: 7
                spacing: Units.dp(8)

                Repeater {
                    model: [
                        "red", "pink", "purple", "deepPurple", "indigo",
                        "blue", "lightBlue", "cyan", "teal", "green",
                        "lightGreen", "lime", "yellow", "amber", "orange",
                        "deepOrange", "grey", "blueGrey", "brown", "black",
                        "white"
                    ]

                    Rectangle {
                        width: Units.dp(30)
                        height: Units.dp(30)
                        radius: Units.dp(2)
                        color: Palette.colors[modelData]["500"]
                        border.width: modelData === "white" ? Units.dp(2) : 0
                        border.color: Theme.alpha("#000", 0.26)

                        Ink {
                            anchors.fill: parent

                            onPressed: {
                                switch(selection.selectedIndex) {
                                    case 0:
                                        settings.primaryColor = parent.color
                                        break;
                                    case 1:
                                        settings.accentColor = parent.color
                                        break;
                                }
                            }
                        }
                    }
                }
            }
        }

        FontDialog {
            id: fontDialog
            font: terminal.font
            onAccepted: {
                settings.fontFamily = fontDialog.font.family;
            }
        }
    }
}
