local status_ok, neogen = pcall(require, 'neogen')
if not status_ok then
    print('Plugin not loaded: ', 'neogen')
    return
end
local opts = { noremap = true, silent = true }
---------------------------------------------------- KEYMAPS ------------------------------------------------
vim.api.nvim_set_keymap("n", "<Leader>af", ":lua require('neogen').generate()<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>ac", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>at", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)
vim.api.nvim_set_keymap("n", "<Leader>aF", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)
-------------------------------------------------------------------------------------------------------------
neogen.setup {
    snippet_engine = "luasnip",
    enabled = true,
    languages = {
        cs = {
            template = {
                annotation_convention = "xmldoc"
            }
        },
        python = {
            template = {
                annotation_convention = "numpydoc"
            }
        }
    }
}
