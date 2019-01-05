import qbs 1.0

StaticLibrary {
    name: "qmltermwidget"
    targetName: "qmltermwidget"

    Depends { name: "cpp" }
    Depends { name: "Qt"; submodules: ["quick", "widgets"] }

    cpp.defines: base.concat([
        "HAVE_POSIX_OPENPT",
        "HAVE_SYS_TIME_H"
    ])
    cpp.includePaths: base.concat(["../imports/terminal", product.sourceDirectory])

    files: [
        "BlockArray.cpp",
        "BlockArray.h",
        "ColorScheme.cpp",
        "ColorScheme.h",
        "Emulation.cpp",
        "Emulation.h",
        "Filter.cpp",
        "Filter.h",
        "History.cpp",
        "History.h",
        "HistorySearch.cpp",
        "HistorySearch.h",
        "KeyboardTranslator.cpp",
        "KeyboardTranslator.h",
        "ProcessInfo.cpp",
        "ProcessInfo.h",
        "Pty.cpp",
        "Pty.h",
        "Screen.cpp",
        "Screen.h",
        "ScreenWindow.cpp",
        "ScreenWindow.h",
        "Session.cpp",
        "Session.h",
        "ShellCommand.cpp",
        "ShellCommand.h",
        "TerminalCharacterDecoder.cpp",
        "TerminalCharacterDecoder.h",
        "TerminalDisplay.cpp",
        "TerminalDisplay.h",
        "Vt102Emulation.cpp",
        "Vt102Emulation.h",
        "konsole_wcwidth.cpp",
        "konsole_wcwidth.h",
        "kprocess.cpp",
        "kprocess.h",
        "kpty.cpp",
        "kpty.h",
        "kptydevice.cpp",
        "kptydevice.h",
        "kptyprocess.cpp",
        "kptyprocess.h",
        "tools.cpp",
        "tools.h",
    ]

    Export {
        Depends { name: "cpp" }
        Depends { name: "Qt"; submodules: ["quick", "widgets"] }

        cpp.defines: base.concat([
            "HAVE_POSIX_OPENPT",
            "HAVE_SYS_TIME_H"
        ])
        cpp.includePaths: base.concat([product.sourceDirectory])
    }
}
