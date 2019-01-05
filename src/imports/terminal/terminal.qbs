import qbs 1.0
import qbs.FileInfo

LiriQmlPlugin {
    name: "liriterminalplugin"
    pluginPath: "Liri/Terminal"

    Depends { name: "Qt"; submodules: ["widgets"] }
    Depends { name: "qmltermwidget" }

    cpp.defines: []
    files: ["*.cpp", "*.h", "qmldir", "*.qml"]
}
