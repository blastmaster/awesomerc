local awful = require("awful")
local naughty = require("naughty")
--local menubar = require("menubar")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup").widget
local lain = require("lain")

--menubar.utils.terminal = terminal -- Set the terminal for applications that require it

local keybindings = { globalkeys = {}, clientkeys = {}, clientbuttons = {} }


keybindings.globalkeys = awful.util.table.join(

    -- Hotkeys
    awful.key({modkey,            }, "s",     hotkeys_popup.show_help,
              {description = "show help", group = "awesome"}),

    -- Tag browsing
    awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
            {description = "view previous", group = "tag"}),
    awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
            {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
            {description = "go back", group = "tag"}),

    -- Non-empty tag browsing (Not Default)
    awful.key({ altkey }, "Left", function() lain.util.tag_view_nonempty(-1) end,
              {description = "view previous nonempty", group = "tag"}),
    awful.key({ altkey }, "Right", function() lain.util.tag_view_nonempty(1) end,
              {description = "view next nonempty", group = "tag"}),

    -- Default client keys
    awful.key({ modkey,           }, "j",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "k",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "h",
        function ()
            awful.client.focus.bydirection("left")
            if client.focus then client.focus:raise() end
        end,
        { description = "focus left client", group = "client" }
    ),
    awful.key({ modkey,           }, "l",
        function ()
            awful.client.focus.bydirection("right")
            if client.focus then client.focus:raise() end
        end,
        { description = "focus right client", group = "client" }
    ),

    awful.key({ modkey,           }, "w", function () awful.util.mymainmenu:show() end,
            {description = "show main menu", group = "awesome"}),

    -- Layout manipulation
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
            {description = "swap with next client by index", group = "client"}),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
            {description = "swap with previous client by index", group = "client"}),
    awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
            {description = "focus the next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
            {description = "focus the previous screen", group = "screen"}),
    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
            {description = "jump to urgent client", group = "client"}),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Show/Hide wibox
    awful.key({ modkey }, "b",
        function ()
            for s in screen do
                s.mywibox.visible = not s.mywibox.visible
                if s.mybottomwibox then
                    s.mybottomwibox.visible = not s.mybottomwibox.visible
                end
            end
        end,
        {description = "Show/Hide Wibox", group = "awesome"}
    ),

    -- On the fly useless gaps change
    awful.key({ altkey, "Control" }, "=",
        function ()
            lain.util.useless_gaps_resize(4)
        end,
        {description = "increase gaps", group = "layout"}
    ),
    awful.key({ altkey, "Control" }, "-",
        function ()
            lain.util.useless_gaps_resize(-4)
        end,
        {description = "decrease gaps", group = "layout"}
    ),

    -- Dynamic tagging
    awful.key({ modkey, "Shift" }, "n",
        function ()
            lain.util.add_tag()
        end,
        {description = "add tag dynamically", group = "tag"}
    ),
    awful.key({ modkey, "Shift" }, "r",
        function ()
            lain.util.rename_tag()
        end,
        {description = "rename tag", group = "tag"}
    ),
    awful.key({ modkey, "Shift" }, "Left",
        function ()
            lain.util.move_tag(1)
        end,
        {description = "Move tag left", group = "tag"}
    ),
    awful.key({ modkey, "Shift" }, "Right",
        function ()
            lain.util.move_tag(-1)
        end,
        {description = "Move tag right", group = "tag"}
    ),
    awful.key({ modkey, "Shift" }, "d",
        function ()
            lain.util.delete_tag()
        end,
        {description = "delete tag", group = "tag"}
    ),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
            {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
            {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit,
            {description = "quit awesome", group = "awesome"}),

    awful.key({ altkey, "Shift" }, "l",     function () awful.tag.incmwfact( 0.05)          end,
            {description = "increase master width factor", group = "layout"}),
    awful.key({ altkey, "Shift" }, "h",     function () awful.tag.incmwfact(-0.05)          end,
            {description = "decrease master width factor", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
            {description = "increase the number of master clients", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
            {description = "decrease the number of master clients", group = "layout"}),
    awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
            {description = "increase the number of columns", group = "layout"}),
    awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
            {description = "decrease the number of columns", group = "layout"}),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
            {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
            {description = "select previous", group = "layout"}),

    awful.key({ modkey, "Control" }, "n",
            function ()
                local c = awful.client.restore()
                -- Focus restored client
                if c then
                    client.focus = c
                    c:raise()
                end
            end,
            {description = "restore minimized", group = "client"}
    ),

    awful.key({ modkey, }, "a",
        function ()
            if instance and instance.wibox.visible then
                instance:hide()
                instance = nil
            else
                instance = awful.menu.clients(nil,
                { keygrabber = true, theme = { width = 250 } } )
            end
        end,
        {description = "Show running Programms", group = "awesome"}
    ),

    -- Dropdown application
    awful.key({ modkey, }, "z",
        function()
            awful.screen.focused().quake:toggle()
        end,
        {description = "Toggle dropdown terminal", group = "awesome"}
    ),

    -- Widget popups
    awful.key({ altkey, }, "c",
        function ()
            lain.widget.calendar.show(7)
        end,
        {description = "show calendar widget", group = "widgets"}
    ),
    awful.key({ altkey, }, "h",
        function ()
            if beautiful.fs then
                beautiful.fs.show(7)
            end
        end,
        {description = "show fs widget", group = "widgets"}
    ),
    awful.key({ altkey, }, "w",
        function ()
            if beautiful.weather then
                beautiful.weather.show(7)
            end
        end,
        {description = "show weather widget", group = "widgets"}
    ),

    -- Alsa volume control
    awful.key({ altkey, }, "Up",
        function ()
            os.execute(string.format("amixer set %s 1%%+", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "increase volume", group = "alsa"}
    ),
    awful.key({ altkey, }, "Down",
        function ()
            os.execute(string.format("amixer set %s %1%%-", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "decrease volume", group = "alsa"}
    ),
    awful.key({ altkey, }, "m",
        function ()
            os.execute(string.format("amixer set %s toggle", beautiful.volume.togglechannel or beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "Toggle mute", group = "alsa"}
    ),
    awful.key({ altkey, "Control" }, "m",
        function ()
            os.execute(string.format("amixer set %s 100%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "Set volume to 100%", group = "alsa"}
    ),
    awful.key({ altkey, "Control" }, "0",
        function ()
            os.execute(string.format("amixer -q set %s 0%%", beautiful.volume.channel))
            beautiful.volume.update()
        end,
        {description = "Set volume to 0%", group = "alsa"}
    ),

    -- MPD control
    awful.key({ altkey, "Control" }, "Up",
        function ()
            awful.spawn.with_shell("mpc toggle")
            beautiful.mpd.update()
        end,
        {description = "Toggle mpd", group = "mpd"}
    ),
    awful.key({ altkey, "Control" }, "Down",
        function ()
            awful.spawn.with_shell("mpc stop")
            beautiful.mpd.update()
        end,
        {description = "Stop mpd", group = "mpd"}
    ),
    awful.key({ altkey, "Control" }, "Left",
        function ()
            awful.spawn.with_shell("mpc prev")
            beautiful.mpd.update()
        end,
        {description = "Play previous", group = "mpd"}
    ),
    awful.key({ altkey, "Control" }, "Right",
        function ()
            awful.spawn.with_shell("mpc next")
            beautiful.mpd.update()
        end,
        {description = "Play next", group = "mpd"}
    ),
    awful.key({ altkey, }, "0",
        function ()
            local common = { text = "MPD widget ", position = "top_middle", timeout = 2 }
            if beautiful.mpd.timer.started then
                beautiful.mpd.timer:stop()
                common.text = common.text .. lain.util.markup.bold("OFF")
            else
                beautiful.mpd.timer:start()
                common.text = common.text .. lain.util.markup.bold("ON")
            end
            naughty.notify(common)
        end,
        {description = "Toggle mpd widget on/off", group = "mpd"}
    ),

    -- Copy primary to clipboard (terminals to gtk)
    awful.key({ modkey, }, "c",
        function ()
            awful.spawn("xsel | xsel -i -b")
        end,
        {description = "Copy primary to clipboard", group = "clipboard"}
    ),
    awful.key({ modkey, }, "v",
        function ()
            awful.spawn("xsel -b | xsel")
        end,
        {description = "Copy clipboard to primary", group = "clipboard"}
    ),


    --awful.key({}, "XF86Launch1", function()
        --awful.spawn("xtrlock")
        --awful.spawn("xset dpms force off")
    --end, {description = "lock screen", group = "client"}),

    -- Prompt
    awful.key({ modkey }, "r",
        function()
            awful.spawn("dmenu_run -b -i -p 'Run:' -nb '" .. beautiful.bg_normal .. "' \
            -nf '" .. beautiful.fg_normal .. "' -sb '" .. beautiful.bg_normal .. "' \
            -sf '" .. beautiful.fg_focus .. "'")
        end,
        {description = "run program", group = "launcher"}
    )

    --awful.key({ modkey }, "x",
            --function ()
                --awful.prompt.run({ prompt = "Run Lua code: " },
                --mypromptbox[awful.screen.focused()].widget,
                --awful.util.eval, nil,
                --awful.util.get_cache_dir() .. "/history_eval")
            --end,
            --{description = "lua execute prompt", group = "awesome"}),
    -- Menubar
    --awful.key({ modkey }, "p", function() menubar.show() end,
            --{description = "show the menubar", group = "launcher"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 12 do
    keybindings.globalkeys = awful.util.table.join(keybindings.globalkeys,
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

-- Define clientbuttons
keybindings.clientbuttons = awful.util.table.join(
    awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Define clientkeys
keybindings.clientkeys = awful.util.table.join(
    awful.key({ altkey, "Shift" }, "m", lain.util.magnify_client,
              {description = "magnify client", group = "client"}
    ),
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}
    ),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
            {description = "close", group = "client"}),
    awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
            {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
            {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
            {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
            {description = "toggle keep on top", group = "client"}),
    awful.key({ modkey,           }, "s",      function (c) c.sticky = not c.sticky          end,
        {description = "set window sticky", group = "client"}),
    awful.key({ modkey,           }, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end ,
        {description = "minimize", group = "client"}),
    awful.key({ modkey,           }, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end ,
        {description = "maximize", group = "client"})
)

return keybindings
