---------------------------
-- My awesome theme --
---------------------------

local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local lain = require("lain")
local os = { getenv = os.getenv }



local dir = awful.util.getdir("config") .. "/theme"
local theme = {}

theme.icon_dir = dir .. "/icons"

--theme.font          = "FontAwesome 10"
theme.font          = "Roboto Bold 9"
theme.taglist_font  = "FontAwesome 9"
theme.widget_font   = "xos4 Terminus 9"
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

theme.fg_normal     = theme.color_white
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

theme.awesome_icon                              = theme.icon_dir .. "/awesome_icon_white.png"
theme.awesome_icon_launcher                     = theme.icon_dir .. "/awesome_icon.png"
theme.cpu                                       = theme.icon_dir .. "/cpu.png"
theme.net_up                                    = theme.icon_dir .. "/net_up.png"
theme.net_down                                  = theme.icon_dir .. "/net_down.png"
theme.mpdl                                      = theme.icon_dir .. "/mpd.png"
theme.mpd_on                                    = theme.icon_dir .. "/mpd_on.png"
theme.prev                                      = theme.icon_dir .. "/prev.png"
theme.nex                                       = theme.icon_dir .. "/next.png"
theme.stop                                      = theme.icon_dir .. "/stop.png"
theme.pause                                     = theme.icon_dir .. "/pause.png"
theme.play                                      = theme.icon_dir .. "/play.png"

theme.useless_gap                               = 4

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
theme.taglist_squares_unsel = dir .. "/square.png"

-- Variables set for theming the menu:
-- menu_[bg|fg]_[normal|focus]
-- menu_[border_color|border_width]
theme.menu_submenu_icon = dir .. "/submenu.png"
theme.menu_height = 14
theme.menu_width  = 160
theme.menu_icon_size = 32

theme.taglist_squares_sel   = theme.icon_dir .. "/square_sel.png"
theme.taglist_squares_unsel = theme.icon_dir .. "/square_unsel.png"

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
theme.titlebar_close_button_normal = dir .. "/titlebar/close_normal.png"
theme.titlebar_close_button_focus  = dir .. "/titlebar/close_focus.png"

theme.titlebar_ontop_button_normal_inactive = dir .. "/titlebar/ontop_normal_inactive.png"
theme.titlebar_ontop_button_focus_inactive  = dir .. "/titlebar/ontop_focus_inactive.png"
theme.titlebar_ontop_button_normal_active = dir .. "/titlebar/ontop_normal_active.png"
theme.titlebar_ontop_button_focus_active  = dir .. "/titlebar/ontop_focus_active.png"

theme.titlebar_sticky_button_normal_inactive = dir .. "/titlebar/sticky_normal_inactive.png"
theme.titlebar_sticky_button_focus_inactive  = dir .. "/titlebar/sticky_focus_inactive.png"
theme.titlebar_sticky_button_normal_active = dir .. "/titlebar/sticky_normal_active.png"
theme.titlebar_sticky_button_focus_active  = dir .. "/titlebar/sticky_focus_active.png"

theme.titlebar_floating_button_normal_inactive = dir .. "/titlebar/floating_normal_inactive.png"
theme.titlebar_floating_button_focus_inactive  = dir .. "/titlebar/floating_focus_inactive.png"
theme.titlebar_floating_button_normal_active = dir .. "/titlebar/floating_normal_active.png"
theme.titlebar_floating_button_focus_active  = dir .. "/titlebar/floating_focus_active.png"

theme.titlebar_maximized_button_normal_inactive = dir .. "/titlebar/maximized_normal_inactive.png"
theme.titlebar_maximized_button_focus_inactive  = dir .. "/titlebar/maximized_focus_inactive.png"
theme.titlebar_maximized_button_normal_active = dir .. "/titlebar/maximized_normal_active.png"
theme.titlebar_maximized_button_focus_active  = dir .. "/titlebar/maximized_focus_active.png"

theme.wallpapers = {
    {"/home/soeste/Pictures/wallpaper.jpg", maximize=true}
}

-- setting random default wallpaper
idx = math.random(1, table.getn(theme.wallpapers))
theme.wallpaper = theme.wallpapers[idx][1]

-- You can use your own layout icons like this:
theme.layout_fairh = dir .. "/layouts/fairh.png"
theme.layout_fairv = dir .. "/layouts/fairv.png"
theme.layout_floating  = dir .. "/layouts/floating.png"
theme.layout_magnifier = dir .. "/layouts/magnifier.png"
theme.layout_max = dir .. "/layouts/max.png"
theme.layout_fullscreen = dir .. "/layouts/fullscreen.png"
theme.layout_tilebottom = dir .. "/layouts/tilebottom.png"
theme.layout_tileleft   = dir .. "/layouts/tileleft.png"
theme.layout_tile = dir .. "/layouts/tile.png"
theme.layout_tiletop = dir .. "/layouts/tiletop.png"
theme.layout_spiral  = dir .. "/layouts/spiral.png"
theme.layout_dwindle = dir .. "/layouts/dwindle.png"


--theme.memory = dir .. "memory.png"
--theme.battery = dir .. "battery.png"
--theme.nobattery = dir .. "nobattery.png"
--theme.dock = dir .. "dock.png"
--theme.nomonitor = dir .. "nomonitor.png"

-- Define the icon theme for application icons. If not set then the icons
-- from /usr/share/icons and /usr/share/icons/hicolor will be used.
theme.icon_theme = nil

-- Set Music Player to ncmpcpp
theme.musicplr = string.format("%s -e ncmpcpp", awful.util.terminal)

local markup = lain.util.markup
local space3 = markup.font("Roboto 3", " ")

-- Clock
local mytextclock = wibox.widget.textclock(markup("#FFFFFF", space3 .. "%H:%M   " .. markup.font("Roboto 4", " ")))
mytextclock.font = theme.font
local clockbg = wibox.container.background(mytextclock, theme.bg_focus, gears.shape.rectangle)
local clockwidget = wibox.container.margin(clockbg, 0, 3, 5, 5)

-- Calendar
local mytextcalendar = wibox.widget.textclock(markup.fontfg(theme.font, "#FFFFFF", space3 .. "%d %b " .. markup.font("Roboto 5", " ")))
local calbg = wibox.container.background(mytextcalendar, theme.bg_focus, gears.shape.rectangle)
local calendarwidget = wibox.container.margin(calbg, 0, 0, 5, 5)
----datewidget = wibox.widget.textclock('<span color="' .. beautiful.color_white .. '">%R</span> ')
--lain.widgets.calendar:attach(clockwidget, { font = theme.font, font_size = 8, fg = theme.widget_date_fg})
lain.widget.calendar({
    attach_to = { mytextclock, mytextcalendar },
    notification_preset = {
        fg = "#FFFFFF",
        bg = theme.bg_normal,
        position = "top_right",
        font = "Monospace 10"
    }
})

theme.fs = lain.widget.fs({
    options = "--exclude-type=tmpfs",
    notification_preset = { bg = theme.bg_normal, font = "Monospace 9" },
})

-- CPU
local cpu_icon = wibox.widget.imagebox(theme.cpu)
local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(space3 .. markup.font(theme.font, "CPU " .. cpu_now.usage
                          .. "% ") .. markup.font("Roboto 5", " "))
    end
})
local cpubg = wibox.container.background(cpu.widget, theme.bg_focus, gears.shape.rectangle)
local cpuwidget = wibox.container.margin(cpubg, 0, 0, 5, 5)

-- Net
local netdown_icon = wibox.widget.imagebox(theme.net_down)
local netup_icon = wibox.widget.imagebox(theme.net_up)
local net = lain.widget.net({
    settings = function()
        widget:set_markup(markup.font("Roboto 1", " ") .. markup.font(theme.font, net_now.received .. " - "
                          .. net_now.sent) .. markup.font("Roboto 2", " "))
    end
})
local netbg = wibox.container.background(net.widget, theme.bg_focus, gears.shape.rectangle)
local networkwidget = wibox.container.margin(netbg, 0, 0, 5, 5)


---- ALSA volume bar
theme.volume = lain.widget.alsabar({
    ticks = true, width = 67,
    notification_preset = { font = "Monospace 9" }
})
theme.volume.tooltip.wibox.fg = theme.fg_normal
theme.volume.tooltip.wibox.font = "Monospace 9"
theme.volume.bar:buttons(awful.util.table.join (
          awful.button({}, 1, function()
            awful.spawn.with_shell(string.format("%s -e alsamixer", terminal))
          end),
          awful.button({}, 2, function()
            awful.spawn(string.format("%s set %s 100%%", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 3, function()
            awful.spawn(string.format("%s set %s toggle", theme.volume.cmd, theme.volume.togglechannel or theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 4, function()
            awful.spawn(string.format("%s set %s 1%%+", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end),
          awful.button({}, 5, function()
            awful.spawn(string.format("%s set %s 1%%-", theme.volume.cmd, theme.volume.channel))
            theme.volume.update()
          end)
))
local volumebg = wibox.container.background(theme.volume.bar, "#585858", gears.shape.rectangle)
local volumewidget = wibox.container.margin(volumebg, 7, 7, 5, 5)

---- Weather
theme.weather = lain.widget.weather({
    city_id = 2935022,
    notification_preset = { font = "Monospace 9", position = "top_right" },
})

-- MPD
local mpd_icon = awful.widget.launcher({ image = theme.mpdl, command = theme.musicplr })
local prev_icon = wibox.widget.imagebox(theme.prev)
local next_icon = wibox.widget.imagebox(theme.nex)
local stop_icon = wibox.widget.imagebox(theme.stop)
local pause_icon = wibox.widget.imagebox(theme.pause)
local play_pause_icon = wibox.widget.imagebox(theme.play)
theme.mpd = lain.widget.mpd({
    settings = function ()
        if mpd_now.state == "play" then
            play_pause_icon:set_image(theme.pause)
        elseif mpd_now.state == "pause" then
            play_pause_icon:set_image(theme.play)
        else
            play_pause_icon:set_image(theme.play)
        end
    end
})
local musicbg = wibox.container.background(theme.mpd.widget, theme.bg_focus, gears.shape.rectangle)
local musicwidget = wibox.container.margin(musicbg, 0, 0, 5, 5)

musicwidget:buttons(awful.util.table.join(awful.button({ }, 1,
function () awful.spawn(theme.musicplr) end)))
prev_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.spawn.with_shell("mpc prev")
    theme.mpd.update()
end)))
next_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.spawn.with_shell("mpc next")
    theme.mpd.update()
end)))
stop_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    play_pause_icon:set_image(theme.play)
    awful.spawn.with_shell("mpc stop")
    theme.mpd.update()
end)))
play_pause_icon:buttons(awful.util.table.join(awful.button({}, 1,
function ()
    awful.spawn.with_shell("mpc toggle")
    theme.mpd.update()
end)))


function theme.at_screen_connect(s)
    -- Quake application
    --s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with screen
    if type(wallpaper) == "function" then
        theme.wallpaper = theme.wallpaper()
    end
    gears.wallpaper.maximized(theme.wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[2])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicationg which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(awful.util.table.join(
                            awful.button({ }, 1, function () awful.layout.inc(1) end),
                            awful.button({ }, 3, function () awful.layout.inc(-1) end),
                            awful.button({ }, 4, function () awful.layout.inc(1) end),
                            awful.button({ }, 5, function () awful.layout.inc(-1) end)))

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons)

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons, theme.tasklist_theme)

    s.mywibox = awful.wibar({ position = "top", screen = s, height = 20, bg = theme.bg_normal, fg = theme.fg_normal })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            s.mylayoutbox,
            s.mypromptbox,
            -- put more stuff here
        },
        s.mytasklist,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.systray(),
            cpu_icon,
            cpuwidget,
            musicwidget,
            play_pause_icon,
            mpd_icon,
            volumewidget,
            calendarwidget,
            clockwidget,
        },
    }
end

return theme
-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
