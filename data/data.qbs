import qbs 1.0

Product {
    name: "Data"

    Depends { name: "lirideployment" }

    Group {
        condition: qbs.hostOS.contains("linux")
        name: "Desktop File"
        files: ["io.liri.Terminal.desktop"]
        qbs.install: true
        qbs.installDir: lirideployment.applicationsDir
    }

    Group {
        condition: qbs.hostOS.contains("linux")
        name: "AppStream Metadata"
        files: ["io.liri.Terminal.appdata.xml"]
        qbs.install: true
        qbs.installDir: lirideployment.appDataDir
    }

    Group {
        condition: qbs.hostOS.contains("linux")
        name: "AppStream Metadata"
        files: ["io.liri.Terminal.gschema.xml"]
        qbs.install: true
        qbs.installDir: lirideployment.dataDir + "/glib-2.0/schemas"
    }
}
