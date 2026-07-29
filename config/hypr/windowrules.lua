-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

local function anchored(class)
  return "^(" .. class .. ")$"
end

-- Inhibit idle while these are fullscreen (video/media players + browsers)
local idle_inhibit_classes = {
  ".*celluloid.*", ".*mpv.*", ".*vlc.*",
  ".*[Ss]potify.*",
  ".*LibreWolf.*", ".*floorp.*", ".*brave-browser.*", ".*firefox.*",
  ".*chromium.*", ".*zen.*", ".*vivaldi.*",
}
for _, class in ipairs(idle_inhibit_classes) do
  hl.window_rule({ match = { class = anchored(class) }, idle_inhibit = "fullscreen" })
end

-- Picture-in-Picture: float, pin, and dock to the bottom-right corner
hl.window_rule({
  name              = "hyde_picture_in_picture",
  match             = { title = "^([Pp]icture[-\\s]?[Ii]n[-\\s]?[Pp]icture)(.*)$" },
  tag               = "+hyde_picture_in_picture",
  float             = true,
  keep_aspect_ratio = true,
  move              = { "monitor_w*0.73", "monitor_h*0.72" },
  size              = { "monitor_w*0.25", "monitor_h*0.25" },
  pin               = true,
})

-- Apps that should always float
local float_classes = {
  "Signal", "com.github.rafostar.Clapper", "app.drey.Warp",
  "net.davidotek.pupgui2", "yad", "eog", "io.github.alainm23.planify",
  "io.gitlab.theevilskeleton.Upscaler", "com.github.unrud.VideoDownloader",
  "io.gitlab.adhami3310.Impression", "io.missioncenter.MissionCenter",
}
for _, class in ipairs(float_classes) do
  hl.window_rule({ match = { class = anchored(class) }, float = true })
end

-- Workaround for JetBrains IDE dropdowns/popups causing flickering
hl.window_rule({
  match            = { class = "^(.*jetbrains.*)$", title = "^(win[0-9]+)$" },
  no_initial_focus = true,
})

-- Blur + ignore alpha for these layer surfaces
local blurred_layers = {
  "rofi", "notifications", "swaync-notification-window", "swaync-control-center",
}
for _, namespace in ipairs(blurred_layers) do
  hl.layer_rule({ match = { namespace = namespace }, blur = true, ignore_alpha = 0 })
end
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })

-- Workspace 1 is ghostty-only: ghostty always opens there, everything else is barred
hl.window_rule({ match = { class = anchored("com.mitchellh.ghostty") }, workspace = "1 silent" })
hl.window_rule({
  match     = { workspace = "1", class = "negative:^com\\.mitchellh\\.ghostty$" },
  workspace = "2 silent",
})
