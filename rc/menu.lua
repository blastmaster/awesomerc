local awful = require("awful")
local beautiful = require("beautiful")


local myawesomemenu = {
    { "hotkeys", function() return false, hotkeys_popup.show_help end},
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", awesome.quit }
}

return awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                              { "open terminal", terminal } }
                        })
