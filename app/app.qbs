import qbs 1.0

QtGuiApplication {
    name: "liri-terminal"
    targetName: "liri-terminal"

    Depends { name: "lirideployment" }
    Depends { name: "Qt"; submodules: ["qml", "quick", "widgets", "quickcontrols2"] }

    cpp.defines: base.concat(['LIRITERMINAL_VERSION="' + project.version + '"'])

    files: ["*.cpp", "*.h", "*.qrc"]

    Group {
        name: "QML Files"
        files: ["*.qml", "*.js"]
        prefix: "qml/"
    }

    Group {
        qbs.install: true
        qbs.installDir: lirideployment.binDir
        fileTagsFilter: product.type
    }
}
