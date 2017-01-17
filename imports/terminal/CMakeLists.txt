include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/../../lib
)

set(SOURCES
    ksession.cpp
    qmltermwidget_plugin.cpp
)

add_library(liriterminalplugin SHARED ${SOURCES})
target_link_libraries(liriterminalplugin
                      Qt5::Widgets
                      Qt5::Qml
                      Qt5::Quick
                      qmltermwidget
)

install(TARGETS liriterminalplugin LIBRARY
        DESTINATION ${QML_INSTALL_DIR}/Liri/Terminal)

set(MODULE_FILES
    qmldir
    QMLTermScrollbar.qml
)
install(FILES ${MODULE_FILES}
        DESTINATION ${QML_INSTALL_DIR}/Liri/Terminal)
