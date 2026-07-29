-- Hyprland Nvidia Configuration. See https://wiki.hypr.land/Nvidia/

hl.env("LIBVA_DRIVER_NAME", "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia") -- disable if screensharing breaks
hl.env("GBM_BACKEND", "nvidia-drm") -- remove if Firefox crashes

hl.config({
  cursor = {
    no_hardware_cursors = true, -- avoid hitches; pair with cursor.allow_dumb_copy if disabled
  },
})
