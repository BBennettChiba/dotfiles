-- Mario Theme for Neovim
local mario = {}

mario.normal   = { fg = "#FFD900", bg = "#3B5BA5" } -- yellow on blue
mario.insert   = { fg = "#FFFFFF", bg = "#E52521" } -- white on red
mario.visual   = { fg = "#3B5BA5", bg = "#FFD900" } -- blue on yellow
mario.replace  = { fg = "#FFFFFF", bg = "#7C4700" } -- white on brown
mario.command  = { fg = "#FFFFFF", bg = "#43B047" } -- white on green

mario.comment  = { fg = "#7C4700", bg = "#3B5BA5", italic = true }
mario.string   = { fg = "#43B047" }
mario.keyword  = { fg = "#E52521", bold = true }
mario.function = { fg = "#FFD900" }
mario.variable = { fg = "#FFFFFF" }
mario.constant = { fg = "#FFD900" }
mario.type     = { fg = "#3B5BA5" }
mario.number   = { fg = "#FFD900" }
mario.error    = { fg = "#FFFFFF", bg = "#E52521", bold = true }
mario.warning  = { fg = "#FFD900", bg = "#7C4700", bold = true }
mario.info     = { fg = "#3B5BA5", bg = "#FFD900" }

return mario
