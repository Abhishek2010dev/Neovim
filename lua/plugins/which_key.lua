return {
  -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    -- Delay between pressing a key and opening which-key (milliseconds)
    -- This setting is independent of vim.opt.timeoutlen
    window = { delay = 0 },

    icons = {
      -- Set icon mappings to true if you have a Nerd Font
      mappings = vim.g.have_nerd_font or false,
      -- Define key icons based on whether a Nerd Font is available
      keys = vim.g.have_nerd_font and {} or {
        Up = '<Up> ',
        Down = '<Down> ',
        Left = '<Left> ',
        Right = '<Right> ',
        ['<C-…>'] = 'C ',
        ['<M-…>'] = 'M ',
        ['<D-…>'] = 'D ',
        ['<S-…>'] = 'S ',
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

    -- Document existing key mappings
    defaults = {
      ['<leader>c'] = { name = '[C]ode', mode = { 'n', 'x' } },
      ['<leader>d'] = { name = '[D]ocument' },
      ['<leader>r'] = { name = '[R]ename' },
      ['<leader>s'] = { name = '[S]earch' },
      ['<leader>w'] = { name = '[W]orkspace' },
      ['<leader>t'] = { name = '[T]oggle' },
      ['<leader>h'] = { name = 'Git [H]unk', mode = { 'n', 'v' } },
    },
  },
}

