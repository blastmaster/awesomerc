local awful = require("awful")
local beautiful = require("beautiful")
local lain = require("lain")

local volwidget = lain.widgets.alsa({
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

return volwidget
