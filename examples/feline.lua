local ale = require 'feline.providers.ale'
local M = {}

-- Active
M.active = { {}, {}, {} }

-- Left
-- Active File Info {{{
table.insert(M.active[1], {
  provider = {
    name = 'file_info',
    opts = { colored_icon = false },
  },
  hl = { bg = '#047857' },
  right_sep = 'slant_right',
  left_sep = 'block',
})
-- }}}

-- Active Git Branch {{{
table.insert(M.active[1], {
  provider = 'git_branch',
  left_sep = 'block',
})
-- }}}

-- Right
-- Active File Encoding {{{
table.insert(active[3], {
  provider = 'file_encoding',
  right_sep = 'block',
})
-- }}}

-- Active ALE Component {{{
table.insert(active[3], {
  provider = ale.status_provider,
  hl = {
    fg = '#262626',
    bg = '#ffffff',
  },
  left_sep = {
    str = 'slant_left',
    hl = {
      fg = '#ffffff',
      bg = '#606060',
    },
  },
})
-- }}}

-- Active ALE Error Component {{{
table.insert(active[3], {
  provider = ale.error_provider,
  hl = {
    fg = '#ffffff',
    bg = '#df0000',
  },
  left_sep = {
    str = 'slant_left',
    hl = {
      fg = '#df0000',
      bg = '#ffffff',
    },
  },
})
-- }}}

-- Active ALE Warning Component {{{
table.insert(active[3], {
  provider = ale.warning_provider,
  hl = {
    fg = '#ffffff',
    bg = '#ff8700',
  },
  left_sep = {
    str = 'slant_left',
    hl = function()
      local is_error, _ = ale.has_errors()
      if is_error then
        return {
          fg = '#ff8700',
          bg = '#df0000',
        }
      else
        return {
          fg = '#ff8700',
          bg = '#ffffff',
        }
      end
    end,
  },
})
-- }}}

-- Inactive
M.inactive = { {}, {} }

-- Left
-- Inactive File Info {{{
table.insert(M.inactive[1], {
  provider = {
    name = 'file_info',
    opts = { colored_icon = false },
  },
  hl = { bg = '#047857' },
  right_sep = 'slant_right',
  left_sep = 'block',
})
-- }}}

-- Right
-- Inactive File Encoding {{{
table.insert(M.active[3], {
  provider = 'file_encoding',
  right_sep = 'block',
})
-- }}}

return M
