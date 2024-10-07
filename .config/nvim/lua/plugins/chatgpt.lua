local api_key_cmd = os.getenv 'OPENAI_API_READ_CMD'
return {
  -- Lazy
  {
    'jackMort/ChatGPT.nvim',
    event = 'VeryLazy',
    config = function()
      require('chatgpt').setup {
        openai_params = {
          -- model = 'o1-mini',
          -- model = 'gpt-4o-mini',
          model = 'gpt-4o',
          -- model = 'o1-preview',
        },
        api_key_cmd = api_key_cmd,
      }

      -- Additional keybindings
      local wk = require 'which-key'
      wk.add {
        { '<leader>ag', group = 'Chat[G]PT' },
        { '<leader>agg', '<cmd>ChatGPT<CR>', desc = 'Chat [G]PT', mode = { 'n', 'v' } },
        { '<leader>agcc', '<cmd>ChatGPTCompleteCode<CR>', desc = '[C]omplete [C]ode', mode = { 'n', 'v' } },
        { '<leader>agaa', '<cmd>ChatGPTActAs<CR>', desc = '[A]ct [A]s', mode = { 'n', 'v' } },
        { '<leader>age', '<cmd>ChatGPTEditWithInstruction<CR>', desc = '[E]dit with instruction', mode = { 'n', 'v' } },
        { '<leader>agg', '<cmd>ChatGPTRun grammar_correction<CR>', desc = '[G]rammar Correction', mode = { 'n', 'v' } },
        { '<leader>agt', '<cmd>ChatGPTRun translate<CR>', desc = '[T]ranslate', mode = { 'n', 'v' } },
        { '<leader>agk', '<cmd>ChatGPTRun keywords<CR>', desc = '[K]eywords', mode = { 'n', 'v' } },
        { '<leader>agd', '<cmd>ChatGPTRun docstring<CR>', desc = '[D]ocstring', mode = { 'n', 'v' } },
        { '<leader>agat', '<cmd>ChatGPTRun add_tests<CR>', desc = '[A]dd [T]ests', mode = { 'n', 'v' } },
        { '<leader>ago', '<cmd>ChatGPTRun optimize_code<CR>', desc = '[O]ptimize Code', mode = { 'n', 'v' } },
        { '<leader>ags', '<cmd>ChatGPTRun summarize<CR>', desc = '[S]ummarize', mode = { 'n', 'v' } },
        { '<leader>agf', '<cmd>ChatGPTRun fix_bugs<CR>', desc = '[F]ix Bugs', mode = { 'n', 'v' } },
        { '<leader>agx', '<cmd>ChatGPTRun explain_code<CR>', desc = 'E[x]plain Code', mode = { 'n', 'v' } },
        { '<leader>agre', '<cmd>ChatGPTRun roxygen_edit<CR>', desc = '[R]oxygen [E]dit', mode = { 'n', 'v' } },
        { '<leader>agl', '<cmd>ChatGPTRun code_readability_analysis<CR>', desc = 'Code Readability Ana[l]ysis', mode = { 'n', 'v' } },
      }
    end,
    dependencies = {
      'MunifTanjim/nui.nvim',
      'nvim-lua/plenary.nvim',
      'folke/trouble.nvim',
      'nvim-telescope/telescope.nvim',
    },
  },
  {
    'robitx/gp.nvim',
    config = function()
      -- TODO: @kenny: setup here.
      -- split api_key_cmd into a table at each space:
      local api_key_cmd_table = {}
      for word in api_key_cmd:gmatch '%S+' do
        table.insert(api_key_cmd_table, word)
      end
      local conf = {
        -- For customization, refer to Install > Configuration in the Documentation/Readme
        openai_api_key = api_key_cmd_table,
      }
      require('gp').setup(conf)
      -- Setup shortcuts here (see Usage > Shortcuts in the Documentation/Readme)
      wk = require 'which-key'
      wk.add {
        {
          mode = { 'v' },
          nowait = true,
          remap = false,
          { '<C-g><C-t>', ":<C-u>'<,'>GpChatNew tabnew<cr>", desc = 'ChatNew tabnew' },
          { '<C-g><C-v>', ":<C-u>'<,'>GpChatNew vsplit<cr>", desc = 'ChatNew vsplit' },
          { '<C-g><C-x>', ":<C-u>'<,'>GpChatNew split<cr>", desc = 'ChatNew split' },
          { '<C-g>a', ":<C-u>'<,'>GpAppend<cr>", desc = 'Visual Append (after)' },
          { '<C-g>b', ":<C-u>'<,'>GpPrepend<cr>", desc = 'Visual Prepend (before)' },
          { '<C-g>c', ":<C-u>'<,'>GpChatNew<cr>", desc = 'Visual Chat New' },
          { '<C-g>g', group = 'generate into new ..' },
          { '<C-g>ge', ":<C-u>'<,'>GpEnew<cr>", desc = 'Visual GpEnew' },
          { '<C-g>gn', ":<C-u>'<,'>GpNew<cr>", desc = 'Visual GpNew' },
          { '<C-g>gp', ":<C-u>'<,'>GpPopup<cr>", desc = 'Visual Popup' },
          { '<C-g>gt', ":<C-u>'<,'>GpTabnew<cr>", desc = 'Visual GpTabnew' },
          { '<C-g>gv', ":<C-u>'<,'>GpVnew<cr>", desc = 'Visual GpVnew' },
          { '<C-g>i', ":<C-u>'<,'>GpImplement<cr>", desc = 'Implement selection' },
          { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
          { '<C-g>p', ":<C-u>'<,'>GpChatPaste<cr>", desc = 'Visual Chat Paste' },
          { '<C-g>r', ":<C-u>'<,'>GpRewrite<cr>", desc = 'Visual Rewrite' },
          { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
          { '<C-g>t', ":<C-u>'<,'>GpChatToggle<cr>", desc = 'Visual Toggle Chat' },
          -- { '<C-g>w', group = 'Whisper' },
          -- { '<C-g>wa', ":<C-u>'<,'>GpWhisperAppend<cr>", desc = 'Whisper Append' },
          -- { '<C-g>wb', ":<C-u>'<,'>GpWhisperPrepend<cr>", desc = 'Whisper Prepend' },
          -- { '<C-g>we', ":<C-u>'<,'>GpWhisperEnew<cr>", desc = 'Whisper Enew' },
          -- { '<C-g>wn', ":<C-u>'<,'>GpWhisperNew<cr>", desc = 'Whisper New' },
          -- { '<C-g>wp', ":<C-u>'<,'>GpWhisperPopup<cr>", desc = 'Whisper Popup' },
          -- { '<C-g>wr', ":<C-u>'<,'>GpWhisperRewrite<cr>", desc = 'Whisper Rewrite' },
          -- { '<C-g>wt', ":<C-u>'<,'>GpWhisperTabnew<cr>", desc = 'Whisper Tabnew' },
          -- { '<C-g>wv', ":<C-u>'<,'>GpWhisperVnew<cr>", desc = 'Whisper Vnew' },
          -- { '<C-g>ww', ":<C-u>'<,'>GpWhisper<cr>", desc = 'Whisper' },
          { '<C-g>x', ":<C-u>'<,'>GpContext<cr>", desc = 'Visual GpContext' },
        },

        -- NORMAL mode mappings
        {
          mode = { 'n' },
          nowait = true,
          remap = false,
          { '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', desc = 'New Chat tabnew' },
          { '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat vsplit' },
          { '<C-g><C-x>', '<cmd>GpChatNew split<cr>', desc = 'New Chat split' },
          { '<C-g>a', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
          { '<C-g>b', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
          { '<C-g>c', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
          { '<C-g>f', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
          { '<C-g>g', group = 'generate into new ..' },
          { '<C-g>ge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
          { '<C-g>gn', '<cmd>GpNew<cr>', desc = 'GpNew' },
          { '<C-g>gp', '<cmd>GpPopup<cr>', desc = 'Popup' },
          { '<C-g>gt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
          { '<C-g>gv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
          { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
          { '<C-g>r', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
          { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
          { '<C-g>t', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
          -- { '<C-g>w', group = 'Whisper' },
          -- { '<C-g>wa', '<cmd>GpWhisperAppend<cr>', desc = 'Whisper Append (after)' },
          -- { '<C-g>wb', '<cmd>GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)' },
          -- { '<C-g>we', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
          -- { '<C-g>wn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
          -- { '<C-g>wp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
          -- { '<C-g>wr', '<cmd>GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite' },
          -- { '<C-g>wt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
          -- { '<C-g>wv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
          -- { '<C-g>ww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
          { '<C-g>x', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
        },

        -- INSERT mode mappings
        {
          mode = { 'i' },
          nowait = true,
          remap = false,
          { '<C-g><C-t>', '<cmd>GpChatNew tabnew<cr>', desc = 'New Chat tabnew' },
          { '<C-g><C-v>', '<cmd>GpChatNew vsplit<cr>', desc = 'New Chat vsplit' },
          { '<C-g><C-x>', '<cmd>GpChatNew split<cr>', desc = 'New Chat split' },
          { '<C-g>a', '<cmd>GpAppend<cr>', desc = 'Append (after)' },
          { '<C-g>b', '<cmd>GpPrepend<cr>', desc = 'Prepend (before)' },
          { '<C-g>c', '<cmd>GpChatNew<cr>', desc = 'New Chat' },
          { '<C-g>f', '<cmd>GpChatFinder<cr>', desc = 'Chat Finder' },
          { '<C-g>g', group = 'generate into new ..' },
          { '<C-g>ge', '<cmd>GpEnew<cr>', desc = 'GpEnew' },
          { '<C-g>gn', '<cmd>GpNew<cr>', desc = 'GpNew' },
          { '<C-g>gp', '<cmd>GpPopup<cr>', desc = 'Popup' },
          { '<C-g>gt', '<cmd>GpTabnew<cr>', desc = 'GpTabnew' },
          { '<C-g>gv', '<cmd>GpVnew<cr>', desc = 'GpVnew' },
          { '<C-g>n', '<cmd>GpNextAgent<cr>', desc = 'Next Agent' },
          { '<C-g>r', '<cmd>GpRewrite<cr>', desc = 'Inline Rewrite' },
          { '<C-g>s', '<cmd>GpStop<cr>', desc = 'GpStop' },
          { '<C-g>t', '<cmd>GpChatToggle<cr>', desc = 'Toggle Chat' },
          -- { '<C-g>w', group = 'Whisper' },
          -- { '<C-g>wa', '<cmd>GpWhisperAppend<cr>', desc = 'Whisper Append (after)' },
          -- { '<C-g>wb', '<cmd>GpWhisperPrepend<cr>', desc = 'Whisper Prepend (before)' },
          -- { '<C-g>we', '<cmd>GpWhisperEnew<cr>', desc = 'Whisper Enew' },
          -- { '<C-g>wn', '<cmd>GpWhisperNew<cr>', desc = 'Whisper New' },
          -- { '<C-g>wp', '<cmd>GpWhisperPopup<cr>', desc = 'Whisper Popup' },
          -- { '<C-g>wr', '<cmd>GpWhisperRewrite<cr>', desc = 'Whisper Inline Rewrite' },
          -- { '<C-g>wt', '<cmd>GpWhisperTabnew<cr>', desc = 'Whisper Tabnew' },
          -- { '<C-g>wv', '<cmd>GpWhisperVnew<cr>', desc = 'Whisper Vnew' },
          -- { '<C-g>ww', '<cmd>GpWhisper<cr>', desc = 'Whisper' },
          -- { '<C-g>x', '<cmd>GpContext<cr>', desc = 'Toggle GpContext' },
        },
      }
    end,
  },
}
