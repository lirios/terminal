import QtQuick 2.4
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QMLTermWidget 1.0
import Material 0.1

ApplicationWindow {
    width: 640
    height: 480
    visible: true
    title: mainsession.title

    theme {
        primaryColor: "orange"
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
                shortcut: "ctrl+N"
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
                onTriggered: fontDialog.open();
            }
        ]

        QMLTermWidget {
            id: terminal
            anchors.fill: parent
            font.family: "Roboto Mono"
            font.pointSize: 10
            colorScheme: "cool-retro-term"
            session: QMLTermSession{
                id: mainsession
                initialWorkingDirectory: "$HOME"
                onFinished: Qt.quit()
            }
            onTerminalUsesMouseChanged: console.log(terminalUsesMouse);
            onTerminalSizeChanged: console.log(terminalSize);
            Component.onCompleted: mainsession.startShellProgram();
        }
    }

    FontDialog {
        id: fontDialog
        font: terminal.font
        onAccepted: {
            terminal.font = fontDialog.font;
        }
    }

    Component.onCompleted: terminal.forceActiveFocus();
}
