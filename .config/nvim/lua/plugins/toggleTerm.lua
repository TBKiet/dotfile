--return {
--  {
--    "akinsho/toggleterm.nvim",
--    cmd = "ToggleTerm",
--    build = ":ToggleTerm",
--    keys = { { "<C-,>", "<cmd>ToggleTerm<cr>", desc = "Toggle floating terminal" } },
--    opts = {
--      open_mapping = [[<C-,>]],
--      direction = "horizontal",
--      shade_filetypes = {},
--      hide_numbers = true,
--      insert_mappings = true,
--      terminal_mappings = true,
--      start_in_insert = true,
--      close_on_exit = true,
--    },
--  },
--}

return -- Toggle terminal configuration
{
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<C-t>]], -- Use Ctrl + t to toggle the terminal
    })
  end,
}
