return {
  -- -- Disable LSP diagnostics in markdown
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     setup = {
  --       marksman = function(_, _)
  --         vim.api.nvim_create_autocmd("FileType", {
  --           pattern = "markdown",
  --           callback = function()
  --             vim.diagnostic.disable(0)
  --           end,
  --         })
  --         return true -- still attach if needed (e.g., for hover, completion)
  --       end,
  --     },
  --   },
  -- },

  -- Disable nvim-lint for markdown
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = {}, -- disable all linters
      },
    },
  },

  -- -- Disable formatting on markdown if desired
  -- {
  --   "stevearc/conform.nvim",
  --   opts = {
  --     formatters_by_ft = {
  --       markdown = {}, -- disable formatters
  --     },
  --   },
  -- },
}
