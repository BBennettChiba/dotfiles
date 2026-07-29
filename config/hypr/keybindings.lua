-- Personal keybinds. HyDE's own key_binds.lua (loaded first, from hyde.lua)
-- already provides sane defaults for close/float/fullscreen/explorer/etc and
-- the rofi menus, media keys, brightness, screenshots, and theme selectors --
-- those are NOT repeated here. This file only adds/overrides what's actually
-- personal: apps, resize/move keys on a different layout than HyDE's default,
-- workspace navigation, monitor-specific wallpaper/waybar cycling, and music.

local MOD = hyde.config.modifiers.main
local HOME = os.getenv("HOME")

local TERMINAL = "ghostty"
local terminal  = "uwsm-app -- " .. TERMINAL
local EDITOR    = "nvim"
local EXPLORER  = "yazi"
local BROWSER   = "brave"

-- Apps
hl.bind(MOD .. " + RETURN", hl.dsp.exec_cmd(terminal), { description = "[Launcher|Apps] terminal emulator" })
hl.bind("CTRL + SHIFT + T", hl.dsp.exec_cmd(terminal), { description = "[Launcher|Apps] terminal emulator" })
hl.bind(MOD .. " + C", hl.dsp.exec_cmd(TERMINAL .. " -e " .. EDITOR), { description = "[Launcher|Apps] text editor" })
hl.bind(MOD .. " + B", hl.dsp.exec_cmd(BROWSER), { description = "[Launcher|Apps] web browser" })
hl.bind(MOD .. " + SHIFT + B", hl.dsp.exec_cmd(BROWSER .. " --incognito"), { description = "[Launcher|Apps] web browser private" })
hl.bind(MOD .. " + D", hl.dsp.exec_cmd('omarchy-launch-or-focus discord "gtk-launch discord.desktop"'), { description = "[Launcher|Apps] Discord" })
hl.bind(MOD .. " + O", hl.dsp.exec_cmd('omarchy-launch-or-focus obsidian "uwsm app -- obsidian -disable-gpu --enable-wayland-ime"'), { description = "[Launcher|Apps] Obsidian" })
hl.bind(MOD .. " + SLASH", hl.dsp.exec_cmd(HOME .. "/bin/passmenu"), { description = "[Launcher|Apps] Passwords" })
hl.bind(MOD .. " + G", hl.dsp.exec_cmd(TERMINAL .. ' -e gemini -m "gemini-flash-2.5"'), { description = "[Launcher|Apps] Gemini CLI" })
hl.bind(MOD .. " + Y", hl.dsp.exec_cmd('omarchy-launch-or-focus-webapp YouTube "https://youtube.com/"'), { description = "[Launcher|Apps] YouTube" })
hl.bind(MOD .. " + S", hl.dsp.exec_cmd('menu "Search"'), { description = "[Launcher] Search" })
hl.bind(MOD .. " + SPACE", hl.dsp.exec_cmd(HOME .. "/bin/menu"), { description = "[Launcher] Bryson menu" })

-- Window Management (kept distinct from HyDE defaults where this diverges)
-- NOTE: hyde-shell's "dontkillsteam" and "windowpin" scripts still use the
-- old pre-lua hyprctl dispatch string syntax (hl.dispatch(killactive) /
-- hl.dispatch(togglefloating active)), which errors under the new lua
-- dispatcher API -- confirmed via `hyde-shell dontkillsteam` on the CLI.
-- Bound directly to the real dispatchers until HyDE migrates those scripts.
hl.bind(MOD .. " + Q", hl.dsp.window.close(), { description = "[Window Management] close focused window" })
hl.bind("ALT + F4", hl.dsp.window.close(), { description = "[Window Management] close focused window" })
hl.bind(MOD .. " + SHIFT + I", hl.dsp.window.pin({ action = "toggle" }), { description = "[Window Management] toggle pin on focused window" })

-- Resize Active Window
hl.bind(MOD .. " + ALT + L", hl.dsp.window.resize({ x = 30, y = 0, relative = true }), { description = "[Window Management|Resize] resize window right", repeating = true })
hl.bind(MOD .. " + ALT + H", hl.dsp.window.resize({ x = -30, y = 0, relative = true }), { description = "[Window Management|Resize] resize window left", repeating = true })
hl.bind(MOD .. " + ALT + K", hl.dsp.window.resize({ x = 0, y = -30, relative = true }), { description = "[Window Management|Resize] resize window up", repeating = true })
hl.bind(MOD .. " + ALT + J", hl.dsp.window.resize({ x = 0, y = 30, relative = true }), { description = "[Window Management|Resize] resize window down", repeating = true })

-- Focus (vim-style)
hl.bind(MOD .. " + H", hl.dsp.focus({ direction = "left" }), { description = "[Window Management|Change focus] focus left" })
hl.bind(MOD .. " + L", hl.dsp.focus({ direction = "right" }), { description = "[Window Management|Change focus] focus right" })
hl.bind(MOD .. " + K", hl.dsp.focus({ direction = "up" }), { description = "[Window Management|Change focus] focus up" })
hl.bind(MOD .. " + J", hl.dsp.focus({ direction = "down" }), { description = "[Window Management|Change focus] focus down" })
hl.bind("ALT + TAB", hl.dsp.focus({ urgent_or_last = true }), { description = "[Window Management|Change focus] focus urgent/last" })

-- Group Navigation
hl.bind(MOD .. " + CTRL + H", hl.dsp.group.prev(), { description = "[Window Management|Group Navigation] change active group backwards" })
hl.bind(MOD .. " + CTRL + L", hl.dsp.group.next(), { description = "[Window Management|Group Navigation] change active group forwards" })

-- Move active window across workspaces
hl.bind(MOD .. " + SHIFT + CTRL + LEFT", hl.dsp.window.move({ direction = "l" }), { description = "[Window Management|Move window] left", repeating = true })
hl.bind(MOD .. " + SHIFT + CTRL + RIGHT", hl.dsp.window.move({ direction = "r" }), { description = "[Window Management|Move window] right", repeating = true })
hl.bind(MOD .. " + SHIFT + CTRL + UP", hl.dsp.window.move({ direction = "u" }), { description = "[Window Management|Move window] up", repeating = true })
hl.bind(MOD .. " + SHIFT + CTRL + DOWN", hl.dsp.window.move({ direction = "d" }), { description = "[Window Management|Move window] down", repeating = true })

-- Move/Resize with mouse
hl.bind(MOD .. " + mouse:272", hl.dsp.window.drag(), { description = "[Window Management|Mouse] hold to move window", mouse = true })
hl.bind(MOD .. " + mouse:273", hl.dsp.window.resize(), { description = "[Window Management|Mouse] hold to resize window", mouse = true })
hl.bind(MOD .. " + Z", hl.dsp.window.drag(), { description = "[Window Management|Mouse] hold to move window", mouse = true })
hl.bind(MOD .. " + X", hl.dsp.window.resize(), { description = "[Window Management|Mouse] hold to resize window", mouse = true })

-- Utilities
hl.bind(MOD .. " + ALT + G", hl.dsp.exec_cmd("hyde-shell gamemode"), { description = "[Utilities] game mode" })
hl.bind(MOD .. " + SHIFT + G", hl.dsp.exec_cmd("hyde-shell gamelauncher"), { description = "[Utilities] game launcher" })

-- Theming and Wallpaper (kept as your personal binds -- HyDE defaults use different keys)
hl.bind(MOD .. " + SHIFT + Y", hl.dsp.exec_cmd("hyde-shell animations --select"), { description = "[Theming] select animations" })
hl.bind(MOD .. " + SHIFT + U", hl.dsp.exec_cmd("hyde-shell hyprlock --select"), { description = "[Theming] select hyprlock layout" })

-- Workspaces
for i = 1, 9 do
  hl.bind(MOD .. " + " .. i, hl.dsp.focus({ workspace = i }), { description = "[Workspaces] navigate to workspace " .. i })
  hl.bind(MOD .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }), { description = "[Workspaces] move to workspace " .. i })
end
hl.bind(MOD .. " + 0", hl.dsp.focus({ workspace = 10 }), { description = "[Workspaces] navigate to workspace 10" })
hl.bind(MOD .. " + SHIFT + 0", hl.dsp.window.move({ workspace = 10 }), { description = "[Workspaces] move to workspace 10" })

hl.bind(MOD .. " + CTRL + Right", hl.dsp.focus({ workspace = "r+1" }), { description = "[Workspaces] next workspace" })
hl.bind(MOD .. " + CTRL + Left", hl.dsp.focus({ workspace = "r-1" }), { description = "[Workspaces] previous workspace" })
hl.bind(MOD .. " + CTRL + Down", hl.dsp.focus({ workspace = "empty" }), { description = "[Workspaces] nearest empty workspace" })
hl.bind(MOD .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }), { description = "[Workspaces] scroll next workspace" })
hl.bind(MOD .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }), { description = "[Workspaces] scroll previous workspace" })

-- Music (rmpc)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("rmpc next"), { description = "[Music] skip to next song" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("rmpc togglepause"), { description = "[Music] toggle play pause" })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("rmpc prev"), { description = "[Music] play previous song" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { description = "[Music] pause media" })
