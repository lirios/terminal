import qbs 1.0

LiriDynamicLibrary {
    name: "Liri.Terminal"
    targetName: "liriterminalplugin"

    Depends { name: "lirideployment" }
    Depends { name: "Qt"; submodules: ["qml", "quick", "widgets"] }
    Depends { name: "qmltermwidget" }

    cpp.defines: []
    files: ["*.cpp", "*.h"]

    Group {
        name: "QML Files"
        files: [
            "*.qml",
            "qmldir"
        ]
        fileTags: ["qml"]
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.qmlDir + "/Liri/Terminal"
        fileTagsFilter: ["dynamiclibrary", "qml"]
    }
}
