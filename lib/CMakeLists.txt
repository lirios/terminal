include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/../imports/terminal
)

add_definitions(-DHAVE_POSIX_OPENPT -DHAVE_SYS_TIME_H)

set(SOURCES
    BlockArray.cpp
    ColorScheme.cpp
    Emulation.cpp
    Filter.cpp
    History.cpp
    HistorySearch.cpp
    KeyboardTranslator.cpp
    konsole_wcwidth.cpp
    kprocess.cpp
    kpty.cpp
    kptydevice.cpp
    kptyprocess.cpp
    ProcessInfo.cpp
    Pty.cpp
    Screen.cpp
    ScreenWindow.cpp
    Session.cpp
    ShellCommand.cpp
    TerminalCharacterDecoder.cpp
    TerminalDisplay.cpp
    tools.cpp
    Vt102Emulation.cpp
)

add_library(qmltermwidget STATIC ${SOURCES})
target_link_libraries(qmltermwidget Qt5::Quick Qt5::Widgets)
