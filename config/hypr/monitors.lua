-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.env("GDK_SCALE", "1")

local dell = "desc:Dell Inc. DELL S2722DC G0GFHD3"
local gigabyte = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. G27Q 21012B008470"

hl.monitor({ output = dell, mode = "2560x1440@74.98", position = "0x0", scale = 1 })
hl.monitor({ output = gigabyte, mode = "2560x1440@143.97", position = "2560x0", scale = 1 })

-- Odd workspaces -> Dell (left), even -> Gigabyte (right)
for i = 1, 10 do
	hl.workspace_rule({ workspace = i, monitor = (i % 2 == 1) and dell or gigabyte })
end
