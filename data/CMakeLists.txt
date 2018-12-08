file(GLOB _files "*.gschema.xml")
install(FILES ${_files} DESTINATION "${INSTALL_DATADIR}/glib-2.0/schemas")

set(COLOR_SCHEMES
    color-schemes/BlackOnLightYellow.schema
    color-schemes/BlackOnRandomLight.colorscheme
    color-schemes/BlackOnWhite.schema
    color-schemes/Breeze.colorscheme
    color-schemes/cool-retro-term.schema
    color-schemes/DarkPastels.colorscheme
    color-schemes/GreenOnBlack.colorscheme
    color-schemes/Linux.colorscheme
    color-schemes/Material.colorscheme
    color-schemes/Solarized.colorscheme
    color-schemes/SolarizedLight.colorscheme
    color-schemes/Tango.colorscheme
    color-schemes/Ubuntu.colorscheme
    color-schemes/WhiteOnBlack.schema
)
install(FILES ${COLOR_SCHEMES} DESTINATION "${INSTALL_DATADIR}/liri-terminal/color-schemes")

set(KB_LAYOUTS
    kb-layouts/default.keytab
    kb-layouts/linux.keytab
    kb-layouts/macbook.keytab
    kb-layouts/solaris.keytab
    kb-layouts/vt420pc.keytab
)
install(FILES ${KB_LAYOUTS} DESTINATION "${INSTALL_DATADIR}/liri-terminal/kb-layouts")
