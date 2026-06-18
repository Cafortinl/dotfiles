-- General LSP Configurations

languageServers = {
    {
        name = 'clangd',
        config = {
            cmd = {'clangd'},
            filetypes = {'c', 'cpp'},
            root_markers = {'makefile', '.git', 'compile_commands.json'},
            settings = {}
        }
    },
    {
        name = 'pylsp',
        config = {
            cmd = {'pylsp'},
            filetypes = {'python'},
            root_markers = {'setup.py', '.git'},
            settings = {}
        }
    },
    {
        name = 'ts_ls',
        config = {
            cmd = {'typescript-language-server', '--stdio'},
            filetypes = {'javascript', 'typescript', 'html', 'css'},
            root_markers = {'package.json', '.git', 'src/index.html'},
            settings = {}
        }
    },
}

for i, lsp in ipairs(languageServers) do
    vim.lsp.config(lsp.name, lsp.config)
    vim.lsp.enable(lsp.name)
end

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(ev)
        -- Add 'i' (included files) and '.' (current buffer) alongside LSP
        vim.bo[ev.buf].complete = '.,w,b,u,t,i'

        -- noselect prevents auto-selecting the first item, giving you control
        vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }

        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end,
        })

        local opts = { buffer = ev.buf }
        vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    end,
})
