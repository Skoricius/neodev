
return {
    {
        "ggandor/leap.nvim",
        config = function()
            require('leap').setup({})
            require('leap').add_default_mappings()
        end,
    }
}
