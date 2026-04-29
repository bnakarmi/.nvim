local M = {}

local function escape_label(s)
  return s:gsub("%%", "%%%%")
end

local function get_tab_bufnr(tabnr)
  local buflist = vim.fn.tabpagebuflist(tabnr)
  local winnr = vim.fn.tabpagewinnr(tabnr)
  return buflist[winnr]
end

local function get_tab_label_info(tabnr)
  local bufnr = get_tab_bufnr(tabnr)
  local name = vim.fn.bufname(bufnr)

  if name == "" then
    return {
      bufnr = bufnr,
      full = "",
      base = "[No Name]",
      modified = vim.bo[bufnr].modified,
    }
  end

  return {
    bufnr = bufnr,
    full = name,
    base = vim.fn.fnamemodify(name, ":t"),
    modified = vim.bo[bufnr].modified,
  }
end

local function build_unique_labels(tabs)
  local counts = {}

  for _, tab in ipairs(tabs) do
    counts[tab.base] = (counts[tab.base] or 0) + 1
  end

  for _, tab in ipairs(tabs) do
    if tab.base == "[No Name]" or counts[tab.base] == 1 or tab.full == "" then
      tab.label = tab.base
    else
      local parent = vim.fn.fnamemodify(tab.full, ":h:t")
      if parent == "" or parent == "." then
        tab.label = tab.base
      else
        tab.label = parent .. "/" .. tab.base
      end
    end

    tab.label = escape_label(tab.label)
  end
end

function M.render()
  local parts = {}
  local current = vim.fn.tabpagenr()
  local last = vim.fn.tabpagenr("$")
  local tabs = {}

  for i = 1, last do
    local info = get_tab_label_info(i)
    info.tabnr = i
    tabs[i] = info
  end

  build_unique_labels(tabs)

  for i, tab in ipairs(tabs) do
    local hl = (i == current) and "%#TabLineSel#" or "%#TabLine#"
    local modified = tab.modified and " [+]" or ""

    parts[#parts + 1] = hl
    parts[#parts + 1] = "%" .. i .. "T"
    parts[#parts + 1] = " " .. i .. " " .. tab.label .. modified .. " "

    if i < last then
      parts[#parts + 1] = "%#TabLineFill#│"
    end
  end

  parts[#parts + 1] = "%#TabLineFill#%T"
  return table.concat(parts)
end

function M.setup()
  vim.o.showtabline = 2
  vim.o.tabline = "%!v:lua.require('tabline').render()"
end

return M
