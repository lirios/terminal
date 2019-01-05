cmake_minimum_required(VERSION 3.10.0)

project("Terminal"
    VERSION "0.2.0"
    DESCRIPTION "Terminal emulator"
    LANGUAGES CXX C
)

## Shared macros and functions:
if(NOT LIRI_LOCAL_ECM)
    find_package(LiriCMakeShared "1.0.0" REQUIRED NO_MODULE)
    list(APPEND CMAKE_MODULE_PATH "${LCS_MODULE_PATH}")
endif()

## Set minimum versions required.
set(QT_MIN_VERSION "5.10.0")

## Liri specific setup common for all modules:
include(LiriSetup)

## Find Qt 5.
find_package(Qt5 "${QT_MIN_VERSION}"
    CONFIG REQUIRED
    COMPONENTS
        Core
        Gui
        Widgets
        Qml
        Quick
        QuickControls2
        LinguistTools
)

## Add subdirectories:
add_subdirectory(data)
add_subdirectory(src/lib)
add_subdirectory(src/imports/terminal)
add_subdirectory(src/app)
