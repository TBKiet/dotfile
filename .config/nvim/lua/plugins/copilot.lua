return {
  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   build = ":Copilot auth",
  --   opts = {
  --     panel = {
  --       auto_refresh = false,
  --       keymap = {
  --         accept = "<CR>",
  --         jump_prev = "[[",
  --         jump_next = "]]",
  --         refresh = "gr",
  --         open = "<M-CR>",
  --       },
  --     },
  --     suggestion = {
  --       auto_trigger = true,
  --       keymap = {
  --         accept = "<C-l>",
  --         prev = "<M-[>",
  --         next = "<M-]>",
  --         dismiss = "<C-]>",
  --       },
  --     },
  --   },
  -- },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    opts = {
      suggestion = {
        auto_trigger = false,
        enabled = false,
        keymap = {
          accept = "<C-l>",
        },
      },
      panel = {
        position = "left",
        ratio = 1,
        enabled = true,
      },
      filetypes = {
        markdown = true,
        help = true,
      },
    },
  },

  {
    "zbirenbaum/copilot-cmp",
    dependencies = "copilot.lua",
    opts = {},
    config = function(_, opts)
      local copilot_cmp = require("copilot_cmp")
      copilot_cmp.setup(opts)
      -- attach cmp source whenever copilot attaches
      -- fixes lazy-loading issues with the copilot cmp source
      LazyVim.lsp.on_attach(function(client)
        if client.name == "copilot" then
          copilot_cmp._on_insert_enter({})
        end
      end)
    end,
  },
  {
    {
      "nvim-cmp",
      dependencies = {
        {
          "zbirenbaum/copilot-cmp",
          dependencies = "copilot.lua",
          opts = {},
          config = function(_, opts)
            local copilot_cmp = require("copilot_cmp")
            copilot_cmp.setup(opts)
            -- attach cmp source whenever copilot attaches
            -- fixes lazy-loading issues with the copilot cmp source
            LazyVim.lsp.on_attach(function(client)
              if client.name == "copilot" then
                copilot_cmp._on_insert_enter({})
              end
            end)
          end,
        },
      },
      ---@param opts cmp.ConfigSchema
      opts = function(_, opts)
        table.insert(opts.sources, 1, {
          name = "copilot",
          group_index = 1,
          priority = 100,
        })
      end,
    },
  },
}
