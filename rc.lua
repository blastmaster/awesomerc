-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local lain = require("lain")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical,
                     title = "Oops, there were errors during startup!",
                     text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({ preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
--beautiful.init(awful.util.get_themes_dir() .. "default/theme.lua")
beautiful.init("~/.config/awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "roxterm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
    local instance = nil

    return function ()
        if instance and instance.wibox.visible then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ theme = { width = 250 } })
        end
    end
end
-- }}}

local mymainmenu = require("rc.menu")

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibox

-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(
                    awful.button({ }, 1, function(t) t:view_only() end),
                    awful.button({ modkey }, 1, function(t)
                                              if client.focus then
                                                  client.focus:move_to_tag(t)
                                              end
                                          end),
                    awful.button({ }, 3, awful.tag.viewtoggle),
                    awful.button({ modkey }, 3, function(t)
                                              if client.focus then
                                                  client.focus:toggle_tag(t)
                                              end
                                          end),
                    awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
                    awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
                )

mytasklist = {}
mytasklist.buttons = awful.util.table.join(
                     awful.button({ }, 1, function (c)
                                              if c == client.focus then
                                                  c.minimized = true
                                              else
                                                  -- Without this, the following
                                                  -- :isvisible() makes no sense
                                                  c.minimized = false
                                                  if not c:isvisible() and c.first_tag then
                                                      c.first_tag:view_only()
                                                  end
                                                  -- This will also un-minimize
                                                  -- the client, if needed
                                                  client.focus = c
                                                  c:raise()
                                              end
                                          end),
                     awful.button({ }, 3, client_menu_toggle_fn()),
                     awful.button({ }, 4, function ()
                                              awful.client.focus.byidx(1)
                                          end),
                     awful.button({ }, 5, function ()
                                              awful.client.focus.byidx(-1)
                                          end))

-- Widgets


-- {{{ CPU usage
cpuwidget = lain.widgets.sysload({
  timeout = 5,
  settings = function()
    widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_cpu_fg_icon .. '"> </span> <span color="' .. beautiful.widget_cpu_fg .. '">' .. load_1 .. '</span>')
  end
})

cpuwidget:buttons(awful.util.table.join(awful.button({ }, 1, function () awful.util.spawn(terminal .. " -e htop") end)))

local cpunotification
cpuwidget:connect_signal("mouse::enter", function()
  local cpuusage
  lain.widgets.cpu({
    settings = function()
      cpuusage = cpu_now.usage
    end
  })

  local ramtotal
  local ramusage
  local swaptotal
  local swapusage
  lain.widgets.mem({
    settings = function()
      ramusage = mem_now.used
      ramtotal = mem_now.total
      swapusage = mem_now.swapused
      swaptotal = mem_now.swapf
    end
  })
  cpunotification = naughty.notify({
    text = "CPU: " .. cpuusage .. "%\nRAM: " .. ramusage .. "/" .. ramtotal .. " MB\nSWAP: " .. swapusage .. "/" .. swaptotal .. " MB",
    position = "top_right",
    timeout = 0,
    fg = beautiful.color_white
  })
end)
cpuwidget:connect_signal("mouse::leave", function()
  if (cpunotification ~= nil) then
    naughty.destroy(cpunotification)
    cpunotification = nil
  end
end)

-- }}}

-- {{{ Battery state
local remainingtime
batwidget = lain.widgets.bat({
  timeout = 60,
  battery = "BAT0",
  notify = "off",
  settings = function()
    remainingtime = bat_now.time
    if bat_now.status == "Charging" or bat_now.status == "Full" then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"> </span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    elseif tonumber(bat_now.perc) > 60 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"> </span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    elseif tonumber(bat_now.perc) > 20 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"> </span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    else
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_batlow_fg .. '"> </span> <span color="' .. beautiful.widget_batlow_fg .. '">' .. bat_now.perc .. '%</span>')
    end
  end
})
local batnotification
batwidget:connect_signal("mouse::enter", function()
  batnotification = naughty.notify({
    text = "Remaining time: " .. remainingtime,
    position = "top_right",
    timeout = 0,
    fg = beautiful.color_white
  })
end)
batwidget:connect_signal("mouse::leave", function()
  if (batnotification ~= nil) then
    naughty.destroy(batnotification)
    batnotification = nil
  end
end)

-- {{{ Volume information
volwidget = lain.widgets.alsa({
  timeout = 2,
  channel = "Master",
  settings = function()
    if volume_now.status == "off" or volume_now.level == "0" then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg_icon .. '"> </span> <span color="' .. beautiful.widget_vol_fg .. '"></span>')
    elseif tonumber(volume_now.level) > 70 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg_icon .. '"> </span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.level .. '</span>')
    elseif tonumber(volume_now.level) > 40 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg_icon .. '"> </span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.level .. '</span>')
    else
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_vol_fg_icon .. '"> </span> <span color="' .. beautiful.widget_vol_fg .. '">' .. volume_now.level .. '</span>')
    end
  end
})

-- TODO
volwidget:buttons(awful.util.table.join(
     awful.button({}, 1,
     function() awful.util.spawn_with_shell(terminal .. " -e alsamixer") end),
     awful.button({ }, 3,
     function() awful.util.spawn_with_shell("amixer -q set Master toggle") end),
     awful.button({ }, 4,
     function() awful.util.spawn_with_shell("amixer -q set Master 5%+ unmute") end),
     awful.button({ }, 5,
     function() awful.util.spawn_with_shell("amixer -q set Master 5%- unmute") end)
))

-- {{{ Date and time
dateicon = wibox.widget.textbox()
dateicon:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_date_fg_icon .. '"> </span> ')
datewidget = wibox.widget.textclock('<span color="' .. beautiful.color_white .. '">%R</span> ')
lain.widgets.calendar:attach(datewidget, { icons = '', font = beautiful.font, font_size = 8, fg = beautiful.widget_date_fg})

-- }}}

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end

    -- Each screen has its own tag table.
    --          1     2    3    4    5    6    7    8    9    10   11  12
    awful.tag({ "", "", "", "", "", "", "", "", "", "", "", ""  }, s, awful.layout.layouts[3])

    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
                           awful.button({ }, 1, function () awful.layout.inc( 1) end),
                           awful.button({ }, 3, function () awful.layout.inc(-1) end),
                           awful.button({ }, 4, function () awful.layout.inc( 1) end),
                           awful.button({ }, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons, beautiful.tasklist_theme)

    -- Create the wibox
    mywibox[s] = awful.wibar({ position = "top", screen = s, bg = beautiful.bg_tagbar })

    -- Add widgets to the wibox
    mywibox[s]:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            mytaglist[s],
            -- todo remove prompt before, enable dmenu
            mypromptbox[s],
        },
        mytasklist[s], -- Middle widget
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            volwidget,
            cpuwidget,
            batwidget,
            dateicon,
            datewidget,
            mylayoutbox[s],
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}
globalkeys = require("rc.keybindings")

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys.globalkeys = awful.util.table.join(globalkeys.globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9,
                function ()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                        tag:view_only()
                        end
                end,
                {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag.
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                function ()
                    local screen = awful.screen.focused()
                    local tag = screen.tags[i]
                    if tag then
                        awful.tag.viewtoggle(tag)
                    end
                end,
                {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                function ()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:move_to_tag(tag)
                        end
                    end
                end,
                {description = "move focused client to tag #"..i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                function ()
                    if client.focus then
                        local tag = client.focus.screen.tags[i]
                        if tag then
                            client.focus:toggle_tag(tag)
                        end
                    end
                end,
                {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys.globalkeys)
-- }}}

awful.rules.rules = require("rc.rules")

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and
      not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = awful.util.table.join(
        awful.button({ }, 1, function()
            client.focus = c
            c:raise()
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            client.focus = c
            c:raise()
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.floatingbutton (c),
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.stickybutton   (c),
            awful.titlebar.widget.ontopbutton    (c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Enable sloppy focus
client.connect_signal("mouse::enter", function(c)
    if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
        and awful.client.focus.filter(c) then
        client.focus = c
    end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
