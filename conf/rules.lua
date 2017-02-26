local awful = require("awful")
local beautiful = require("beautiful")
local keys = require("conf.keybindings")

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
return {
    -- All clients will match this rule.
    { rule = { },
      properties = { border_width = beautiful.border_width,
                     border_color = beautiful.border_normal,
                     focus = awful.client.focus.filter,
                     raise = true,
                     keys = keys.clientkeys,
                     buttons = keys.clientbuttons,
                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
        },
        class = {
          "Arandr",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Wpa_gui",
          "pinentry",
          "veromix",
          "Gimp",
          "xtightvncviewer"},

        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add !NOT! titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = true}
    },

    --FIXME: tag must be icon, additional name would be better
    { rule = { class = "Thunderbird"},
        properties = { screen = 1, tag = "" } },
    { rule = { class = "chromium"},
        properties = { screen = 1, tag = ""} },
    { rule = { class = "Gajim" },
        properties = { screen = 1, tag = "" } },
    { rule = { class = "Evince" },
        properties = { screen =  1, tag = "" } },
    { rule = { class = "Okular" },
        properties = { screen = 1, tag = "" } },
    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
}
-- }}}
