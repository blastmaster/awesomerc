local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")

local remainingtime
batwidget = lain.widgets.bat({
  timeout = 60,
  battery = "BAT0",
  notify = "off",
  settings = function()
    remainingtime = bat_now.time
    if bat_now.status == "Full" then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"> </span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    elseif bat_now.status == "N/A" or bat_now.status == "Unknown" then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"> </span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    elseif bat_now.status == "Charging" then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"> </span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    elseif tonumber(bat_now.perc) > 60 then
      widget:set_markup('<span font="' .. beautiful.iconFont .. '" color="' .. beautiful.widget_bat_fg .. '"> </span> <span color="' .. beautiful.widget_bat_fg .. '">' .. bat_now.perc .. '%</span>')
    elseif tonumber(bat_now.perc) > 10 then
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

return batwidget
