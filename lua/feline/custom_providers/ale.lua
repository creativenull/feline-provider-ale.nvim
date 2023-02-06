local M = {}

---Obtain diagnostic count from ALE builtin diagnostic api
---@param attr string
---@return number
local function get_ale_diagnostic(attr)
  local buf = vim.api.nvim_get_current_buf()
  local diagnostics = vim.call('ale#statusline#Count', buf)
  local count = 0

  if attr == 'error' then
    count = diagnostics.error + diagnostics.style_error
  elseif attr == 'warn' or attr == 'warning' then
    count = diagnostics.warning + diagnostics.style_warning
  elseif attr == 'info' then
    count = diagnostics.info
  end

  return count
end

---Obtain diagnostic count from nvim diagnostic api
---@param attr string
---@return number
local function get_nvim_diagnostic(attr)
  local buf = vim.api.nvim_get_current_buf()
  local diagnostics = vim.diagnostic.get(buf)
  local items = {}

  if attr == 'error' then
    items = vim.tbl_filter(function(item)
      return item.severity == vim.diagnostic.severity.ERROR
    end, diagnostics)
  elseif attr == 'warn' or attr == 'warning' then
    items = vim.tbl_filter(function(item)
      return item.severity == vim.diagnostic.severity.WARN
    end, diagnostics)
  elseif attr == 'info' then
    items = vim.tbl_filter(function(item)
      return item.severity == vim.diagnostic.severity.INFO or item.severity == vim.diagnostic.severity.HINT
    end, diagnostics)
  elseif attr == 'hint' then
    items = vim.tbl_filter(function(item)
      return item.severity == vim.diagnostic.severity.INFO or item.severity == vim.diagnostic.severity.HINT
    end, diagnostics)
  end

  return #items
end

---Obtains the diagnostic count of a given severity
---@param attr string
---@return number
function M.get_diagnostic_count(attr)
  if vim.g.ale_use_neovim_diagnostics_api ~= nil and vim.g.ale_use_neovim_diagnostics_api == 1 then
    return get_nvim_diagnostic(attr)
  else
    return get_ale_diagnostic(attr)
  end
end

---Check if buffer or global specified linters were created
---@return boolean
function M.has_registered_linters()
  local buf = vim.api.nvim_get_current_buf()
  return vim.b[buf].ale_linters ~= nil or vim.g.ale_linters ~= nil
end

---Check if buffer or global specified fixers were created
---@return boolean
function M.has_registered_fixers()
  local buf = vim.api.nvim_get_current_buf()
  return vim.b[buf].ale_fixers ~= nil or vim.g.ale_fixers ~= nil
end

---Check if either buffer specified linters or fixers were created
---@return boolean
function M.is_registered()
  return M.has_registered_linters() or M.has_registered_fixers()
end

---Status provider for ALE to ensure if it is running for
---the current buffer
---@param component table The current component context
---@param opts table Custom options for the provider
---@return string
function M.status_provider(component, opts)
  if component.enabled == nil then
    component.enabled = function()
      return M.is_registered()
    end
  end

  local linter_icon = ' 󰓠'
  if opts.linter_icon then
    linter_icon = ' ' .. opts.linter_icon
  end

  local fixer_icon = ' 󱌢'
  if opts.fixer_icon then
    fixer_icon = ' ' .. opts.fixer_icon
  end

  local text = 'ALE'
  if opts.text then
    text = opts.text
  end

  local linter_attached_icon = M.has_registered_linters() and linter_icon or ''
  local fixer_attached_icon = M.has_registered_fixers() and fixer_icon or ''

  return string.format(' %s%s%s ', text, linter_attached_icon, fixer_attached_icon)
end

---Error provider for ALE, shows the total count of errors
---in the current buffer
---@param component table The current component context
---@param opts table Custom options for the provider
---@return string
function M.diagnostic_error_provider(component)
  local key = 'error'
  if component.enabled == nil then
    component.enabled = function()
      return get_diagnostic_count(key) > 0
    end
  end

  local icon = ''
  if component.icon then
    icon = component.icon
  end

  return string.format(' %s%s ', icon, get_diagnostic_count(key))
end

---Warning provider for ALE, shows the total count of warnings
---in the current buffer
---@param component table The current component context
---@param opts table Custom options for the provider
---@return string
function M.diagnostic_warning_provider(component)
  local key = 'warning'
  if component.enabled == nil then
    component.enabled = function()
      return get_diagnostic_count(key) > 0
    end
  end

  local icon = ''
  if component.icon then
    icon = component.icon
  end

  return string.format(' %s%s ', icon, get_diagnostic_count(key))
end

---Info provider for ALE, shows the total count of infos
---in the current buffer
---@param component table The current component context
---@param opts table Custom options for the provider
---@return string
function M.diagnostic_info_provider(component)
  local key = 'info'
  if component.enabled == nil then
    component.enabled = function()
      return get_diagnostic_count(key) > 0
    end
  end

  local icon = ''
  if component.icon then
    icon = component.icon
  end

  return string.format(' %s%s ', icon, get_diagnostic_count(key))
end

return M
