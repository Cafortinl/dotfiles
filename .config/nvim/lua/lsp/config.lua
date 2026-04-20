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
            cmd = {'ts_ls'},
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
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            autotrigger = true,
            convert = function(item)
              return { abbr = item.label:gsub('%b()', '') }
            end,
        })
    end,
})
