return {
 "folke/trouble.nvim",
 dependencies = { "nvim-tree/nvim-web-devicons" },
 config = true,
 keys = {
        {"<leader>xx",function() require("trouble").toggle() end}
    }

}
