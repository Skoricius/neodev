return {
    {
        "cameron-wags/rainbow_csv.nvim",
        config = function()
            require("rainbow_csv").setup()
        end,
        ft = {
            "csv",
            "tsv",
            "csv_semicolon",
            "csv_whitespace",
            "csv_pipe",
            "rfc_csv",
            "rfc_semicolon",
        },
        cmd = {
            "RainbowDelim",
            "RainbowDelimSimple",
            "RainbowDelimQuoted",
            "RainbowMultiDelim",
        },
        enable = vim.g.vscode == nil,
    },
}
