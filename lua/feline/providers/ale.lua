local M = {}

function M.is_loaded()
  return vim.fn.exists('g:loaded_ale') == 1
end

function M.diagnostics()
  if M.is_loaded() then
    local bufnr = vim.api.nvim_get_current_buf()
    local counts = vim.call('ale#statusline#Count', bufnr)
    return counts
  end
  return 0
end

function M.status_provider(component)
  local text = component.icon and ' ALE ' or 'ALE '
  local icon = component.icon or '  '
  if M.is_loaded() then
    return text, icon
  end
  return ''
end

function M.has_errors()
  local count = M.diagnostics()
  local total = count.error + count.style_error
  return total > 0, total
end

function M.error_provider(component)
  local is_error, total = M.has_errors()
  if is_error then
    local text = string.format('%d ', total)
    local icon = component.icon or '  '
    return text, icon
  end
  return ''
end

function M.has_warnings()
  local count = M.diagnostics()
  local total = count.warning + count.style_warning
  return total > 0, total
end

function M.warning_provider(component)
  local is_warning, total = M.has_warnings()
  if is_warning then
    local text = string.format('%d ', total)
    local icon = component.icon or '  '
    return text, icon
  end
  return ''
end

function M.has_info()
  local count = M.diagnostics()
  return count.info > 0, count.info
end

function M.info_provider()
  local is_info, total = M.has_info()
  if is_info then
    local text = string.format('%d ', total)
    local icon = component.icon or '  '
    return text, icon
  end
  return ''
end

return M
