if [[ -z "$DISPLAY" && "$(tty)" = /dev/tty1 ]]; then
  # GTK
  export GTK_THEME=Gruvbox-Material-Dark

  # QT
  export QT_QPA_PLATFORMTHEME=gtk2 # qt5-styleplugins
  export GTK2_RC_FILES="${HOME}/.themes/${GTK_THEME}/gtk-2.0/gtkrc"

  # LibreOffice
  export SAL_USE_VCLPLUGIN=gtk3

  # Firefox
  export MOZ_ENABLE_WAYLAND=1
  export MOZ_DBUS_REMOTE=1

  exec dbus-run-session sway &> /dev/null
fi
