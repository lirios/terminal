# Translations
file(GLOB LiriTerminal_TRANSLATIONS "${CMAKE_SOURCE_DIR}/translations/*_*.ts")
qt5_add_translation(LiriTerminal_QM_FILES ${LiriTerminal_TRANSLATIONS})
install(FILES ${LiriTerminal_QM_FILES}
        DESTINATION "${INSTALL_DATADIR}/liri-terminal/translations")

liri_add_executable(LiriTerminal
    OUTPUT_NAME
        "liri-terminal"
    SOURCES
        ActionHandler.cpp
        ActionHandler.h
        fontfamiliesmodel.cpp
        fontfamiliesmodel.h
        main.cpp
        ${LiriTerminal_QM_FILES}
    RESOURCES
        terminal.qrc
    DEFINES
        #QT_NO_CAST_FROM_ASCII
        QT_NO_FOREACH
        TERMINAL_VERSION="${PROJECT_VERSION}"
    APPDATA
        "${CMAKE_CURRENT_SOURCE_DIR}/io.liri.Terminal.appdata.xml"
    DESKTOP
        "${CMAKE_CURRENT_SOURCE_DIR}/io.liri.Terminal.desktop"
    LIBRARIES
        Qt5::Core
        Qt5::Gui
        Qt5::Widgets
        Qt5::Qml
        Qt5::Quick
        Qt5::QuickControls2
    GUI
)

liri_finalize_executable(LiriTerminal)
