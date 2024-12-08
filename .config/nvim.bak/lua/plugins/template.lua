return {
  "tibabit/vim-templates",

  config = function()
    vim.g.templates = {
      cpp = {
        main = [[
#include <iostream>
#include <vector>
#include <string>


int main()
{


    return 0;
}
        ]],
      },
    }
  end,
}
