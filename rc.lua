-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
awful.rules = require("awful.rules")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
--local lognotify = require("lognotify")

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
                         text = err })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
beautiful.init(awful.util.getdir("config") .. "/themes/default/theme.lua")

vicious = require("vicious")
--require('freedesktop.utils')
--require('freedesktop.menu')

uzful = require("uzful")
require("uzful.restore")
uzful.util.patch.vicious()

-- This is used later as the default terminal and editor to run.
terminal = "urxvt"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

menubar.cache_entries = true
menubar.show_categories = true
menubar.geometry.height = 14

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
local layouts =
{
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
    awful.layout.suit.magnifier
}
-- }}}


SCREEN = {LVDS1=1}

-- {{{ Wallpaper
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, theme.bg_normal)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
tags_numbered = false
tag_names = { "[1]", "[2]", "[3]", "[4]", "[5]", "[6]", "[7]", "[8]", "[9]", "[A]", "[B]", "[C]" }
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag(tag_names, s, layouts[3])
end
-- }}}

--myrestorelist = uzful.restore(layouts)

--{{{
detailed_graphs = uzful.menu.toggle_widgets()

taglist_filter = uzful.util.functionlist({
    awful.widget.taglist.filter.all,
	awful.widget.taglist.filter.noempty })

local menu_graph_text = function ()
    return (detailed_graphs.visible() and "disable" or "enable") .. " graphs"
end

local menu_tags_text = function ()
    return (tags_numbered and "symbol" or "number") .. " tags"
end

local menu_taglist_text = function ()
    if taglist_filter.current() == 1 then
        return "hide empty tags"
    elseif taglist_filter.current() == 2 then
        return "show all tags"
    else
        return "nil"
    end
end

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
   {"wallpapers", uzful.menu.wallpaper.menu(theme.wallpapers)},
   { "manual", terminal .. " -e man awesome" },
   { menu_taglist_text(), function (m)
	   taglist_filter.next()
	   m.label:set_text(menu_taglist_text())
	   for s = 1, screen.count() do
		   tags[s][1].name = tags[s][1].name
	   end
   end },
   { menu_graph_text(), function (m)
       detailed_graphs.toggle()
       m.label:set_text(menu_graph_text())
   end},
   { menu_tags_text(), function (m)
       tags_numbered = not tags_numbered
       for s = 1, screen.count() do
           for i, t in ipairs(tags[s]) do
               t.name = tags_numbered and tostring(i) or tag_names[i]
           end
       end
       m.label:set_text(menu_tags_text())
   end },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

---- Create a textclock widget
mytextclock = awful.widget.textclock(' %H:%M ')
mytextclock:set_font("sans 7")
mycal = uzful.widget.calendar({ font = 7,
head = '<span color="#666666">$1</span>',
week = '<span color="#999999">$1</span>',
day = '<span color="#BBBBBB">$1</span>',
number = '<span color="#EEEEEE">$1</span>',
current = '<span color="green">$1</span>',
})
--
mytextclock:buttons(awful.util.table.join(
    awful.button({ }, 1, function() mycal:switch_month(-1) end),
    awful.button({ }, 2, function() mycal:now() end),
    awful.button({ }, 3, function() mycal:switch_month( 1) end),
    awful.button({ }, 4, function() mycal:switch_month(-1) end),
    awful.button({ }, 5, function() mycal:switch_month( 1) end),
    awful.button({ 'Shift' }, 1, function() mycal:switch_year(-1) end),
    awful.button({ 'Shift' }, 2, function() mycal:now() end),
    awful.button({ 'Shift' }, 3, function() mycal:switch_year( 1) end),
    awful.button({ 'Shift' }, 4, function() mycal:switch_year(-1) end),
    awful.button({ 'Shift' }, 5, function() mycal:switch_year( 1) end)
))
--
---- Memory Progressbar
 mymem = uzful.widget.progressimage({
    x = 2, y = 2, width = 5, height = 10,
    image = theme.memory, draw_image_first = false })
uzful.widget.set_properties(mymem.progress, {
    vertical = true, background_color = "#000000",
    border_color = nil, color = "#0173FF" })
--mymem:set_color({ "#001D40", "#535d6c", "#0173FF" })
vicious.register(mymem.progress, vicious.widgets.mem, "$1", 13)

---- Battery Progressbar
local htimer = nil
local dock_online = ((uzful.util.scan.sysfs({
    property = {"modalias", "platform:dock"},
    sysattr = {"type", "dock_station"},
    subsystem = "platform",
}).sysattrs[1] or {}).docked == "1")
local power_supply_online = ((uzful.util.scan.sysfs({
    property = {"power_supply_name", "AC"},
    subsystem = "power_supply",
}).properties[1] or {}).power_supply_online == "1")
local battery_online = (uzful.util.scan.sysfs({
    property = {"power_supply_name", "BAT0"},
    subsystem = "power_supply"}).length > 0)

mybat = uzful.widget.progressimage({
    image = battery_online and (dock_online and theme.dock or theme.battery) or theme.nobattery,
    draw_image_first = not power_supply_online,
    x = 3, y = 4, width = 3, height = 7 })
uzful.widget.set_properties(mybat.progress, {
    ticks = true, ticks_gap = 1,  ticks_size = 1,
    vertical = true, background_color = "#000000",
    border_color = nil, color = "#FFFFFF" })
vicious.register(mybat.progress, vicious.widgets.bat, "$2", 45, "BAT0")

htimer = uzful.util.listen.sysfs({ subsystem = "power_supply", timer = htimer },
                                 function (device, props)
    if props.action == "change" and props.power_supply_name == "AC" then
        if props.power_supply_online == "0" then
            mybat.draw_image_first()
            power_supply_online = false
        else
            mybat.draw_progress_first()
            power_supply_online = true
        end
    elseif props.power_supply_name == "BAT0" then
        if props.action == "remove" then
            mybat.draw_progress_first()
            mybat.progress:set_value(nil)
            mybat:set_image(theme.nobattery)
            battery_online = false
        elseif props.action == "add" then
            if not power_supply_online then
                mybat.draw_image_first()
            end
            mybat:set_image(dock_online and theme.dock or theme.battery)
            vicious.force({mybat.progress, mybtxt})
            battery_online = true
        end
    end
end).timer

htimer = uzful.util.listen.sysfs({ subsystem = "platform", timer = htimer },
                                 function (device, props, attrs)
    if props.action == "change" and
       props.modalias == "platform:dock" and
       attrs.type == "dock_station"
    then
        if props.event == "undock" then
            dock_online = false
        elseif props.event == "dock" then
            dock_online = true
        end
        if battery_online then
            mybat:set_image(dock_online and theme.dock or theme.battery)
        end
    end
end).timer


htimer = uzful.util.listen.sysfs({ subsystem = "drm", timer = htimer },
                                 function (device, props)
    if props.action == "change" and props.devtype == "drm_minor" and screen.count() > 1 then
        naughty.notify({
            timeout = 0,
            hover_timeout = 0.1,
            position = "bottom_right",
            icon = theme.nomonitor })
    end
end).timer

local mynotibat, mycritbat_old_val = nil, 0
mycritbat = uzful.util.threshold(0.2,
    function (val)
        mycritbat_old_val = val
        mybat.progress:set_background_color("#000000")
        if mynotibat ~= nil then  naughty.destroy(mynotibat)  end
    end,
    function (val)
        if not battery_online then
            mybat.progress:set_background_color("#000000")
            if mynotibat ~= nil then  naughty.destroy(mynotibat)  end
            return
        end
        mybat.progress:set_background_color("#8C0000")
        if val < 0.1 and val <= mycritbat_old_val then
            if mynotibat ~= nil then  naughty.destroy(mynotibat)  end
            mynotibat = naughty.notify({
                preset = naughty.config.presets.critical,
                title = "Critical Battery Charge",
                text =  "only " .. (val*100) .. "% remaining."})
        end
        mycritbat_old_val = val
    end)
vicious.register(mycritbat, vicious.widgets.bat, "$2", 90, "BAT0")

-- Network Progressbar
--mynet = nil
--mynettxt = nil
--if dbus then
--    mynet = uzful.widget.progressimage({
--        --image = theme.wicd.unknown,
--        draw_image_first = false,
--        x = 1, y = 2, width = 3, height = 9 })
--    uzful.widget.set_properties(mynet.progress, {
--        ticks = true, ticks_gap = 1,  ticks_size = 1,
--        vertical = true, background_color = "#000000",
--        border_color = nil, color = "#33FF3399" })
--    mynettxt = wibox.widget.textbox()
--    mynettxt:set_font("ProggyTinyTT 7")
--    mynettxt:set_text(" ")
--    dbus.connect_signal("org.wicd.daemon", function (ev, status, data)
--        local state = ({
--            "not_connected","connecting","wireless","wired","suspended"
--        })[status + 1] or "unknown"
----         print("changed wicd status to "..state)
--        mynet:set_image(theme.wicd[state])
--        if state == "wireless" then
--            mynet.progress:set_value((data[3] or 0) / 100)
--        else
--            if state == "connecting" then
--                if data[1] == "wireless" then
--                    mynetgraphs.switch("wlan0")
--                elseif data[1] == "wired" then
--                    mynetgraphs.switch("eth0")
--                end
--            end
--            mynet.progress:set_value(nil)
--        end
--        local text = ""
--        for _, line in ipairs(data) do text = text .. line .. "\n" end
--        if text == "" or text == "\n" then text = " " end
--        mynettxt:set_text(text)
----         print(require('serpent').block(data))
--    end)
--    dbus.add_match("system",
--             "type='signal',interface='org.wicd.daemon',member='StatusChanged'")
--end
--
-- Memory Text
mymtxt = wibox.widget.textbox()
mymtxt:set_font("ProggyTinyTT 12")
vicious.register(mymtxt, vicious.widgets.mem,
    '$4mb free, $1%', 60)

---- Battery Text
mybtxt = wibox.widget.textbox()
mybtxt:set_font("ProggyTinyTT 12")
vicious.register(mybtxt, vicious.widgets.bat,
    '$1$3 $2%', 60, "BAT0")

---- Temperature Info
mytemp = wibox.widget.textbox()
mytemp:set_font("sans 6")
mycrittemp = uzful.util.threshold(0.8,
    function (val)
        mytemp:set_markup('<span color="red">' ..
            (val*100) .. '°</span>')
    end,
    function (val)
        mytemp:set_markup('<span color="#666666" size="small">' ..
            (val*100) .. '°</span>')
    end)
vicious.register(mycrittemp, vicious.widgets.thermal, "$1", 30, "thermal_zone0")


mytempgraph = awful.widget.graph({ width = 161, height = 42 })
table.insert(detailed_graphs.widgets, mytempgraph)
uzful.widget.set_properties(mytempgraph, {
    border_color = nil,
    color = "#AA0000",
    background_color = "#000000" })
vicious.register(mytempgraph, vicious.widgets.thermal, "$1", 4, "thermal_zone0")

---- net usage graphs
mynetgraphs = uzful.widget.netgraphs({ default = "wlan0",
    up_fgcolor = "#D0000399", down_fgcolor = "#95D04399",
    up_mgcolor = "#D0000311", down_mgcolor = "#95D04311",
    highlight = ' <b>$1</b>', direction = "right",
    normal    = ' <span color="#666666">$1</span>',
    big = { width = 161, height = 42, interval = 2, scale = "kb" },
    small = { width = 23, height = theme.menu_height, interval = 2 } })

mynetgraphs.update_active()

mynetgraphs.update_widget = function ()
    mynetgraphs.update_active()
    myinfobox.net.height = mynetgraphs.big.height
    myinfobox.net:update()
end

mynetgraphs.small.layout:buttons(awful.util.table.join(
    awful.button({ }, 1, mynetgraphs.toggle),
    awful.button({ }, 2, mynetgraphs.update_widget),
    awful.button({ }, 3, mynetgraphs.toggle),
    awful.button({ }, 4, mynetgraphs.toggle),
    awful.button({ }, 5, mynetgraphs.toggle)
))

for _, widget in ipairs(mynetgraphs.big.widgets) do
    table.insert(detailed_graphs.widgets, widget)
end
--
---- CPU graphs
mycpugraphs = uzful.widget.cpugraphs({
    fgcolor = "#D0752A", bgcolor = "#000000", direction = "right",
    load = { interval = 20, font = "ProggyTinyTT 10",
        text = ' <span color="#666666">$1</span>' ..
               '  <span color="#9A9A9A">$2</span>' ..
               '  <span color="#DDDDDD">$3</span>' },
    big = { width = 161, height = 42, interval = 1, direction = "left" },
    small = { width = 42, height = theme.menu_height, interval = 1 } })

table.insert(detailed_graphs.widgets, mycpugraphs.load)
for _, widget in ipairs(mycpugraphs.big.widgets) do
    table.insert(detailed_graphs.widgets, widget)
end

myinfobox = { net = {}, cpu = {}, cal = {}, bat = {}, mem = {}, temp = {}, wifi = {} }

myinfobox.net = uzful.widget.infobox({
        position = "top", align = "right",
        widget = mynetgraphs.big.layout,
        height = mynetgraphs.big.height,
        width = mynetgraphs.big.width })
myinfobox.cpu = uzful.widget.infobox({
        position = "top", align = "right",
        widget = mycpugraphs.big.layout,
        height = mycpugraphs.big.height,
        width = mycpugraphs.big.width })
myinfobox.temp = uzful.widget.infobox({
        size = function () return mytempgraph:fit(-1, -1) end,
        position = "top", align = "right",
        widget = uzful.layout.build({
                widget = mytempgraph,
                reflection = { vertical = true },
                layout = wibox.layout.mirror }) })
myinfobox.cal = uzful.widget.infobox({
        size = function () return mycal.width,mycal.height end,
        position = "top", align = "right",
        widget = mycal.widget })
myinfobox.bat = uzful.widget.infobox({
        size = function () return mybtxt:fit(-1, -1) end,
        position = "top", align = "right",
        widget = mybtxt })
myinfobox.mem = uzful.widget.infobox({
        size = function () return mymtxt:fit(-1, -1) end,
        position = "top", align = "right",
        widget = mymtxt })
----if mynettxt then
----    myinfobox.wifi = uzful.widget.infobox({
----            size = function () return mynettxt:fit(-1, -1) end,
----            position = "top", align = "right",
----            widget = mynettxt })
----end
--
mynetgraphs.small.layout:connect_signal("mouse::enter", function ()
    if detailed_graphs.visible() then
        myinfobox.net:update()
        myinfobox.net:show()
    end
end)

mycpugraphs.small.layout:connect_signal("mouse::enter", function ()
    if detailed_graphs.visible() then
        myinfobox.cpu:update()
        myinfobox.cpu:show()
    end
end)

mytemp:connect_signal("mouse::enter", function ()
    if detailed_graphs.visible() then
        myinfobox.temp:update()
        myinfobox.temp:show()
    end
end)

mytextclock:connect_signal("mouse::enter", function ()
    mycal:update()
    myinfobox.cal:update()
    myinfobox.cal:show()
end)

mybat:connect_signal("mouse::enter", function ()
    myinfobox.bat:update()
    myinfobox.bat:show()
end)

mymem:connect_signal("mouse::enter", function ()
    myinfobox.mem:update()
    myinfobox.mem:show()
end)
--
--if mynet then
--    mynet:connect_signal("mouse::enter", function ()
--        myinfobox.wifi:update()
--        myinfobox.wifi:show()
--    end)
--end
--
mynetgraphs.small.layout:connect_signal("mouse::leave", myinfobox.net.hide)
mycpugraphs.small.layout:connect_signal("mouse::leave", myinfobox.cpu.hide)
mytextclock:connect_signal("mouse::leave", myinfobox.cal.hide)
mytemp:connect_signal("mouse::leave", myinfobox.temp.hide)
mybat:connect_signal("mouse::leave", myinfobox.bat.hide)
mymem:connect_signal("mouse::leave", myinfobox.mem.hide)
----if mynet then
----    mynet:connect_signal("mouse::leave", myinfobox.wifi.hide)
----end
--

mylayoutmenu = uzful.menu.layouts(layouts, { align = "right", width = 80 })



-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}


-- Create a wibox for each screen and add it
mywibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}

mytaglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ modkey }, 1, awful.client.movetotag),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, awful.client.toggletag),
	awful.button({ }, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
	awful.button({ }, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end)
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
			if not c:isvisible() then
				awful.tag.viewonly(c:tags()[1])
			end
			-- This will also un-minimize
			-- the client, if needed
			client.focus = c
			c:raise()
		end
	end),
	awful.button({ }, 3, function ()
		if instance then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients(nil,{theme={ width=250 }})
		end
	end),
	awful.button({ }, 4, function ()
		awful.client.focus.byidx(1)
		if client.focus then client.focus:raise() end
	end),
	awful.button({ }, 5, function ()
		awful.client.focus.byidx(-1)
		if client.focus then client.focus:raise() end
	end))
-- create dashboard_placeholder widget and add in background
	dashboard_placeholder = wibox.widget.background()
	dashboard_placeholder.fit = function()
		if dashboard and not dashboard.minimized then
			local g = dashboard:geometry()
			return g.width, g.height
		end
		return 0,0
	end

for s = 1, screen.count() do
    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(
	awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
	awful.button({ }, 2, function () mylayoutmenu:toggle() end),
	awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
	awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
	awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, taglist_filter.call, mytaglist.buttons)

    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = theme.menu_height })

   -- if myrestorelist[s].length > 0 then
   --     myrestorelist[s].widget = uzful.widget.infobox({ screen = s,
   --         size = myrestorelist[s].fit,
   --         position = "top", align = "left",
   --         visible = true, ontop = false,
   --         widget = myrestorelist[s].layout })
   --    myrestorelist[s].layout:connect_signal("widget::updated", function ()
   --        if myrestorelist[s].length == 0 then
   --           myrestorelist[s].widget:hide()
   --            myrestorelist[s].widget.screen = nil
   --        else
   --            myrestorelist[s].widget:update()
   --        end
   --    end)
   --end

    local layout = uzful.layout.build({
        layout = wibox.layout.align.horizontal,
        left = { layout = wibox.layout.fixed.horizontal,
            --mylauncher,
            mytaglist[s],
            mypromptbox[s] },
        middle = mytasklist[s],
        right = { layout = wibox.layout.fixed.horizontal,
            function () return s == SCREEN.LVDS1 and wibox.widget.systray() or nil end,
            --mynotification[s].text,
            mynetgraphs.small.layout,
            mycpugraphs.small.layout,
            mytemp,
            mytextclock,
            --mynet,
            mybat,
            mymem,
            mylayoutbox[s] }
    })
-- give dashboard its own layout
	layout = uzful.layout.build({
		layout = wibox.layout.fixed.vertical,
		dashboard_placeholder,
		layout})

    mywibox[s]:set_widget(layout)
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore        ),

    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end),
	awful.key({ modkey, }, "a", function ()
		if instance and instance.wibox.visible then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients(nil,
			{ keygrabber = true, theme = { width = 250 } } )
		end
	end),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
    awful.key({ modkey, "Control" }, "r", awesome.restart),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit),

    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),

    awful.key({ modkey, "Control" }, "n", awful.client.restore),

    -- Prompt
    --awful.key({ modkey },            "r",     function () mypromptbox[mouse.screen]:run() end),

    -- Menubar
    awful.key({ modkey }, "p", function() menubar.show() end),
    awful.key({ modkey }, "r", function()
        awful.util.spawn("dmenu_run -b -i -p 'Run:' -nb '" .. theme.bg_normal .. "' \
        -nf '" .. theme.fg_normal .. "' -sb '" .. theme.bg_normal .. "' \
        -sf '" .. theme.fg_focus .. "'") end),
    awful.key({ modkey }, "x", function()
        awful.util.spawn_with_shell("execattach.sh")
    end),
    awful.key({}, "XF86Launch1", function()
		awful.util.spawn("xtrlock")
        awful.util.spawn("xset dpms force off")
        --awful.util.spawn_with_shell("lock")
    end)
)

clientkeys = awful.util.table.join(
    awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
    awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
    awful.key({ modkey,           }, "s",      function (c) c.sticky = not c.sticky          end), --"toggle sticky"),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end)
)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
   keynumber = math.min(12, math.max(#tags[s], keynumber))
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
                  function ()
                        local screen = mouse.screen
                        if tags[screen][i].selected then
                            return awful.tag.history.restore()
                        end
                        if tags[screen][i] then
                            awful.tag.viewonly(tags[screen][i])
                        end
                  end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
                  function ()
                      local screen = mouse.screen
                      if tags[screen][i] then
                          awful.tag.viewtoggle(tags[screen][i])
                      end
                  end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.movetotag(tags[client.focus.screen][i])
                      end
                  end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                  function ()
                      if client.focus and tags[client.focus.screen][i] then
                          awful.client.toggletag(tags[client.focus.screen][i])
                      end
                  end))
end

-- make dashboard togglebar
globalkeys = awful.util.table.join(globalkeys,
	awful.key({}, "F12", function ()
		if dashboard then
			local s, olds = mouse.screen, dashboard.screen
			if s == olds then
				dashboard.minimized = not dashboard.minimized
			else
				mywibox[olds].height = theme.menu_height
			end
			if not dashboard.minimized then
				client.focus = dashboard
			end
			dashboard.screen = s
			mywibox[s].height = theme.menu_height +
			(dashboard.minimized and 0 or dashboard:geometry().height)
			mywibox[s].draw()
		end
	end)
	)

clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     size_hints_honor = false,
                     focus = awful.client.focus.filter,
                     keys = clientkeys,
                     buttons = clientbuttons } },
    { rule = { class = "MPlayer" },
      properties = { floating = true } },
    { rule = { class = "pinentry" },
      properties = { floating = true } },
    { rule = { class = "gimp" },
      properties = { floating = true } },
	  { rule = { class = "gvim" },
	  properties = { size_hints_honor = false }},
    -- Set Firefox to always map on tags number 2 of screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { tag = tags[1][2] } },
}
-- }}}

-- disable dashboard by default
dashboard = nil

-- {{{ Signals
client.connect_signal("unmanage", function (c)
	if c == dashboard then
		local s = dashboard.screen
		mywibox[s].height = theme.menu_height
		mywibox[s].draw()
		dashboard = nil
	end
end)

-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c, startup)
    --c.opacity = 1
    -- Enable sloppy focus
    c:connect_signal("mouse::enter", function(c)
        if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
            and awful.client.focus.filter(c) then
            client.focus = c
        end
    end)

	if not dashboard and c.instance == "urxvt" then
		dashboard = c
		c.minimized = true
		c.border_width = 0
		c.focusable = true
		c.sticky = true
		c.maximized_horizontal = true
		c.skip_taskbar = true
		c.floating = true
		c:geometry({y = c:geometry().y - theme.menu_height, height = 300 })
	end

    if not startup then
        -- Set the windows at the slave,
        -- i.e. put it at the end of others instead of setting it master.
        -- awful.client.setslave(c)

        -- Put windows in a smart way, only if they does not set an initial position.
        if not c.size_hints.user_position and not c.size_hints.program_position then
            awful.placement.no_overlap(c)
            awful.placement.no_offscreen(c)
        end
    end

    --local titlebars_enabled = false
    --if titlebars_enabled and (c.type == "normal" or c.type == "dialog") then
    --    -- Widgets that are aligned to the left
    --    local left_layout = wibox.layout.fixed.horizontal()
    --    left_layout:add(awful.titlebar.widget.iconwidget(c))

    --    -- Widgets that are aligned to the right
    --    local right_layout = wibox.layout.fixed.horizontal()
    --    right_layout:add(awful.titlebar.widget.floatingbutton(c))
    --    right_layout:add(awful.titlebar.widget.maximizedbutton(c))
    --    right_layout:add(awful.titlebar.widget.stickybutton(c))
    --    right_layout:add(awful.titlebar.widget.ontopbutton(c))
    --    right_layout:add(awful.titlebar.widget.closebutton(c))

    --    -- The title goes in the middle
    --    local title = awful.titlebar.widget.titlewidget(c)
    --    title:buttons(awful.util.table.join(
    --            awful.button({ }, 1, function()
    --                client.focus = c
    --                c:raise()
    --                awful.mouse.client.move(c)
    --            end),
    --            awful.button({ }, 3, function()
    --                client.focus = c
    --                c:raise()
    --                awful.mouse.client.resize(c)
    --            end)
    --            ))

    --    -- Now bring it all together
    --    local layout = wibox.layout.align.horizontal()
    --    layout:set_left(left_layout)
    --    layout:set_right(right_layout)
    --    layout:set_middle(title)

    --    awful.titlebar(c):set_widget(layout)
    --end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
require("autostart")
