-- Pull in the wezterm API
local wezterm = require("wezterm")

function basename(str)
    local name = string.gsub(str, "(.*/)(.*)", "%2")
    return name
end

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local pane = tab.active_pane

    local index = ""
    if #tabs > 1 then
        index = string.format("%d: ", tab.tab_index + 1)
    end

    return { {
        Text = ' ' .. index .. pane.domain_name .. ' ' .. basename(pane.title) .. ' '
    } }
end)

-- see https://wezfurlong.org/wezterm/config/lua/wezterm/target_triple.html for values
local is_linux = wezterm.target_triple == "x86_64-unknown-linux-gnu"
local is_windows = wezterm.target_triple == "x86_64-pc-windows-msvc"

-- This table will hold the configuration.
local config = {
    hide_tab_bar_if_only_one_tab = false,
    -- term = "xterm-256color",
}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Gruvbox dark, soft (base16)"
config.color_scheme = "Gruvbox Material (Gogh)"
config.window_background_opacity = 1
-- Nightly version of wezterm
-- config.win32_system_backdrop = 'Mica'
-- config.win32_acrylic_accent_color = "Acrylic"

config.window_decorations = "RESIZE"
config.window_frame = {
    font_size = 11.0,
}
config.macos_window_background_blur = 20

config.font = wezterm.font({
    family = "Hack Nerd Font Mono",
    weight = "Regular",
})
config.font_size = 13.0

config.keys = {
    { key = "l", mods = "ALT", action = wezterm.action.ShowLauncher },
}

config.front_end = "WebGpu"

local act = wezterm.action
-- config.mouse_bindings = {
--     -- Change the default click behavior so that it only selects
--     -- text and doesn't open hyperlinks
--     {
--         event = { Up = { streak = 1, button = 'Left' } },
--         mods = 'NONE',
--         action = act.CompleteSelection 'ClipboardAndPrimarySelection',
--     },
--
--     -- and make CTRL-Click open hyperlinks
--     {
--         event = { Up = { streak = 1, button = 'Left' } },
--         mods = 'CTRL',
--         action = act.OpenLinkAtMouseCursor,
--     },
-- }

return config
