local beautiful = require("beautiful")
local wibox = require("wibox")
local lain = require("lain")

datewidget = wibox.widget.textclock('<span color="' .. beautiful.color_white .. '">%R</span> ')
lain.widgets.calendar:attach(datewidget, { icons = '', font = beautiful.font, font_size = 8, fg = beautiful.widget_date_fg})

return datewidget
