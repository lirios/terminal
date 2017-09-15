import qbs 1.0

Project {
    name: "Terminal"

    readonly property string version: "0.1.0"

    minimumQbsVersion: "1.8.0"

    references: [
        "app/app.qbs",
        "data/data.qbs",
        "imports/terminal/terminal.qbs",
        "lib/lib.qbs",
    ]
}
