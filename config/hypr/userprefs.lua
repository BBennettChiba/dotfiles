-- Personal Hyprland configuration.

local HOME = os.getenv("HOME")
hl.env("PATH", (os.getenv("PATH") or "") .. ":" .. HOME .. "/bin:" .. HOME .. "/.local/share/omarchy/bin")

-- hyprsunset is already started by HyDE's own start_up.lua; don't duplicate it here.
hl.on("hyprland.start", function()
  hl.exec_cmd("kdeconnect-indicator")
end)

hl.config({
  input = {
    kb_layout = "us",
    touchpad = {
      natural_scroll = false,
    },
  },
  general = {
    gaps_in = 1,
    gaps_out = 1,
    border_size = 2,
    allow_tearing = true,
  },
  decoration = {
    active_opacity = 1,
    inactive_opacity = 1,
  },
  animations = {
    enabled = true,
  },
})

hl.workspace_rule({ workspace = "w[tv1]", gaps_in = 0, gaps_out = 0 })
hl.workspace_rule({ workspace = "f[1]", gaps_in = 0, gaps_out = 0 })

hl.window_rule({
  name = "windowrule-1",
  match = { float = false, workspace = "w[tv1]" },
  border_size = 0,
  rounding = 0,
})
hl.window_rule({
  name = "windowrule-2",
  match = { float = false, workspace = "f[1]" },
  border_size = 0,
  rounding = 0,
})
