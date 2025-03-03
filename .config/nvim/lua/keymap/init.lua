vim.g.mapleader = " "

--[[
This keymap is designed to leverage "folke/which-key.nvim".  Keymaps are organized into logical groupings.

For instance, window related activities are within the <leader>w grouping, 
and find related activities are within the <leader>f grouping.  Which key will aid in navigating the keymap 
and will display the opts.desc within the window.
]]
local keymap = {
-- find
    ["<Leader>ff"] = { value = "<cmd>Telescope find_files<CR>", opts = { desc = "Find files" }, mode = "n" },
    ["<Leader>fg"] = { value = "<cmd>lua require('telescope.builtin').live_grep()<CR>", opts = { desc = "Find grep" }, mode = "n" },
-- window
    ["<Leader>wj"] = { value = "<C-W><C-J>", opts = { silent = true, desc = "Window Down" } },
    ["<Leader>wk"] = { value = "<C-W><C-K>", opts = { silent = true, desc = "Window Up" } },
    ["<Leader>wl"] = { value = "<C-W><C-L>", opts = { silent = true, desc = "Window Right" } },
    ["<Leader>wh"] = { value = "<C-W><C-H>", opts = { silent = true, desc = "Window Left" } },
-- copy
    ["<Leader>xa"] = { value = "ggVG<cmd>w !zsh -ic 'pbcopy'<CR>", opts = { silent = true, desc = "Copy buffer to clipboard" } },
--    ["<Leader>xp"] = { value = ":'<,'> w !pandoc --no-highlight --wrap=none | zsh -ic 'pbcopy'<CR>", opts = { silent = true, desc = "Copy Pandoc format" } },
    ["<Leader>xp"] = { value = "<cmd>let @+ = expand('%:p')<CR>", opts = { silent = true, desc = "Copy file absolute path" }, mode = "n" },
    ["<Leader>xn"] = { value = "<cmd>let @+ = @%<CR>", opts = { silent = true, desc = "Copy file relative path" }, mode = "n" },
-- nav
-- Note, to toggle Neotree - <C-n>
    ["<Leader>bl"] = { value = "<cmd>Neotree buffers reveal float<CR>", opts = { desc = "View Open Buffers" } },
    ["<Leader>bd"] = { value = ":bdelete!<CR>", opts = { desc = "Delete current buffer" },  mode = "n"},
-- terminal
-- Replace using tmux-nav
--    ["<Leader>ts"] = { value = ":split<CR>:terminal<CR>", opts = { desc = "Split Screen Terminal" } },
-- run
    ["<Leader>rl"] = { value = ":.w !bash<CR>", opts = { silent = true, desc = "Run Single Line"}, mode = "n" },
    ["<Leader>rp"] = { value = ":1,.w !bash<CR>", opts = { silent = true, desc = "Run To Position"}, mode = "n" },
    ["<Leader>rb"] = { value = ":w !bash<CR>", opts = { silent = true, desc = "Run Entire Buffer"}, mode = "n" },
}

for i = 1, 4 do
    local key = "<Leader>w" .. i
    local value = i .. "<C-W>w"
    keymap[key] = {
        value = value,
        opts = { desc = "Move to window " .. i },
        mode = "n"
    }
end

for key, map in pairs(keymap) do
    if key and map.value then
        vim.keymap.set(map.mode or 'n', key, map.value, map.opts)
    end
end

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
