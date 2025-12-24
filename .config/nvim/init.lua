vim.cmd("set nu rnu")
vim.cmd("set nowrap")
vim.cmd("set termguicolors")
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.clipboard = "unnamedplus"

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
    -- themes
    {"tiagovla/tokyodark.nvim", opts = { transparent_background = true}},
    {"catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
    -- functionality
    {"nvim-treesitter/nvim-treesitter", branch = 'master', lazy = false, build = ":TSUpdate"},
    {"nvim-telescope/telescope.nvim", tag = 'v0.1.9', dependencies = { 'nvim-lua/plenary.nvim' },
        config = function ()
           require("telescope").setup({
                pickers = { find_files = { hidden = true }},
                defaults = {
                    file_ignore_patterns = {},
                    hidden = true,
                    no_ignore = true,
                }
            })
        end
    },
    {'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons'} },
    {'windwp/nvim-autopairs', event = "InsertEnter", opts = {} },
    {'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {} },
    {'lewis6991/gitsigns.nvim'},
    {'saghen/blink.cmp', version = '1.8.0' ,
        opts = {
            keymap = {
                preset = 'super-tab'
            },
            completion = {
                menu = {
                    border = 'rounded'
                },
                ghost_test = {
                    enabled = true
                }
            }
        }
    },
    {'nvim-tree/nvim-tree.lua', dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
            require("nvim-tree").setup({
                view = {
                    side = "right",
                    width = 30,
                    adaptive_size = false,
                },
                filters = {
                    dotfiles = false,
                    git_ignored = false,
                }
            })
        end,
    },
    require('plugins/lsp'),
    require('plugins/noice'),
    {"rachartier/tiny-inline-diagnostic.nvim", event = "VeryLazy", priority = 1000, opts = {} ,
        config = function ()
           require("tiny-inline-diagnostic").setup({
                transparent_bg = true,
                preset = "ghost",
                options = {
                    multilines = { enabled = true },
                }
            })
        end
    },
    {'MeanderingProgrammer/render-markdown.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons'}, opts = {} },
    {"michaelrommel/nvim-silicon", lazy = true, cmd = "Silicon", main = "nvim-silicon", opts = {
        line_offset = function (args)
           return args.line1
        end,
    }},
    {'folke/which-key.nvim', event = "VeryLazy", opts = {},
        init = function ()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end
    },
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
})

require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
    ensure_installed = {
        "go",
        "lua",
        "vim",
    }
})

require('lualine').setup {
    options = { theme = "auto" }
}

-- TODO: make these into which-key thingos
local builtin_telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin_telescope.find_files, { desc = 'Telescope find files'})
vim.keymap.set('n', '<leader>fg', builtin_telescope.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = 'Toggle nvim-tree', noremap = true, silent = true })

local wk = require("which-key")
wk.add(
    {
        mode = { "v" },
        { "<leader>s", group = "Silicon"},
        { "<leader>sc", function() require("nvim-silicon").clip() end, desc = "Copy code screenshot to clipboard"},
    }
)

vim.cmd("NvimTreeOpen")
vim.cmd("colorscheme tokyodark")
