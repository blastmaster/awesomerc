local awful = require("awful")
local beautiful = require("beautiful")
local naughty = require("naughty")
local lain = require("lain")

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

return cpuwidget
