return {
  "mfussenegger/nvim-lint",
  event = "LazyFile",
  opts = {
    linters = {
      ["markdownlint-cli2"] = {
        condition = function(ctx)
          local obsidian_dir = vim.fs.find(
            { ".obsidian" },
            { path = ctx.filename, upward = true, type = "directory", limit = 1 }
          )
          return obsidian_dir == 0
        end,
      },
    },
  },
}
