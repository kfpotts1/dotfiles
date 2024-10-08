--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================
========                                    .-----.          ========
========         .----------------------.   | === |          ========
========         |.-""""""""""""""""""-.|   |-----|          ========
========         ||                    ||   | === |          ========
========         ||   KICKSTART.NVIM   ||   |-----|          ========
========         ||                    ||   | === |          ========
========         ||                    ||   |-----|          ========
========         ||:Tutor              ||   |:::::|          ========
========         |'-..................-'|   |____o|          ========
========         `"")----------------(""`   ___________      ========
========        /::::::::::|  |::::::::::\  \ no mouse \     ========
========       /:::========|  |==hjkl==:::\  \ required \    ========
========      '""""""""""""'  '""""""""""""'  '""""""""""'   ========
========                                                     ========
=====================================================================
=====================================================================

What is Kickstart?

  Kickstart.nvim is *not* a distribution.

  Kickstart.nvim is a starting point for your own configuration.
    The goal is that you can read every line of code, top-to-bottom, understand
    what your configuration is doing, and modify it to suit your needs.

    Once you've done that, you can start exploring, configuring and tinkering to
    make Neovim your own! That might mean leaving Kickstart just the way it is for a while
    or immediately breaking it into modular pieces. It's up to you!

    If you don't know anything about Lua, I recommend taking some time to read through
    a guide. One possible example which will only take 10-15 minutes:
      - https://learnxinyminutes.com/docs/lua/

    After understanding a bit more about Lua, you can use `:help lua-guide` as a
    reference for how Neovim integrates Lua.
    - :help lua-guide
    - (or HTML version): https://neovim.io/doc/user/lua-guide.html

Kickstart Guide:

  TODO: The very first thing you should do is to run the command `:Tutor` in Neovim.

    If you don't know what this means, type the following:
      - <escape key>
      - :
      - Tutor
      - <enter key>

    (If you already know the Neovim basics, you can skip this step.)

  Once you've completed that, you can continue working through **AND READING** the rest
  of the kickstart init.lua.

  Next, run AND READ `:help`.
    This will open up a help window with some basic information
    about reading, navigating and searching the builtin help documentation.

    This should be the first place you go to look when you're stuck or confused
    with something. It's one of my favorite Neovim features.

    MOST IMPORTANTLY, we provide a keymap "<space>sh" to [s]earch the [h]elp documentation,
    which is very useful when you're not exactly sure of what you're looking for.

  I have left several `:help X` comments throughout the init.lua
    These are hints about where to find more information about the relevant settings,
    plugins or Neovim features used in Kickstart.

   NOTE: Look for lines like this

    Throughout the file. These are for you, the reader, to help you understand what is happening.
    Feel free to delete them once you know what you're doing, but they should serve as a guide
    for when you are first encountering a few different constructs in your Neovim config.

If you experience any errors while trying to install kickstart, run `:checkhealth` for more info.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now! :)
--]]

-- set python:
vim.g.python3_host_prog = '~/miniconda3/bin/python'

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Automatically read files when changed outside of Neovim
vim.opt.autoread = true
vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'CursorHoldI', 'FocusGained' }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { '*' },
})

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true
-- Add a vertical line at 80 characters to show long lines.
vim.opt.colorcolumn = '80'

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- keymap to save the current buffer
vim.keymap.set('n', '<leader>w', '<cmd>:w<CR>', { desc = '[W]rite the current buffer' })

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>e[', vim.diagnostic.goto_prev, { desc = '[E]rror: previous diagnostic message' })
vim.keymap.set('n', '<leader>e]', vim.diagnostic.goto_next, { desc = '[E]rror: to next diagnostic message' })
vim.keymap.set('n', '<leader>ee', vim.diagnostic.open_float, { desc = '[E]rror: show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>eq', vim.diagnostic.setloclist, { desc = '[E]rror: Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Source the init.lua file
vim.keymap.set('n', '<leader>ns', '<cmd>:luafile ~/.config/nvim/init.lua<CR>', { desc = '[N]vim [S]ource', noremap = true, silent = true })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Window management keybinds
-- Keybinds to split windows easily
vim.keymap.set('n', '<leader>pv', '<cmd>:vsplit<CR>', { desc = '[P]anes: Split window [V]ertically' })
vim.keymap.set('n', '<leader>ph', '<cmd>:split<CR>', { desc = '[P]anes: Split window [H]orizontally' })
-- Close the current window
vim.keymap.set('n', '<leader>pX', '<cmd>:close<CR>', { desc = '[P]anes: [X] Close current window' })
-- Close the file in the current window, keep the window open, return to previous file in window.
vim.keymap.set('n', '<leader>px', '<cmd>:br<CR>', { desc = '[P]anes: Close file in current window' })
-- Close the current buffer and window
vim.keymap.set('n', '<leader>pD', '<cmd>:bdelete<CR>', { desc = '[P]anes: [D]elete current buffer' })
-- Close the buffer, but keep window open (show next buffer in window)
vim.keymap.set('n', '<leader>pd', '<cmd>:bnext<bar>:bdelete #<CR>', { desc = '[P]anes: [D]elete current buffer' })
-- Close all windows except the current one
vim.keymap.set('n', '<leader>po', '<cmd>:only<CR>', { desc = '[P]anes: Close [o]ther windows' })
-- Close all buffers except the current one
-- vim.keymap.set('n', '<leader>pO', '<cmd>:bufdo if bufnr("%") != bufnr("#") | bdelete | endif<CR>', { desc = '[P]anes: Close [O]ther buffers' })
vim.keymap.set(
  'n',
  '<leader>pO',
  ':let current_bufnr = bufnr("%")<bar>:bufdo bdelete<bar>:execute "buffer" current_bufnr<CR>',
  { noremap = true, silent = true, desc = '[P]anes: Close [O]ther buffers' }
)

-- Open a new empty buffer in a new pane.
vim.keymap.set('n', '<leader>pe', '<cmd>:vnew<CR>', { desc = '[P]anes: [E]mpty new buffer' })
-- Open a file by path in a new pane.
-- vim.keymap.set('n', '<leader>pf', '<cmd>:vsp<CR>:edit ', { desc = '[P]anes: [F]ile in new pane' })
-- same, but preload file path from system clipboard
vim.keymap.set('n', '<leader>pf', '<cmd>:vsp<CR>:edit <C-r>*', { desc = '[P]anes: [F]ile in new pane' })

-- close all buffers except those that are currently open in a window.
-- NOTE: There may be multiple windows open - we want to keep any buffer that is open in a window.
vim.keymap.set('n', '<leader>pB', function()
  local windows = vim.api.nvim_list_wins()
  local buffers_to_keep = {}

  -- Add all buffers that are open in a window to the buffers_to_keep table
  for _, window in ipairs(windows) do
    local bufnr = vim.api.nvim_win_get_buf(window)
    buffers_to_keep[bufnr] = true
  end

  -- Get a list of all buffers
  local all_buffers = vim.api.nvim_list_bufs()

  local buffers_closed = 0

  -- Delete all buffers that are not in the buffers_to_keep table
  for _, bufnr in ipairs(all_buffers) do
    if not buffers_to_keep[bufnr] and vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_command('bdelete ' .. bufnr)
      buffers_closed = buffers_closed + 1
    end
  end
  vim.notify('Closed ' .. buffers_closed .. ' buffers.', vim.log.levels.INFO)
end, { desc = '[P]anes: Close inactive [B]uffers' })

------- Floax integration -------
function openInFloax(command, run)
  -- Extract current tmux session and window dynamically

  -- Command to open floax
  local open_floax_command = 'tmux run-shell /home/kenny/.tmux/plugins/tmux-floax/scripts/floax.sh'
  -- TODO: kenny: paste command into floax window and optionally run it (return/enter)
  os.execute(open_floax_command)
  -- Get the active window in the 'scratch' session
  local handle = io.popen 'tmux display-message -p -F "#{window_index}" -t scratch'
  local active_window = handle:read('*a'):gsub('%s+', '') -- Remove any extra newlines/spaces
  handle:close()

  -- NOTE: this is still a work in progress - still lots to work out.
  if active_window ~= '' then
    -- Define the sequence of keys for ble.sh Vim mode
    local keys = 'C-[ d d i ' .. command
    -- local keys = 'C-[ ; send-keys d ; send-keys d ; send-keys i ; send-keys "' .. command .. '"'
    -- local keys = 'Escape dd i' .. command
    if run then
      -- keys = keys .. ' Enter'
      keys = keys .. ' ; send-keys Enter'
    end

    -- Send the key sequence to the active window
    local send_keys_command = 'tmux send-keys -t scratch:' .. active_window .. ' "' .. keys .. '"'
    os.execute(send_keys_command)

    if run then
      vim.notify('Running command in floax window: ' .. command, vim.log.levels.INFO)
    else
      vim.notify('Opening command in floax window: ' .. command, vim.log.levels.INFO)
    end
  else
    vim.notify('Could not determine active window in floax session.', vim.log.levels.ERROR)
  end
end

vim.keymap.set('n', '<leader>pf', function()
  openInFloax('echo hello', false)
end, { desc = '[P]anes: [F]ile in new floax pane' })

vim.keymap.set('n', '<leader>pf', function()
  openInFloax('echo hello', false)
end, { desc = '[P]anes: [F]ile in new floax pane' })

-- Resize windows
-- NOTE: Not namespaced with <leader> so that they can be used quickly.
vim.keymap.set('n', '<C-S-Up>', '<cmd>:resize +2<CR>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-S-Down>', '<cmd>:resize -2<CR>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-S-Right>', '<cmd>:vertical resize +2<CR>', { desc = 'Increase window width' })
vim.keymap.set('n', '<C-S-Left>', '<cmd>:vertical resize -2<CR>', { desc = 'Decrease window width' })
-- vim.keymap.set('n', '<M-k>', '<cmd>:resize +2<CR>', { desc = 'Increase window height' })
-- vim.keymap.set('n', '<M-j>', '<cmd>:resize -2<CR>', { desc = 'Decrease window height' })
-- vim.keymap.set('n', '<M-l>', '<cmd>:vertical resize +2<CR>', { desc = 'Increase window width' })
-- vim.keymap.set('n', '<M-h>', '<cmd>:vertical resize -2<CR>', { desc = 'Decrease window width' })
-- Resize all windows evenly.
vim.keymap.set('n', '<leader>p=', '<cmd>:wincmd =<CR>', { desc = '[P]anes: [=] Equalize window sizes' })
-- Copy the path of the current file.
vim.keymap.set('n', '<leader>pc', "<cmd>let @+ = expand('%')<CR>", { desc = '[P]anes: [C]opy the path of the current file' })

-- Configure window buffer swap.
-- This allows you to swap the buffers in two windows.
-- NOTE: requires keymap press on both windows consecutively, with 10s timeout.
_G.swap_state = { win_id = nil, bufnr = nil, view = nil, pending = false }

function _G.swap_buffers()
  local current_win_id = vim.api.nvim_get_current_win()
  local current_bufnr = vim.api.nvim_get_current_buf()
  local current_view = vim.fn.winsaveview()
  local nil_swap_state = { win_id = nil, bufnr = nil, view = nil, pending = false }
  if _G.swap_state.pending then
    -- Swap the buffers between the windows
    vim.api.nvim_win_set_buf(_G.swap_state.win_id, current_bufnr)
    vim.api.nvim_win_set_buf(current_win_id, _G.swap_state.bufnr)
    -- Swap the views
    vim.fn.winrestview(_G.swap_state.view)
    vim.api.nvim_set_current_win(_G.swap_state.win_id)
    vim.fn.winrestview(current_view)
    vim.api.nvim_set_current_win(current_win_id)
    vim.notify('Swapped buffers between windows ' .. _G.swap_state.win_id .. ' and ' .. current_win_id, vim.log.levels.INFO)
    -- Clear the swap state
    _G.swap_state = nil_swap_state
  else
    -- Start a new swap
    _G.swap_state = { win_id = current_win_id, bufnr = current_bufnr, view = current_view, pending = true }
    vim.notify('Selected window ' .. current_win_id .. ', buffer ' .. current_bufnr .. ' for swap.', vim.log.levels.INFO)
    -- Set a timer to clear the swap state after 10 seconds
    vim.defer_fn(function()
      if _G.swap_state.pending then
        _G.swap_state = nil_swap_state
        vim.notify('Buffer swap timed out', vim.log.levels.WARN)
      end
    end, 10000)
  end
end

vim.api.nvim_set_keymap('n', '<leader>ps', ':lua _G.swap_buffers()<CR>', { desc = '[P]anes: [S]wap windows', noremap = true, silent = true })
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Yank through remote clipboard - requires `osc52.nvim`
-- Works with tmux and other terminal multiplexers.
-- NOTE: not using this for not, instead using as clipboard provider below,
-- which seems to work much better for my needs.
--
-- vim.api.nvim_create_autocmd('TextYankPost', {
--   desc = 'Yank through remote clipboard',
--   callback = function()
--     if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
--       require('osc52').copy_register '+'
--     end
--   end,
-- })
-- NOTE: switched to newer version of tmux. Now can use the tmux.nvim plugin.
--
-- Use osc52 as the clipboard provider
-- local function copy(lines, _)
--   require('osc52').copy(table.concat(lines, '\n'))
-- end
--
-- local function paste()
--   return { vim.fn.split(vim.fn.getreg '', '\n'), vim.fn.getregtype '' }
-- end
--
-- vim.g.clipboard = {
--   name = 'osc52',
--   copy = { ['+'] = copy, ['*'] = copy },
--   paste = { ['+'] = paste, ['*'] = paste },
-- }

-- NOTE: Override vim-sleuth's indent detection for cpp .h files
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Override vim-sleuth indent detection for cpp .h files',
  pattern = 'cpp',
  callback = function()
    if vim.fn.expand '%:e' == 'h' then
      vim.b.sleuth_automatic = false
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 1
      vim.opt.tabstop = 1
    end
    -- also override for .cc files to use 2 spaces by default.
    if vim.fn.expand '%:e' == 'cc' then
      vim.b.sleuth_automatic = false
      vim.opt.expandtab = true
      vim.opt.shiftwidth = 2
      vim.opt.tabstop = 2
    end
  end,
})

-- Noice's standard configuration makes it so we can't see when a visual
-- indication that a macro is being recorded. So we'll create a custom
-- autocommand to show a message when recording a macro.
local function notify_macro_recording(is_leaving)
  local recording = vim.fn.reg_recording()
  if recording ~= '' then
    if is_leaving then
      -- Delay the notification by 0ms to ensure the macro is saved first
      -- Otherwise we'll actually see the previous recorded macro
      -- in the notification text.
      vim.defer_fn(function()
        local macro = vim.fn.getreg(recording)
        vim.notify('Macro @' .. recording .. ': ' .. macro, vim.log.levels.INFO)
      end, 0)
    else
      vim.notify('Started recording macro @' .. recording, vim.log.levels.INFO)
    end
  end
end

-- Add autocommands for macro notifications.
vim.api.nvim_create_autocmd('RecordingEnter', {
  callback = function()
    notify_macro_recording(false)
  end,
})
vim.api.nvim_create_autocmd('RecordingLeave', {
  callback = function()
    notify_macro_recording(true)
  end,
})

vim.g.copilot_history_dir = vim.fn.stdpath 'data' .. '/copilotchat_history'

-- [[ Install `lazy.nvim` plugin manager ]]
--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
--
--  To check the current status of your plugins, run
--    :Lazy
--
--  You can press `?` in this menu for help. Use `:q` to close the window
--
--  To update plugins you can run
--    :Lazy update
--
-- NOTE: Here is where you install your plugins.
require('lazy').setup({
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  --
  --  This is equivalent to:
  --    require('Comment').setup({})

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },
  -- TODO: kenny - setup image rendering with image.nvim
  -- https://github.com/3rd/image.nvim
  --
  -- leetcode plugin.
  {
    'kawre/leetcode.nvim',
    build = ':TSUpdate html',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim', -- required by telescope
      'MunifTanjim/nui.nvim',

      -- optional
      'nvim-treesitter/nvim-treesitter',
      'rcarriga/nvim-notify',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      -- configuration goes here
      lang = 'python3',
    },
  },

  {
    'MeanderingProgrammer/render-markdown.nvim',
    opts = {},
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.nvim' }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
  },

  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      require('nvim-treesitter.configs').setup {
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              ['af'] = { '@function.outer', desc = 'Select outer function' },
              ['if'] = { '@function.inner', desc = 'Select inner function' },
              ['ac'] = { '@class.outer', desc = 'Select outer class' },
              ['ic'] = { '@class.inner', desc = 'Select inner class' },
              ['aa'] = { '@parameter.outer', desc = 'Select outer parameter' },
              ['ia'] = { '@parameter.inner', desc = 'Select inner parameter' },
              ['al'] = { '@loop.outer', desc = 'Select outer loop' },
              ['il'] = { '@loop.inner', desc = 'Select inner loop' },
              ['ab'] = { '@block.outer', desc = 'Select outer block' },
              ['ib'] = { '@block.inner', desc = 'Select inner block' },
              ['as'] = { '@statement.outer', desc = 'Select outer statement' },
              ['is'] = { '@statement.inner', desc = 'Select inner statement' },
            },
            selection_modes = {
              ['@parameter.outer'] = 'v', -- charwise
              ['@function.outer'] = 'V', -- linewise
              ['@class.outer'] = '<c-v>', -- blockwise
            },
          },
        },
      }
    end,
  },

  'ThePrimeagen/vim-be-good', -- Vim game to improve your Vim skills

  -- leap for quick navigation
  -- https://github.com/ggandor/leap.nvim
  -- {
  --   'ggandor/leap.nvim',
  --   config = function()
  --     require('leap').create_default_mappings()
  --   end,
  -- },

  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    opts = {},
    keys = {
      {
        's',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').jump()
        end,
        desc = 'Flash',
      },
      {
        'S',
        mode = { 'n', 'x', 'o' },
        function()
          require('flash').treesitter()
        end,
        desc = 'Flash Treesitter',
      },
      {
        'r',
        mode = 'o',
        function()
          require('flash').remote()
        end,
        desc = 'Remote Flash',
      },
      {
        'R',
        mode = { 'o', 'x' },
        function()
          require('flash').treesitter_search()
        end,
        desc = 'Treesitter Search',
      },
      {
        '<c-s>',
        mode = { 'c' },
        function()
          require('flash').toggle()
        end,
        desc = 'Toggle Flash Search',
      },
    },
  },
  -- illuminate for highlighting all instances of the word under the cursor
  -- TODO: kenny - try to figure out why this is repeatedly firing warnings.
  -- Disabling for now.
  -- {
  --   'RRethy/vim-illuminate',
  --   setup = function()
  --     vim.api.nvim_exec(
  --       [[
  --           autocmd FileType proto,cc let g:Illuminate_ftblacklist = 1
  --       ]],
  --       false
  --     )
  --   end,
  -- },

  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following Lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  {
    'folke/zen-mode.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    config = function()
      -- keymap to toggle zen mode
      vim.keymap.set('n', '<leader>z', '<cmd>ZenMode<CR>', { desc = 'Toggle [Z]en Mode' })
    end,
  },
  {
    -- TODO: kenny - configure more, see https://github.com/stevearc/oil.nvim
    'stevearc/oil.nvim',
    config = function()
      require('oil').setup {
        show_hidden = true,
        -- Your 'oil.nvim' specific configurations go here.
        -- Refer to the oil.nvim documentation for available options.
        -- Example configuration:
      }
      vim.keymap.set('n', '-', '<CMD>Oil --float<CR>', { desc = 'Open parent directory' })
    end,
  },

  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `config` key, the configuration only runs
  -- after the plugin has been loaded:
  --  config = function() ... end

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        -- { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
        { '<leader>a', group = '[A]I (AI/Copilot/ChatGPT)', mode = { 'n', 'v' } },
        { '<leader>p', group = '[P]anes' },
        { '<leader>b', group = '[B]azel' },
        { '<leader>e', group = '[E]rrors/diagnostics' },
        { '<leader>f', group = '[F]iles/Harpoon' },
        { '<leader>sm', group = '[S]earch Harpoon' },
        { '<leader>l', group = '[L]azyGit' },
        { '<leader>z', group = '[Z]en Mode' },
        { '<leader>n', group = '[N]eovim' },
      },
    },
    -- config = function() -- This is the function that runs, AFTER loading
    --   require('which-key').setup()
    --
    --   -- Document existing key chains
    --   require('which-key').register {
    --     ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    --     ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
    --     ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
    --     ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
    --     -- ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
    --     ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
    --     ['<leader>h'] = { name = 'Git [H]unk', _ = 'which_key_ignore' },
    --     ['<leader>a'] = { name = '[A]I: Copilot', _ = 'which_key_ignore' },
    --     ['<leader>p'] = { name = '[P]anes', _ = 'which_key_ignore' },
    --     ['<leader>b'] = { name = '[B]azel', _ = 'which_key_ignore' },
    --     ['<leader>e'] = { name = '[E]rrors/diagnostics', _ = 'which_key_ignore' },
    --     ['<leader>f'] = { name = '[F]iles/Harpoon', _ = 'which_key_ignore' },
    --     ['<leader>sm'] = { name = '[S]earch Harpoon', _ = 'which_key_ignore' },
    --     ['<leader>l'] = { name = '[L]azyGit', _ = 'which_key_ignore' },
    --     ['<leader>z'] = { name = '[Z]en Mode', _ = 'which_key_ignore' },
    --     ['<leader>n'] = { name = '[N]eovim', _ = 'which_key_ignore' },
    --   }
    --   -- visual mode
    --   require('which-key').register({
    --     ['<leader>h'] = { 'Git [H]unk' },
    --     ['<leader>a'] = { '[A]I: Copilot' },
    --   }, { mode = 'v' })
    -- end,
  },

  -- NOTE(kenny): Added bazel plugin. We'll see how this goes.
  -- This one is a vim plugin - I'm first going to try the neovim one below this.
  -- { 'bazelbuild/vim-bazel', opts = {} },
  -- {
  --   'alexander-born/bazel.nvim',
  --   dependencies = {
  --     { 'nvim-treesitter/nvim-treesitter' },
  --   },
  -- },
  -- NOTE(kenny): don't think this line below is necessary, so commented it out.
  -- I think this is covered by the `require 'plugins.bazel'` line further down.
  -- bazel_plugins = require 'plugins.bazel',

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { 'rxi/json.lua' },

  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'rxi/json.lua', -- for json formatting in picker previews.
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- Telescope is a fuzzy finder that comes with a lot of different things that
      -- it can fuzzy find! It's more than just a "file finder", it can search
      -- many different aspects of Neovim, your workspace, LSP, and more!
      --
      -- The easiest way to use Telescope, is to start by doing something like:
      --  :Telescope help_tags
      --
      -- After running this command, a window will open up and you're able to
      -- type in the prompt window. You'll see a list of `help_tags` options and
      -- a corresponding preview of the help.
      --
      -- Two important keymaps to use while in Telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      -- This opens a window that shows you all of the keymaps for the current
      -- Telescope picker. This is really useful to discover what Telescope can
      -- do as well as how to actually do it!

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      --
      require('telescope').setup {
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --

        defaults = {
          mappings = {
            n = {
              ['dd'] = 'delete_buffer',
            },
            i = {
              ['<c-enter>'] = 'to_fuzzy_refine',
              ['<c-d>'] = 'delete_buffer',
            },
          },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
      pcall(require('telescope').load_extension, 'noice')

      -- See `:help tvlescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sv', builtin.commands, { desc = '[S]earch [V]im commands' })
      vim.keymap.set('n', '<leader>sf', function()
        -- include hidden files
        builtin.find_files { hidden = true }
      end, { desc = '[S]earch [F]iles' })
      -- vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })

      -- Shortcut for searching all config system files in ~/.config/
      vim.keymap.set('n', '<leader>sc', function()
        builtin.find_files {
          search_dirs = {
            '~/.config',
            '~/.bashrc',
            '~/.bash_aliases',
            '~/.blerc',
            '~/.tmux.conf',
            '~/.gitconfig',
            '~/README.md',
          },
          -- cwd = '~/.config',
          hidden = true,
          file_ignore_patterns = {
            'gcloud',
            'google',
            '.db',
            '.tdb',
            'pulse',
            'gedit',
            'ibus',
            'evolution',
            'nautilus',
            'nvim/.git',
            'enchant',
            'goa',
            'dconf',
          },
        }
      end, { desc = '[S]earch [C]onfig files' })
    end,
  },
  -- {
  --   'ojroques/nvim-osc52',
  --   config = function()
  --     require('osc52').setup {
  --       max_length = 0, -- 0 means no limit on text length
  --       silent = false, -- shows message on osc52 command
  --       trim = false, -- remove trailing whitespace
  --       tmux_passthrough = true, -- send to tmux clipboard
  --     }
  --   end,
  -- },
  {
    'aserowy/tmux.nvim',
    config = function()
      require('tmux').setup {
        copy_sync = {
          enable = true,
          redirect_to_clipboard = true,
          -- tmux_copy_mode = false,
        },
        navigation = {
          enable_default_keybindings = true,
        },
        resize = {
          enable_default_keybindings = true,
        },
      }
    end,
  },
  -- Git merge conflict viz + tool.
  {
    'akinsho/git-conflict.nvim',
    version = '*',
    config = true,
  },

  -- multiline cursor editing:
  {
    'mg979/vim-visual-multi',
    config = function()
      -- we need to unbind C-k and C-j keymaps from other plugins.
      -- vim.api.nvim_set_keymap('n', '<C-k>', '', { noremap = true, silent = true })
      -- vim.api.nvim_set_keymap('n', '<C-j>', '', { noremap = true, silent = true })
      -- I think these are used by the tmux.nvim plugin, but I don't use them.
      -- vim.cmd [[
      --   autocmd VimEnter * silent! nunmap <C-S-j>
      --   autocmd VimEnter * silent! nunmap <C-S-k>
      --   let g:VM_maps = {}
      --   let g:VM_maps['Add Cursor Up'] = '<C-S-k>'
      --   let g:VM_maps['Add Cursor Down'] = '<C-S-j>'
      -- ]]
      -- use these keymaps for visual-multi
      -- vim.g.VM_maps['Add Cursor Up'] = '<Up>'
      -- vim.g.VM_maps['Add Cursor Down'] = '<Down>'
      -- NOTE: just commented this out because I disabled the
      -- ctrl + up/down system shortcuts on mac, so I can use the default
      -- keymaps here for visual-multi.
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    config = function()
      -- Brief aside: **What is LSP?**
      --
      -- LSP is an initialism you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, `:help lsp-vs-treesitter`

      --  This function gets run when an LSP attaches to a particular buffer.
      --    That is to say, every time a new file is opened that is associated with
      --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
      --    function will be executed to configure the current buffer
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- NOTE: Remember that Lua is a real programming language, and as such it is possible
          -- to define small helper and utility functions so you don't have to repeat yourself.
          --
          -- In this case, we create a function that lets us more easily define mappings specific
          -- for LSP related items. It sets the mode, buffer and description for us each time.
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          -- map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        -- clangd = {},
        clangd = {
          filetypes = { 'c', 'cpp', 'objc', 'objcpp', 'cc', 'h' }, -- add or remove file types as needed
          -- stop offset_encoding warnings, I keep seeing spam warnings that say:
          -- warning: multiple different client offset_encodings detected for buffer, this is not supported yet
          -- So this is to fix this issue:
          cmd = {
            'clangd',
            '--offset-encoding=utf-16',
            -- NOTE: @kenny: add path for compile_commands.json
            -- also need to figure out method to generate using BAZEL.
          },
        },
        -- ccls = {},
        -- gopls = {},
        pyright = {
          settings = {
            -- pythonPath = '~/miniconda3/bin/python',
            pythonPath = '/home/kenny/miniconda3/bin/python',
          },
        },
        -- rust_analyzer = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --
        -- Some languages (like typescript) have entire language plugins that can be useful:
        --    https://github.com/pmizio/typescript-tools.nvim
        --
        -- But for many setups, the LSP (`tsserver`) will work just fine
        -- tsserver = {},
        --
        -- For Google Protocol Buffers (protobuf).
        -- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#pbls
        pbls = {
          filetypes = { 'proto' },
          cmd = { 'pbls' },
        },

        lua_ls = {
          -- cmd = {...},
          -- filetypes = { ...},
          -- capabilities = {},
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
              -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
              -- diagnostics = { disable = { 'missing-fields' } },
            },
          },
        },
      }

      -- Ensure the servers and tools above are installed
      --  To check the current status of installed tools and/or manually install
      --  other tools, you can run
      --    :Mason
      --
      --  You can press `g?` for help in this menu.
      require('mason').setup()

      -- You can add other tools here that you want Mason to install
      -- for you, so that they are available from within Neovim.
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            -- This handles overriding only values explicitly passed
            -- by the server configuration above. Useful when disabling
            -- certain features of an LSP (for example, turning off formatting for tsserver)
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[C]ode: [F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          -- Build Step is needed for regex support in snippets.
          -- This step is not supported in many windows environments.
          -- Remove the below condition to re-enable on windows.
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          -- `friendly-snippets` contains a variety of premade snippets.
          --    See the README about individual language/framework/plugin snippets:
          --    https://github.com/rafamadriz/friendly-snippets
          -- {
          --   'rafamadriz/friendly-snippets',
          --   config = function()
          --     require('luasnip.loaders.from_vscode').lazy_load()
          --   end,
          -- },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      -- Adds other completion capabilities.
      --  nvim-cmp does not ship with all sources by default. They are split
      --  into multiple repos for maintenance purposes.
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'alexander-born/cmp-bazel',
    },
    config = function()
      -- See `:help cmp`
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        -- For an understanding of why these mappings were
        -- chosen, you will need to read `:help ins-completion`
        --
        -- No, but seriously. Please read `:help ins-completion`, it is really good!
        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          -- Accept ([y]es) the completion.
          --  This will auto-import if your LSP supports it.
          --  This will expand snippets if the LSP sent a snippet.
          ['<C-y>'] = cmp.mapping.confirm { select = true },

          -- If you prefer more traditional completion keymaps,
          -- you can uncomment the following lines
          --['<CR>'] = cmp.mapping.confirm { select = true },
          --['<Tab>'] = cmp.mapping.select_next_item(),
          --['<S-Tab>'] = cmp.mapping.select_prev_item(),

          -- Manually trigger a completion from nvim-cmp.
          --  Generally you don't need this, because nvim-cmp will display
          --  completions whenever it has completion options available.
          ['<C-Space>'] = cmp.mapping.complete {},

          -- Think of <c-l> as moving to the right of your snippet expansion.
          --  So if you have a snippet that's like:
          --  function $name($args)
          --    $body
          --  end
          --
          -- <c-l> will move you to the right of each of the expansion locations.
          -- <c-h> is similar, except moving you backwards.
          ['<C-l>'] = cmp.mapping(function()
            if luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            end
          end, { 'i', 's' }),
          ['<C-h>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),

          -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
          --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          { name = 'bazel' },
          -- { name = 'codeium' }, -- NOTE: kenny: added this source for codeium completion.
        },
      }
    end,
  },

  -- NOTE: kenny: tried out another color scheme below - didn't like it as much.
  --
  -- { -- You can easily change to a different colorscheme.
  --   -- Change the name of the colorscheme plugin below, and then
  --   -- change the command in the config to whatever the name of that colorscheme is.
  --   --
  --   -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
  --   'folke/tokyonight.nvim',
  --   priority = 1000, -- Make sure to load this before all the other start plugins.
  --   init = function()
  --     -- Load the colorscheme here.
  --     -- Like many other themes, this one has different styles, and you could load
  --     -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
  --     vim.cmd.colorscheme 'tokyonight-night'
  --
  --     -- You can configure highlights by doing something like:
  --     vim.cmd.hi 'Comment gui=none'
  --   end,
  -- },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      vim.cmd 'colorscheme catppuccin'
      require('catppuccin').setup {
        flavour = 'mocha',
        dim_inactive = {
          enable = true,
          shade = 'dark',
          percentage = 0.15,
        },
      }
    end,
  },

  -- Trying 'One Dark' colorscheme to be similar to VS code's Dark Modern color scehem.
  -- NOTE: disabling because I don't like it lol.
  -- {
  --   'joshdick/onedark.vim',
  --   config = function()
  --     vim.cmd 'syntax enable'
  --     vim.cmd 'set background=dark'
  --     vim.cmd 'colorscheme onedark'
  --   end,
  -- },

  -- Highlight todo, notes, etc in comments
  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      highlight = {
        keyword = 'wide',
        pattern = [[.*<(KEYWORDS)\s*(\(.*\))?\s*:]],
      },
    },
  },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      -- NOTE(kenny): disabled surround for now because I wasn't using it,
      -- and the default keybindings conflict with the defaults fro `leap`.
      -- require('mini.surround').setup()

      -- NOTE(kenny): I have disabled mini.statusline for now.
      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup { use_icons = vim.g.have_nerd_font }
      --
      -- -- You can configure sections in the statusline by overriding their
      -- -- default behavior. For example, here we set the section for
      -- -- cursor location to LINE:COLUMN
      -- ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { 'mode' },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          -- Show only file name:
          -- lualine_c = { 'filename' },
          -- Show full relative filepath:
          lualine_c = {
            function()
              return '%f'
            end,
          },
          lualine_x = { 'encoding', 'fileformat', 'filetype' },
          lualine_y = { 'progress' },
          lualine_z = { 'location' },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          -- Show only file name:
          -- lualine_c = { 'filename' },
          -- Show full relative filepath instead:
          lualine_c = {
            function()
              return '%f'
            end,
          },
          lualine_x = { 'location' },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'python', 'cpp', 'typescript' },
      -- Autoinstall languages that are not installed
      auto_install = true,
      highlight = {
        enable = true,
        -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
        --  If you are experiencing weird indenting issues, add the language to
        --  the list of additional_vim_regex_highlighting and disabled languages for indent.
        additional_vim_regex_highlighting = { 'ruby', 'cpp' },
      },
      indent = { enable = true, disable = { 'ruby', 'cpp' } },
    },
    config = function(_, opts)
      -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

      -- Prefer git instead of curl in order to improve connectivity in some environments
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('treesitter-context').setup {
        enable = true, -- Enable this plugin
        throttle = true, -- Throttles plugin updates (may improve performance)
        line_numbers = true, -- Display line numbers in the context
      }
    end,
  },
  {
    -- TODO: kenny: configure fugitive for git commands.
    'tpope/vim-fugitive',
    config = function()
      -- NOTE: Kenny: specify any additional github domains with comma sep env var.
      local additional_domains = os.getenv 'ADDITIONAL_GITHUB_DOMAINS'
      local domains = { 'github.com' }
      if additional_domains then
        for domain in additional_domains:gmatch '[^,]+' do
          table.insert(domains, domain)
        end
      end
      vim.g.fugitive_github_domains = domains
      -- Keymaps to open file in github.
      -- NOTE: Currently not working through my ssh + tmux setup - haven't found a solution yet.
      vim.api.nvim_set_keymap('n', '<leader>ho', ':GBrowse<CR>', {
        desc = 'git [O]pen in browser',
        noremap = true,
        silent = true,
      })
      vim.api.nvim_set_keymap('v', '<leader>ho', ':GBrowse<CR>', {
        desc = 'git [O]pen in browser',
        noremap = true,
        silent = true,
      })
    end,
  },
  {
    -- vim-rhubarb enhances fugitive with GitHub support.
    -- Example: `:Gbrowse` to open the current file in GitHub.
    'tpope/vim-rhubarb',
  },
  {
    'rmagatti/auto-session',
    config = function()
      require('auto-session').setup {
        log_level = 'error',
      }
    end,
  },
  -- TODO: Kenny: configure noice.
  {
    -- https://github.com/folke/noice.nvim
    'folke/noice.nvim',
    event = 'VeryLazy',
    -- opts = {
    --   -- add any options here
    -- },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      'rcarriga/nvim-notify',
    },
    config = function()
      require('noice').setup {
        views = {
          cmdline_popup = {
            position = {
              row = '50%',
              col = '50%',
            },
            size = {
              width = 60,
              height = 'auto',
            },
          },
          popupmenu = {
            relative = 'editor',
            position = {
              row = '65%',
              col = '50%',
            },
            size = {
              width = 60,
              height = 'auto',
            },
            border = {
              style = 'rounded',
              padding = { 0, 1 },
            },
            win_options = {
              winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
            },
          },
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
            ['vim.lsp.util.stylize_markdown'] = true,
            ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          -- bottom_search = true, -- use a classic bottom cmdline for search
          -- NOTE: command_palette = true will put the popup near the top.
          -- command_palette = true, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = true, -- add a border to hover docs and signature help
        },
      }
      -- dismiss noice notifications with <leader>nd
      vim.api.nvim_set_keymap('n', '<leader>nd', '<cmd>NoiceDismiss<CR>', {
        noremap = true,
        silent = true,
        desc = '[N]oice [D]ismiss nofications',
      })
    end,
  },
  {
    'fladson/vim-kitty',
  },
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = '[L]azy[G]it' },
      { '<leader>lc', '<cmd>LazyGitConfig<cr>', desc = '[L]azygit [C]onfig' },
    },
  },

  -- The following two comments only work if you have downloaded the kickstart repo, not just copy pasted the
  -- init.lua. If you want these files, they are in the repository, so you can just download them and
  -- place them in the correct locations.

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  --  Here are some example plugins that I've included in the Kickstart repository.
  --  Uncomment any of the lines below to enable them (you will need to restart nvim).
  --
  require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- Add Bazel support
  require 'plugins.bazel',
  -- Add Copilot support
  require 'plugins.copilot',
  -- Add Harpoon2 support
  require 'plugins.harpoon',
  -- ChatGPT plugin setup.
  require 'plugins.chatgpt',
  -- Codeium plugin setup.
  -- require 'plugins.codeium',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  --  Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
