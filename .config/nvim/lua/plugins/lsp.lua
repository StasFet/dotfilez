return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            {
                "folke/lazydev.nvim",
                ft = "lua", -- only load on lua files
                opts = {
                    library = {
                        -- See the configuration section for more details
                        -- Load luvit types when the `vim.uv` word is found
                        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                    },
                },
            },
        },
        config = function()
            vim.api.nvim_create_autocmd('LspAttach', {
                callback = function(args)
                    local bufnr = args.buf
                    local opts = { buffer = bufnr, silent = true }
                    
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                end,
            })

            vim.lsp.enable("lua_ls")
            vim.lsp.enable("gopls")
            vim.lsp.enable("pylsp")
            vim.lsp.enable("docker_language_server")
            vim.lsp.enable("docker_compose_language_service")
            vim.lsp.enable("rust_analyzer")
            vim.lsp.enable("ts_ls")
            vim.lsp.enable("html")
            vim.lsp.enable("tailwindcss")
            vim.lsp.enable("emmet_language_server")
        end,
        opts = { diagnostics = { virtual_text = false } },
    }
}
-- required (AUR) - lua-language-server, gopls, python-language-server
