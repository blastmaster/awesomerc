local awful = require("awful")

---------------------------
-- Default awesome theme --
---------------------------


theme = {}

local dir = awful.util.getdir("config") .. "/theme/"

theme.font          = "sans 7"

theme.bg_normal     = "#000000"
theme.bg_focus      = "#000000"
theme.bg_urgent     = "#000000"
theme.bg_minimize   = "#9E9E9E"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#FF7C00"
theme.fg_focus      = "#3CFF00"
theme.fg_urgent     = "#ff0000"
theme.fg_minimize   = "#ffffff"

theme.border_width  = 0
theme.border_normal = "#000000"
theme.border_focus  = "#000000"
theme.border_marked = "#000000"

-- There are other variable sets
-- overriding the default one when
-- defined, the sets are:
-- [taglist|tasklist]_[bg|fg]_[focus|urgent]
-- titlebar_[bg|fg]_[normal|focus]
-- tooltip_[font|opacity|fg_color|bg_color|border_width|border_color]
-- mouse_finder_[color|timeout|animate_timeout|radius|factor]
-- Example:
--theme.taglist_bg_focus = "#ff0000"

-- Display the taglist squares
-- theme.taglist_squares_sel   = "/usr/local/share/awesome/themes/default/taglist/squarefw.png"
theme.taglist_squares_unsel = dir .. "square.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = dir .. "submenu.png"
theme.menu_height = 14
theme.menu_width  = 100

-- You can add as many variables as
-- you wish and access them by using
-- beautiful.variable in your rc.lua
--theme.bg_widget = "#cc0000"

-- Define the image to load
theme.titlebar_close_button_normal = dir .. "titlebar/close_normal.png"
theme.titlebar_close_button_focus  = dir .. "titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = dir .. "titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = dir .. "titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = dir .. "titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = dir .. "titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = dir .. "titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = dir .. "titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = dir .. "titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = dir .. "titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = dir .. "titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = dir .. "titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = dir .. "titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = dir .. "titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = dir .. "titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = dir .. "titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = dir .. "titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = dir .. "titlebar/maximized_focus_active.png"

theme.wallpapers = {
    {"/home/blastmaster/pictures/nasa2_1024-768.jpg", maximize=true},
    {"/home/blastmaster/pictures/debian-black-white.png", maximize=true},
    {"/home/blastmaster/pictures/tux.png", maximize=true},
	{"/home/blastmaster/pictures/proc-gchq.jpg", maximize=true},
	{"/home/blastmaster/pictures/green-glider.png", maximize=true},
	{"/home/blastmaster/pictures/dtux.png", maximize=true},
	{"/home/blastmaster/pictures/c3d2_blue.png", maximize=true},
}

-- setting random default wallpaper
idx = math.random(1, table.getn(theme.wallpapers))
theme.wallpaper = theme.wallpapers[idx][1]

-- You can use your own layout icons like this:
theme.layout_fairh = dir .. "layouts/fairho.png"
theme.layout_fairv = dir .. "layouts/fairvo.png"
theme.layout_floating  = dir .. "layouts/floatingo.png"
theme.layout_magnifier = dir .. "layouts/magnifiero.png"
theme.layout_max = dir .. "layouts/maxo.png"
theme.layout_fullscreen = dir .. "layouts/fullscreeno.png"
theme.layout_tilebottom = dir .. "layouts/tilebottomo.png"
theme.layout_tileleft   = dir .. "layouts/tilelefto.png"
theme.layout_tile = dir .. "layouts/tileo.png"
theme.layout_tiletop = dir .. "layouts/tiletopo.png"
theme.layout_spiral  = dir .. "layouts/spiralo.png"
theme.layout_dwindle = dir .. "layouts/dwindleo.png"

theme.awesome_icon = "/usr/local/share/awesome/icons/awesome16.png"

theme.memory = dir .. "memory.png"
theme.battery = dir .. "battery.png"
theme.nobattery = dir .. "nobattery.png"
theme.dock = dir .. "dock.png"
theme.nomonitor = dir .. "nomonitor.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
