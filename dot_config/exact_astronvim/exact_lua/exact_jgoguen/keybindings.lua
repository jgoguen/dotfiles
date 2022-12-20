local bindings = {
  [""] = {
    q = { '<Nop>', { noremap = false } },

    -- Reflow paragraph
    Q = 'gwap',
  },
  c = {
    ["w!!"] = 'w !sudo tee % >/dev/null',
  },
  i = {
    ["<S-Tab>"] = { '<ESC><<a', { silent = false } },
  },
  n = {
    ["<F8>"] = function() require('symbols-outline').toggle_outline() end,

    [";"] = { ":", { silent = false } },

    -- Allow ^ to act like Home in an IDE
    ["^"] = { [[col('.') == match(getline('.'), '\S')+1 ? '0' : '^']], { expr = true } },

    -- Resize splits
    ["<C-Left>"] = '<C-w><',
    ["<C-Right>"] = '<C-w>>',

    ["<C-c>"] = function() require('FTerm').toggle() end,

    -- Keep the cursor in the middle of the screen with <C-d> and <C-u>
    ["<C-d>"] = '<C-d>zz',
    ["<C-u>"] = '<C-u>zz',

    -- Move between tabs
    ["<C-S-Right>"] = ':tabnext<CR>',
    ["<C-S-Left>"] = ':tabprev<CR>',

    -- Move between buffers
    ["<A-PageDown>"] = ':bnext<CR>',
    ["<A-PageUp>"] = ':bprev<CR>',
    -- macOS needs the same mappings with Option
    ["<D-PageDown>"] = ':bnext<CR>',
    ["<D-PageUp>"] = ':bprev<CR>',

    -- Telescope buffers
    ["<Leader>b"] = function() require('telescope.builtin').buffers() end,

    -- Toggle cursorcolumn (useful for aligning text)
    ["<Leader>cl"] = ':<C-U>call utils#ToggleCursorColumn()<CR>',

    -- Delete to the void register
    ["<Leader>d"] = '"_d',

    ["<Leader>f"] = ':Neotree reveal_force_cwd<CR>',
    ["<Leader>fc"] = ':Neotree reveal_force_cwd toggle<CR>',

    -- Move between splits
    ["<Leader>h"] = '<C-w>h',
    ["<Leader>j"] = '<C-w>j',
    ["<Leader>k"] = '<C-w>k',
    ["<Leader>l"] = '<C-w>l',
    -- Location window shortcuts
    ["<Leader>ln"] = ':lnext<CR>zz',
    ["<Leader>lp"] = ':lprevious<CR>zz',
    ["<Leader>lc"] = ':lclose<CR>',

    -- Find merge conflict markers
    ["<Leader>mc"] = '/\\v^[<\\|=>]{7}( .*\\|$)<CR>',

    -- Quickfix window shortcuts
    ["<Leader>qn"] = ':cnext<CR>zz',
    ["<Leader>qp"] = ':cprevious<CR>zz',
    ["<Leader>qc"] = ':cclose<CR>',

    -- Search/replace work under cursor
    ["<Leader>s"] = [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],

    -- Telescope find files
    ["<Leader>t"] = function() require('telescope.builtin').find_files() end,

    -- Select window to jump to
    ["<Leader>w"] = function()
      local has_picker, picker = pcall(require, 'window-picker')
      if has_picker then
        local wid = picker.pick_window() or vim.api.nvim_get_current_win()
        vim.api.nvim_set_current_win(wid)
      end
    end,

    -- Normalize split size
    ["<Leader>="] = '<C-w>=',

    -- Clear search highlights
    ["//"] = ':nohlsearch<CR>',

    -- Allow gf to open files that don't exist
    gf = ':edit <cfile><CR>',

    -- Normal movement between wrapped lines
    k = 'gk',
    ["<up>"] = 'gk',
    j = 'gj',
    ["<down>"] = 'gj',

    J = 'mzJ`z',

    -- Going to the next/previous match will centre the line it's on
    n = 'nzzzv',
    N = 'Nzzzv',
    -- Mark a word as rare
    ["z?"] = ':execute ":spellrare " .',
  },
  t = {
    ["<C-t>"] = '<C-\\><C-n>:lua require("FTerm").toggle()<CR>',
  },
  v = {
    -- Delete to the void register
    ["<Leader>d"] = '"_d',

    -- Reflow selection
    Q = 'gq',

    -- Allow moving selected lines up and down
    J = ":m '>+1<CR>gv=gv",
    K = ":m '<-2<CR>gv=gv",
  },
  x = {
    -- Delete highlighted text and paste over without copying it to the paste
    -- register
    ["<Leader>p"] = '"_dP',
  },
}

local map = function(mode, key, map, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end

  vim.keymap.set(mode, key, map, options)
end

local M = {}

M.setup = function()
  for mode, mapppings in pairs(bindings) do
    for key, value in pairs(mapppings) do
      if type(value) == "table" then
        map(mode, key, value[1], value[2])
      else
        map(mode, key, value)
      end
    end
  end
end

return M
