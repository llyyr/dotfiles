if exists('g:GtkGuiLoaded')
  call rpcnotify(1, 'Gui', 'Font', 'Hack 12')
  call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 1)
  call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0) " disable GTK tabline
  let g:GuiInternalClipboard = 1
elseif exists('g:GuiLoaded')
  " call GuiWindowMaximized(1)
  " call GuiClipboard()
  GuiTabline 0
  GuiPopupmenu 0
  GuiLinespace 2
  GuiFont! Hack\ NF:h10:l
endif
