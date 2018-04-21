import qbs 1.0

QtGuiApplication {
    name: "liri-terminal"
    targetName: "liri-terminal"

    Depends { name: "lirideployment" }
    Depends { name: "Qt"; submodules: ["qml", "quick", "widgets", "quickcontrols2"] }

    cpp.defines: base.concat(['LIRITERMINAL_VERSION="' + project.version + '"'])

    files: [
        "*.cpp",
        "*.h",
    ]

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
            "TabSelector.qml",
            "TerminalTab.qml",
        ]
        fileTags: ["qt.core.resource_data"]
    }

    Group {
        condition: qbs.targetOS.contains("unix") &&
                   !qbs.targetOS.contains("android") &&
                   !qbs.targetOS.contains("macos")
        prefix: "../data/"
        name: "Desktop File"
        files: ["io.liri.Terminal.desktop"]
        qbs.install: true
        qbs.installDir: lirideployment.applicationsDir
    }

    Group {
        condition: qbs.targetOS.contains("unix") &&
                   !qbs.targetOS.contains("android") &&
                   !qbs.targetOS.contains("macos")
        name: "AppStream Metadata"
        prefix: "../data/"
        files: ["io.liri.Terminal.appdata.xml"]
        qbs.install: true
        qbs.installDir: lirideployment.appDataDir
    }

    Group {
        name: "AppStream Metadata"
        prefix: "../data/"
        files: ["io.liri.Terminal.gschema.xml"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/glib-2.0/schemas"
    }

    Group {
        name: "Color Schemes"
        prefix: "../data/color-schemes/"
        files: [
            "BlackOnLightYellow.schema",
            "BlackOnRandomLight.colorscheme",
            "BlackOnWhite.schema",
            "Breeze.colorscheme",
            "cool-retro-term.schema",
            "DarkPastels.colorscheme",
            "GreenOnBlack.colorscheme",
            "Linux.colorscheme",
            "Material.colorscheme",
            "Solarized.colorscheme",
            "SolarizedLight.colorscheme",
            "Tango.colorscheme",
            "WhiteOnBlack.schema",
        ]
        fileTags: ["liri.terminal.color_schemes"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/liri-terminal/color-schemes"
    }

    Group {
        name: "Keyboard Layouts"
        prefix: "../data/kb-layouts/"
        files: ["**"]
        fileTags: ["liri.terminal.kb_layouts"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/liri-terminal/kb-layouts"
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.binDir
        fileTagsFilter: product.type
    }
}
