-- General LSP Configurations

languageServers = {
    {
        name = 'clangd',
        config = {
            cmd = {
                'clangd',
                '--background-index',
                '--clang-tidy',
                '--header-insertion=iwyu',
                '--completion-style=detailed',
            },
            filetypes = {'c', 'cpp', 'objc', 'objcpp', 'cuda', 'proto'},
            root_markers = {'compile_commands.json', 'compile_flags.txt', 'makefile', '.git'},
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

        -- 'menuone' shows the popup even for 1 match, 'noselect' prevents auto-inserting
        vim.opt.completeopt = { 'menu', 'menuone', 'noselect', 'popup' }

        -- Enable built-in LSP completion
        vim.lsp.completion.enable(true, ev.data.client_id, ev.buf, {
            autotrigger = true,
            convert = function(item)
                return { abbr = item.label:gsub('%b()', '') }
            end,
        })

        ------------------------------------------------------------------
        -- 1. Auto-trigger Native Completion Popup on Keyword Typing
        ------------------------------------------------------------------
        vim.api.nvim_create_autocmd("TextChangedI", {
            buffer = ev.buf,
            callback = function()
                if vim.fn.pumvisible() == 1 then
                    return
                end

                local col = vim.api.nvim_win_get_cursor(0)[2]
                local line = vim.api.nvim_get_current_line()
                local char = line:sub(col, col)

                if char:match("[%w_%.%->:]") then
                    vim.api.nvim_feedkeys(
                        vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true),
                        "n",
                        false
                    )
                end
            end,
        })

        ------------------------------------------------------------------
        -- 2. Tab / Shift-Tab Navigation Keymaps
        ------------------------------------------------------------------
        local opts = { buffer = ev.buf }

        vim.keymap.set("i", "<Tab>", function()
            if vim.fn.pumvisible() == 1 then
                return "<C-n>"
            else
                return "<Tab>"
            end
        end, { expr = true, buffer = ev.buf })

        vim.keymap.set("i", "<S-Tab>", function()
            if vim.fn.pumvisible() == 1 then
                return "<C-p>"
            else
                return "<S-Tab>"
            end
        end, { expr = true, buffer = ev.buf })

        -- LSP Keymaps
        vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
        vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
        vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
    end,
})
