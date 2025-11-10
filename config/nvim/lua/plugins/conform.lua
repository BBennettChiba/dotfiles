return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  -- keys = {
  --   {
  --     "<leader>f",
  --     function()
  --       require("conform").format({ async = true, lsp_format = "never" })
  --     end,
  --     mode = "",
  --     desc = "[F]ormat buffer",
  --   },
  -- },
  keys = {
    {
      "<leader>cF",
      function()
        require("conform").format({ formatters = { "injected" }, timeout_ms = 3000 })
      end,
      mode = { "n", "x" },
      desc = "Format Injected Langs",
    },
  },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "biome-check" },
      javascriptreact = { "biome-check" },
      typescript = { "biome-check" },
      typescriptreact = { "biome-check" },
      go = { "goimports", "gofmt" },
      rust = { "rustfmt" },
    },
    formatters = {
      biome = {
        command = "biome",
        args = {
          "check",
          "--formatter-enabled=true",
          "--linter-enabled=false",
          "--organize-imports-enabled=true",
          "--write",
          "--stdin-file-path",
          "$FILENAME",
        },
      },
    },
  },
}
