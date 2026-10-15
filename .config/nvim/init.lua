vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#ffffff", bold = true })
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#ffffff" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ffffff" })
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.number = true
vim.opt.relativenumber = true
local function transparent()
    for _, group in ipairs({
        "Normal",
        "NormalNC",
        "SignColumn",
        "EndOfBuffer",
        "NormalFloat",
        "LineNr",
        "FoldColumn",
    }) do
        vim.api.nvim_set_hl(0, group, { bg = "NONE" })
    end
end

transparent()

vim.api.nvim_create_autocmd("ColorScheme", {
    callback = transparent,
})
vim.pack.add({
  { src = "https://github.com/nvim-mini/mini.completion" },
  { src = "https://github.com/nvim-mini/mini.pairs" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
  { src = "https://github.com/nvim-mini/mini.nvim" },
})
vim.pack.add({
    { src = "https://github.com/folke/tokyonight.nvim" },
})
vim.cmd.colorscheme("tokyonight")
require("nvim-treesitter").install({
    "cpp",
    "c",
    "lua",
    "python",
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "cpp", "c", "lua", "python" },
    callback = function()
        vim.treesitter.start()
    end,
})
require("mini.pairs").setup()
require("gitsigns").setup()
require("mini.statusline").setup()
require("mini.completion").setup()
