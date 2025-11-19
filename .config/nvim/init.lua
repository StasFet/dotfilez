vim.cmd("set nu")
vim.cmd("set nowrap")
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('lazy').setup({
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
    {"nvim-telescope/telescope.nvim", tag = 'v0.1.9', dependencies = { 'nvim-lua/plenary.nvim' }},
    {"navarasu/onedark.nvim", priority = 1000, 
        config = function()
        require('onedark').setup {style = 'darker'}
            require('onedark').load()
        end
    },
    {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons'} },
    {'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
    {'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },
    {'lewis6991/gitsigns.nvim'},
    {'saghen/blink.cmp', version = '1.8.0' , opts = { 'super-tab' } }
})

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    }, 
    indent = {
        enable = true,
    },
})

require('lualine').setup {
    options = { theme = "auto" }
}
