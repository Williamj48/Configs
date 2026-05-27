-- et programs that you use
local fileManager = "thunar"
local terminal    = "kitty"
local menu        = "hyprlauncher"
require("variables")
require("window_rules")

-- Monitor setup
-- If you need to change the orientaiton of your monitors change this portion
hl.monitor({
    output = "",
    mode = "preferred",
    position = "auto",
    scale = 1,
})

hl.config({

    general = {
        layout = "dwindle",
        -- layout = "master", -- What I normally like
            border_size = 1,
            gaps_in = 0,
            gaps_out = 0,
    --        active_border = 0xffffffff,
    --        inactive_border = 0x0000000,
    },
    input = {
        -- Keyboard options
        kb_layout = "us",
        kb_options = "caps:escape,ctrl:swap_lalt_lctl",
        -- kb_model = "apple", -- That wasn't a quick dirty fix to swappipng mods
        follow_mouse = 0, -- If the mouse behavior bugs you go to
        -- the link below and ctrl f follow_mouse
        -- https://wiki.hypr.land/Configuring/Basics/Variables/
        --Touchpad options
        touchpad = {
            natural_scroll = false,
            scroll_factor = 1.1,
            drag_lock = 1, -- Make it easier to drag things
            -- https://wiki.hypr.land/Configuring/Basics/Variables/
            drag_3fg= 1
        },
        -- Mouse options
--       sensitvity = 0, -- Raise this for fast cursor
    },

    group = {
       auto_group = true,
	groupbar = {
			enabled = true,
            font_size = 20,
            stacked = false,
	   }
    },
    animations = {
        enabled = false
    }
})


-- Work space rules fit their name. They are for specfic effects on workspaces.

-- Workspaces designated to monitors
hl.workspace_rule({ monitor = "eDP-1", workspace = "w[1-4]" })
-- Fill in the other monitor name
-- hl.workspace_rule({monitor = "eDP-1", workspace = "w[5-10]"})

-- hl.bind("SUPER + J", hl.dsp.focus( "right" ), {description = "go to the right"})
-- hl.bind("SUPER + SHIFT + space", function()
-- end))

-- The execs could be racey. May need a wait
hl.on("hyprland.start", function()
    hl.exec_cmd(" waybar & blueman-applet & flameshot")
    hl.exec_cmd("hypridle & hyprtodo & hyprpaper")
end)

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

hl.bind(mainMod .. " + SPACE", hl.dsp.window.float({ action = "toggle" }))

------------------------------------
-- LAUNCHERS
--
-- hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"), { description = "Open my favourite terminal" })
------------------------------------

hl.bind("SUPER + B", hl.dsp.exec_cmd("firefox"))
hl.bind("SUPER + RETURN", hl.dsp.exec_cmd("kitty"), {})
hl.bind( "SUPER + E", hl.dsp.exec_cmd(fileManager))
hl.bind("SUPER + R", hl.dsp.exec_cmd("rofi -show drun"), {})
hl.bind("SUPER + C", hl.dsp.exec_cmd("hyprlock"))
hl.bind("SUPER + T", hl.dsp.exec_cmd("~/.rofi/powerscript"))

-- Group
hl.bind("SUPER + G", hl.dsp.group.toggle(groupgroup))


local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Change the current monitor that is focused
hl.bind(mainMod .. " + COMMA", hl.dsp.focus({ monitor = "eDP-1" }))
-- fill in the other monitor name
-- hl.bind(mainMod .. " + PERIOD", hl.dsp.focus({ monitor = "eDP-1" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Change workspace with o and p
hl.bind(mainMod .. " + P ",   hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + O ",   hl.dsp.focus({ workspace = "e-1" }))




--Change focus through direction
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-----------------------------------
--- Hardware Controls
-----------------------------------

-- Change the brightness
hl.bind(mainMod .. " + SEMICOLON",  hl.dsp.exec_cmd("brightnessctl set +5%"),       { locked = true })
hl.bind(mainMod .. " + SHIFT + SEMICOLON", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true })

-- Volume Control
hl.bind(mainMod .. " + BRACKETRIGHT", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), { locked = true })
hl.bind(mainMod .. " + BRACKETLEFT", hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { locked = true })
hl.bind(mainMod .. " + EQUAL",  hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"),       { locked = true })

-----------------------------------
--- Window Controls
-----------------------------------
hl.bind(mainMod .. " + M", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mainMod .. " + N",  hl.dsp.window.fullscreen({mode = "fullscreen"}))
hl.bind(mainMod .. " + K",  hl.dsp.window.cycle_next())
hl.bind(mainMod .. " + J",  hl.dsp.window.cycle_next({next = false}))


-- Move the window on super left click
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
-- Resize on super right click
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Change focus on monitors
hl.bind(mainMod .. " + CTRL + J",  hl.dsp.focus({ monitor = "-1" }))
hl.bind(mainMod .. " + CTRL + K", hl.dsp.focus({ monitor = "+1" }))

-----------------------------------
--- Scratch Pad
-----------------------------------
-- Example special workspace (scratchpad)
-- Ask Claude about this. The point of it is so that you can
-- have all your frequent apps living over there
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = false, -- If true disables the random hyprland logo / anime girl background. :(
    },
})
