file(GLOB_RECURSE SOURCES *.cpp *.h terminal.qrc "qml/*.qml")

add_executable(liri-terminal ${SOURCES})
target_link_libraries(liri-terminal
                      Qt5::Core
                      Qt5::Qml
                      Qt5::Quick
                      Qt5::Widgets)

install(TARGETS liri-terminal
        DESTINATION ${BIN_INSTALL_DIR})
install(FILES io.liri.Terminal.gschema.xml
        DESTINATION ${GSETTINGS_SCHEMA_DIR})
