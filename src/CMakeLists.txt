file(GLOB_RECURSE SOURCES *.cpp *.h papyros-terminal.qrc)

add_executable(papyros-terminal ${SOURCES} ActionHandler.cpp ActionHandler.h)
target_link_libraries(papyros-terminal
                      Qt5::Core
                      Qt5::Qml
                      Qt5::Quick
                      Qt5::Widgets
                      Papyros::Papyros)

install(TARGETS papyros-terminal
        DESTINATION ${CMAKE_INSTALL_BINDIR})
