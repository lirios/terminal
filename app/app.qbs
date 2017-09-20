import qbs 1.0

QtGuiApplication {
    name: "liri-terminal"
    targetName: "liri-terminal"

    Depends { name: "lirideployment" }
    Depends { name: "Qt"; submodules: ["qml", "quick", "widgets", "quickcontrols2"] }

    cpp.defines: base.concat(['LIRITERMINAL_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h"]

    Qt.core.resourcePrefix: "/"
    Qt.core.resourceSourceBase: sourceDirectory

    Group {
        name: "Resource Data"
        prefix: "qml/"
        files: [
            "main.qml",
            "CommandItem.qml",
            "ConfirmCloseDialog.qml",
            "Settings.qml",
            "SettingsDialog.qml",
            "SudoWarningDialog.qml",
            "TerminalTab.qml",
        ]
        fileTags: ["qt.core.resource_data"]
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.binDir
        fileTagsFilter: product.type
    }
}
