local ale = require('feline.custom_providers.ale')

local components = {
  active = { {}, {}, {} },
  inactive = { {}, {} },
}

-- Left
-- Active File Info {{{
table.insert(components.active[1], {
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
table.insert(components.active[1], {
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
  provider = 'ale_status',
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
  provider = 'ale_error',
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
  provider = 'ale_warning',
  hl = {
    fg = '#ffffff',
    bg = '#ff8700',
  },
  left_sep = {
    str = 'slant_left',
    hl = function()
      if ale.get_diagnostic_count('error') > 0 then
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

-- Inactive Left
-- File Info {{{
table.insert(components.inactive[1], {
  provider = {
    name = 'file_info',
    opts = { colored_icon = false },
  },
  hl = { bg = '#047857' },
  right_sep = 'slant_right',
  left_sep = 'block',
})
-- }}}

-- Inactive Right
-- File Encoding {{{
table.insert(components.active[3], {
  provider = 'file_encoding',
  right_sep = 'block',
})
-- }}}

require('feline').setup({
  components = components,
  custom_providers = {
    ale_status = ale.status_provider,
    ale_error = ale.diagnostic_error_provider,
    ale_warning = ale.diagnostic_warning_provider,
  },
})
