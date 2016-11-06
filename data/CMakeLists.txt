install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/io.liri.Terminal.desktop
        DESTINATION ${XDG_APPS_INSTALL_DIR})
install(FILES ${CMAKE_CURRENT_SOURCE_DIR}/io.liri.Terminal.appdata.xml
        DESTINATION ${DATA_INSTALL_DIR}/appdata)
install(FILES "${CMAKE_CURRENT_SOURCE_DIR}/io.liri.Terminal.gschema.xml"
        DESTINATION ${GSETTINGS_SCHEMA_DIR})
