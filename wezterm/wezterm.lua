-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.window_decorations = "RESIZE"
config.window_padding = {left = 11, right = 11, top = 11, bottom = 11}
config.window_background_opacity = 0.3
config.adjust_window_size_when_changing_font_size = false

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.colors = {
    foreground = "#ffffff",
    cursor_bg = "#ffffff",
    cursor_border = "#ffffff",
    tab_bar = {
        background = "#1acb01"

    }
}

config.font = wezterm.font("Hasklug Nerd Font Mono")
config.font_size = 11.5
config.line_height = 0.95

config.cursor_thickness = 2
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.unix_domains = {
    {
        name = "unix",
    }
}

config.default_gui_startup_args = {'connect', 'unix'}

return config
