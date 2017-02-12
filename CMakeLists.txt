project(Terminal)

cmake_minimum_required(VERSION 3.0.0 FATAL_ERROR)
cmake_policy(VERSION 3.4.1)

# Instruct CMake to run moc and rrc automatically when needed
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

# Apple-specific configuration
set(APPLE_SUPPRESS_X11_WARNING ON)

# Set version
set(PROJECT_VERSION "0.1.0")
set(PROJECT_VERSION_MAJOR 0)
set(PROJECT_SOVERSION 0)

if(NOT USE_SUPERBUILD)
    # Set up packaging
    set(CPACK_PACKAGE_NAME "liri-terminal")
    set(CPACK_PACKAGE_VERSION "${PROJECT_VERSION}")
    set(CPACK_GENERATOR "TGZ")
    set(CPACK_SET_DESTDIR FALSE)
    set(CPACK_SOURCE_PACKAGE_FILE_NAME "${CPACK_PACKAGE_NAME}-${CPACK_PACKAGE_VERSION}")
    set(CPACK_SOURCE_IGNORE_FILES "/build/;/.git;/*.user;/.tx/;~$;${CPACK_SOURCE_IGNORE_FILES}")
    include(CPack)
    add_custom_target(dist COMMAND ${CMAKE_MAKE_PROGRAM} package_source)
endif()

# ECM
find_package(ECM 1.7.0 REQUIRED NO_MODULE)
list(APPEND CMAKE_MODULE_PATH
    "${ECM_MODULE_PATH}"
    "${ECM_KDE_MODULE_DIR}"
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake"
)

# Macros
include(FeatureSummary)
include(KDEInstallDirs)
include(KDECompilerSettings)
include(KDECMakeSettings)

# Build flags
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fvisibility=hidden -fvisibility-inlines-hidden -Werror -Wall -Wextra -Wformat -Wswitch-default -Wunused-parameter -pedantic -std=c++11")

# qCDebug() uses zero variadic arguments, so we need to disable this warning
# as it would become an error with -Werror
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
   set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wno-gnu-zero-variadic-macro-arguments")
endif()

# Find Qt5
set(REQUIRED_QT_VERSION "5.8.0")
find_package(Qt5 ${REQUIRED_QT_VERSION} CONFIG REQUIRED COMPONENTS
             Core Qml Quick Widgets QuickControls2)

# Find Vibe
set(REQUIRED_VIBE_VERSION "0.9.0")
find_package(Vibe ${REQUIRED_HAWAII_VERSION} REQUIRED)

# Find pkg-config
find_package(PkgConfig)

# gio (for the settings)
pkg_check_modules(gio gio-2.0 REQUIRED)
if (NOT DEFINED GSETTINGS_SCHEMA_DIR)
    execute_process(COMMAND ${PKG_CONFIG_EXECUTABLE} --variable=prefix gio-2.0 OUTPUT_VARIABLE _gio_prefix)
    string(REGEX REPLACE "[ \t\n]+" "" _gio_prefix ${_gio_prefix})
    set(GSETTINGS_SCHEMA_DIR "${_gio_prefix}/share/glib-2.0/schemas")
endif()
message(STATUS "GSettings schemas directory: ${GSETTINGS_SCHEMA_DIR}")

# Subdirectories
add_subdirectory(app)
add_subdirectory(data)
add_subdirectory(imports)
add_subdirectory(lib)

# Display feature summary
feature_summary(WHAT ALL FATAL_ON_MISSING_REQUIRED_PACKAGES)
