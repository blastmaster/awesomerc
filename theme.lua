local awful = require("awful")

---------------------------
-- My awesome theme --
---------------------------


theme = {}

local dir = awful.util.getdir("config") .. "/theme/"

theme.font          = "FontAwesome 8"
theme.widget_font   = "ProggyTinyTT"
theme.iconFont      = "FontAwesome"

-- define some colors
theme.color_white       = "#FFFFFF"
theme.color_black       = "#000000"
theme.color_darkgrey    = "#343434"
theme.color_lightgrey   = "#9E9E9E"
theme.color_red         = "#ff0000"
theme.color_lightblue   = "#6AA3FF"
theme.color_lightgreen  = "#3cff00"
theme.color_yellow      = "#FFFF00"
theme.color_darkyellow  = "#FFDC5A"
theme.color_olivegreen  = "#8FC825"
-- TODO need better name
theme.color_orange = "#FF7C00"

theme.bg_normal     = "#212121"
theme.bg_focus      = "#212121"
theme.bg_urgent     = theme.color_back
theme.bg_minimize   = theme.color_lightgrey
theme.bg_systray    = theme.bg_normal
theme.bg_tagbar     = "#212121"

theme.fg_normal     = theme.color_lightblue
theme.fg_focus      = theme.color_orange
theme.fg_urgent     = theme.color_red
theme.fg_minimize   = theme.color_white

theme.border_width  = 1
theme.border_normal = theme.color_black
theme.border_focus  = theme.color_orange
theme.border_marked = theme.color_black

theme.tasklist_theme = {
    bg_normal = theme.bg_normal,
    bg_focus = "#353535",
    bg_urgent = theme.bg_urgent,
    bg_minimize = theme.bg_minimize,
    fg_normal = theme.color_white,
    fg_urgent = theme.fg_urgent,
    fg_minimize = theme.fg_minimize
}

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

-- {{{ Widgets
theme.widget_bat_fg     = theme.color_lightblue
theme.widget_batlow_fg  = theme.fg_urgent
theme.widget_netdown_fg = theme.fg_urgent
theme.widget_netup_fg   = theme.color_lightblue
--theme.widget_wifi_fg    = theme.base16_base0D
--theme.widget_mem_fg     = theme.base16_base0A
theme.widget_cpu_fg          = theme.color_darkyellow
theme.widget_vol_fg          = theme.color_olivegreen
theme.widget_date_fg         = theme.color_white
theme.widget_cpu_fg_icon     = theme.color_darkyellow
theme.widget_vol_fg_icon     = theme.color_olivegreen
theme.widget_date_fg_icon    = theme.color_white
--theme.widget_chat_fg    = theme.base16_base0D
-- }}}

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
theme.layout_fairh = dir .. "layouts/fairh.png"
theme.layout_fairv = dir .. "layouts/fairv.png"
theme.layout_floating  = dir .. "layouts/floating.png"
theme.layout_magnifier = dir .. "layouts/magnifier.png"
theme.layout_max = dir .. "layouts/max.png"
theme.layout_fullscreen = dir .. "layouts/fullscreen.png"
theme.layout_tilebottom = dir .. "layouts/tilebottom.png"
theme.layout_tileleft   = dir .. "layouts/tileleft.png"
theme.layout_tile = dir .. "layouts/tile.png"
theme.layout_tiletop = dir .. "layouts/tiletop.png"
theme.layout_spiral  = dir .. "layouts/spiral.png"
theme.layout_dwindle = dir .. "layouts/dwindle.png"

theme.awesome_icon = "/usr/local/share/awesome/icons/awesome16.png"

--theme.memory = dir .. "memory.png"
--theme.battery = dir .. "battery.png"
--theme.nobattery = dir .. "nobattery.png"
--theme.dock = dir .. "dock.png"
--theme.nomonitor = dir .. "nomonitor.png"

-- Define the icon theme for application icons. If not set then the icons 
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
