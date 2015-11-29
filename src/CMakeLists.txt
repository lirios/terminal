# Tell CMake to create the helloworld executable
add_executable(papyros-terminal main.cpp terminal.qrc)

# Use the Widgets module from Qt 5.
target_link_libraries(papyros-terminal Qt5::Qml Qt5::Quick Qt5::Widgets)

install(TARGETS papyros-terminal RUNTIME DESTINATION bin)

