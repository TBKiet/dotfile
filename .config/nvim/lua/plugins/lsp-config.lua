return {
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "ktlint" } },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "kotlin" } },
  },
}
