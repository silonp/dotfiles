local wezterm = require 'wezterm'
local act = wezterm.action

return {
    font = wezterm.font("JetBrainsMono Nerd Font"),
    font_size = 15.0,

    color_scheme = "GruvboxDark",

    window_background_opacity = 0.92,
    macos_window_background_blur = 20,

    hide_tab_bar_if_only_one_tab = true,

    window_padding = {
        left = 12,
        right = 12,
        top = 10,
        bottom = 10,
    },

    window_decorations = "RESIZE",
    adjust_window_size_when_changing_font_size = false,
    animation_fps = 120,
    max_fps = 120,

    native_macos_fullscreen_mode = true,
    window_close_confirmation = "NeverPrompt",

    keys = {
        { key = "Home", mods = "CTRL", action = act.ScrollToTop },
        { key = "End", mods = "CTRL", action = act.ScrollToBottom },
        { key = "Home", mods = "NONE", action = act.SendString("\x1bOH") },
        { key = "End", mods = "NONE", action = act.SendString("\x1bOF") },
        { key = "PageUp", mods = "NONE", action = act.ScrollByPage(-1) },
        { key = "PageDown", mods = "NONE", action = act.ScrollByPage(1) },
    },
}
