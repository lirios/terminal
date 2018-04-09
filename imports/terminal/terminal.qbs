import qbs 1.0
import qbs.FileInfo

LiriQmlPlugin {
    name: "liriterminalplugin"
    pluginPath: "Liri/Terminal"

    Depends { name: "Qt"; submodules: ["widgets"] }
    Depends { name: "qmltermwidget" }

    cpp.defines: []
    files: ["*.cpp", "*.h", "qmldir", "*.qml"]

    Group {
        name: "Color Schemes"
        prefix: "../../lib/color-schemes/"
        files: [
            "BlackOnLightYellow.schema",
            "BlackOnRandomLight.colorscheme",
            "Linux.colorscheme",
            "BlackOnWhite.schema",
            "DarkPastels.colorscheme",
            "GreenOnBlack.colorscheme",
            "WhiteOnBlack.schema",
            "cool-retro-term.schema",
        ]
        excludeFiles: ["*.qrc"]
        fileTags: ["liri.terminal.color_schemes"]
        qbs.install: true
        qbs.installDir: FileInfo.joinPaths(lirideployment.qmlDir, pluginPath)
    }

    Group {
        qbs.install: true
        qbs.installDir: FileInfo.joinPaths(lirideployment.qmlDir, pluginPath, "color-schemes")
        fileTagsFilter: ["liri.terminal.color_schemes"]
    }

    Group {
        name: "Keyboard Layouts"
        prefix: "../../lib/kb-layouts/"
        files: ["**"]
        excludeFiles: ["*.qrc"]
        fileTags: ["liri.terminal.kb_layouts"]
    }

    Group {
        qbs.install: true
        qbs.installDir: FileInfo.joinPaths(lirideployment.qmlDir, pluginPath, "kb-layouts")
        fileTagsFilter: ["liri.terminal.kb_layouts"]
    }
}
