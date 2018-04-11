import qbs 1.0

Project {
    name: "Terminal"

    readonly property string version: "0.2.0"

    minimumQbsVersion: "1.9.0"

    references: [
        "app/app.qbs",
        "imports/terminal/terminal.qbs",
        "lib/lib.qbs",
    ]
}
