return {
    launcher = false, -- show awesome button for main menu
    battery = true, -- show notebook battery
    graphs = true, --  show detailed graphs
    phone = false, --'5608e506aeee6824', -- show phone battery
    sysfs = true, -- listen to sysfs events
    cpu = true, -- show cpu stats
    clock = true, -- show a clock
    mpris = false, -- uzful.util.module.exists('lua-mpris'), -- use mpris client
    memory = true, -- show memory usage
    monitor = true, -- show monitor change notifications
    calendar = true, -- show calendar when hovering clock
    temperature = true, -- show cpu temperature stats
    restore = true, -- enable restoring window stats and tag settings
    network = true, --'wicd', -- or true -- show network & wire stats from wicd via dbus or show at least network stats if true
    notifications = false, -- widget to block notifications and store a history of them
    syslog = uzful.util.module.exists('inotify') and uzful.util.module.exists('socket'),
    dbus = not not dbus and uzful.util.module.exists('lua-dbus'),
    tags = 'symbol', -- or 'number' -- tag name style default
    taglist = 'noempty', -- or 'all' -- talist filter default
    titlebars = false, --'ontop', -- or 'left' or 'right' or 'top' or 'bottom' or false -- titlebar attachment behavior
}