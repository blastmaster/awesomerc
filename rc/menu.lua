local awful = require("awful")
local beautiful = require("beautiful")
local freedesktop = require("freedesktop")
-- hotkeys does not work
local hotkeys_popup = require("awful.hotkeys_popup").widget

local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end}
}

local mymenu = freedesktop.menu.build({
    icon_size = beautiful.menu_height or 16,
    before = {
        { "Awesome", myawesomemenu, beautiful.awesome_icon },
        -- other stuff put here
    },
    after = {
        { "Open terminal", terminal },
        -- other stuff put here
    }
})

return mymenu
