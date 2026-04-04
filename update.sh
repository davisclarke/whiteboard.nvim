# Clean 
rm ./lua/whiteboard/init.lua
rm ./lua/lualine/themes/whiteboard.lua

fennel --compile ./fnl/whiteboard/init.fnl >> ./lua/whiteboard/init.lua
fennel --compile ./fnl/lualine/themes/whiteboard.fnl >> ./lua/lualine/themes/whiteboard.lua
