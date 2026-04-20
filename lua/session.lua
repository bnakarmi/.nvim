local M = {}

local fn = vim.fn
local api = vim.api
local json = vim.json

local SESSION_DIR = fn.stdpath("data") .. "/sessions"

M.config = {
    skip_dirs = {
        fn.expand("~"),
    },
    sort_by = "updated",
    sessionoptions = {
        "buffers",
        "curdir",
        "folds",
        "help",
        "tabpages",
        "winsize",
        "terminal",
        "localoptions",
    },
}

local state = {
    sort_by = M.config.sort_by,
}

local function ensure_dir(path)
    if fn.isdirectory(path) == 0 then
        fn.mkdir(path, "p")
    end
end

local function notify(msg, level)
    vim.notify(msg, level or vim.log.levels.INFO, { title = "session" })
end

local function sanitize_name(name)
    name = name == "" and "project" or name
    return name:gsub("[^%w%-_]", "_")
end

local function cwd()
    return fn.getcwd()
end

local function cwd_hash(path)
    return fn.sha256(path):sub(1, 8)
end

local function project_name(path)
    return sanitize_name(fn.fnamemodify(path, ":t"))
end

local function session_id(path)
    return project_name(path) .. "-" .. cwd_hash(path)
end

local function session_paths(path)
    local id = session_id(path)
    return {
        id = id,
        session = SESSION_DIR .. "/" .. id .. ".vim",
        meta = SESSION_DIR .. "/" .. id .. ".json",
    }
end

local function is_skipped_dir(path)
    for _, dir in ipairs(M.config.skip_dirs or {}) do
        if path == dir then
            return true
        end
    end
    return false
end

local function set_sessionoptions()
    vim.opt.sessionoptions = M.config.sessionoptions
end

local function has_real_buffers()
    for _, buf in ipairs(api.nvim_list_bufs()) do
        if api.nvim_buf_is_loaded(buf) then
            local name = api.nvim_buf_get_name(buf)
            local buftype = vim.bo[buf].buftype
            if name ~= "" and buftype == "" then
                return true
            end
        end
    end
    return false
end

local function read_file(path)
    local f = io.open(path, "r")
    if not f then
        return nil
    end
    local content = f:read("*a")
    f:close()
    return content
end

local function write_file(path, content)
    local f = io.open(path, "w")
    if not f then
        return false
    end
    f:write(content)
    f:close()
    return true
end

local function delete_file(path)
    if fn.filereadable(path) == 1 then
        os.remove(path)
    end
end

local function read_meta(path)
    local content = read_file(path)
    if not content or content == "" then
        return nil
    end
    local ok, decoded = pcall(json.decode, content)
    if not ok then
        return nil
    end
    return decoded
end

local function write_meta(meta_path, data)
    local ok, encoded = pcall(json.encode, data)
    if not ok then
        return false
    end
    return write_file(meta_path, encoded)
end

local function current_session_paths()
    return session_paths(cwd())
end

local function build_meta(path)
    local p = session_paths(path)
    return {
        id = p.id,
        name = project_name(path),
        cwd = path,
        session_file = p.session,
        updated_at = os.time(),
    }
end

local function format_time(ts)
    if not ts then
        return "unknown"
    end
    return os.date("%Y-%m-%d %H:%M", ts)
end

local function shorten_path(path, max_len)
    if #path <= max_len then
        return path
    end
    return "..." .. path:sub(#path - max_len + 4)
end

local function list_session_meta(sort_by)
    ensure_dir(SESSION_DIR)

    local files = fn.readdir(SESSION_DIR, [[v:val =~ '\.json$']])
    local items = {}

    for _, file in ipairs(files) do
        local meta_path = SESSION_DIR .. "/" .. file
        local meta = read_meta(meta_path)
        if meta and meta.id and meta.cwd then
            local session_path = SESSION_DIR .. "/" .. meta.id .. ".vim"
            meta.session_file = session_path
            meta.meta_file = meta_path
            meta.exists = fn.filereadable(session_path) == 1
            table.insert(items, meta)
        end
    end

    table.sort(items, function(a, b)
        if sort_by == "name" then
            local an = (a.name or ""):lower()
            local bn = (b.name or ""):lower()
            if an == bn then
                return (a.updated_at or 0) > (b.updated_at or 0)
            end
            return an < bn
        end

        if sort_by == "path" then
            local ac = (a.cwd or ""):lower()
            local bc = (b.cwd or ""):lower()
            if ac == bc then
                return (a.updated_at or 0) > (b.updated_at or 0)
            end
            return ac < bc
        end

        return (a.updated_at or 0) > (b.updated_at or 0)
    end)

    return items
end

function M.save(path)
    path = path or cwd()

    if is_skipped_dir(path) then
        return
    end

    if not has_real_buffers() then
        return
    end

    ensure_dir(SESSION_DIR)
    set_sessionoptions()

    local p = session_paths(path)
    vim.cmd("silent! mksession! " .. fn.fnameescape(p.session))

    local meta = build_meta(path)
    write_meta(p.meta, meta)
end

function M.load(path)
    path = path or cwd()

    if is_skipped_dir(path) then
        return false
    end

    local p = session_paths(path)
    if fn.filereadable(p.session) == 1 then
        set_sessionoptions()
        vim.cmd("silent! source " .. fn.fnameescape(p.session))
        return true
    end

    return false
end

function M.delete(item)
    if not item then
        return
    end

    delete_file(item.session_file or (SESSION_DIR .. "/" .. item.id .. ".vim"))
    delete_file(item.meta_file or (SESSION_DIR .. "/" .. item.id .. ".json"))
end

function M.cleanup_stale()
    local items = list_session_meta(state.sort_by)
    local removed = 0

    for _, item in ipairs(items) do
        if not item.exists then
            delete_file(item.meta_file)
            removed = removed + 1
        end
    end

    notify("Removed " .. removed .. " stale metadata file(s)")
end

local function define_highlights()
    vim.api.nvim_set_hl(0, "SimpleSessionTitle", { link = "Title" })
    vim.api.nvim_set_hl(0, "SimpleSessionCurrent", {
        fg = "#98c379",
        bold = true,
    })
    vim.api.nvim_set_hl(0, "SimpleSessionName", { link = "Directory" })
    vim.api.nvim_set_hl(0, "SimpleSessionPath", { link = "Comment" })
    vim.api.nvim_set_hl(0, "SimpleSessionStale", {
        fg = "#e5c07b",
        italic = true,
    })
    vim.api.nvim_set_hl(0, "SimpleSessionFooter", { link = "NonText" })
    vim.api.nvim_set_hl(0, "SimpleSessionBorder", { link = "FloatBorder" })
end

local function cycle_sort(current)
    local order = { "updated", "name", "path" }
    for i, mode in ipairs(order) do
        if mode == current then
            return order[(i % #order) + 1]
        end
    end
    return "updated"
end

local function confirm_replace()
    local answer = fn.confirm(
        "Load selected session and replace current layout?",
        "&Yes\n&No",
        2
    )
    return answer == 1
end

local function set_buf_lines(buf, lines)
    api.nvim_buf_set_option(buf, "modifiable", true)
    api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    api.nvim_buf_set_option(buf, "modifiable", false)
end

local function apply_highlights(buf, items, current_id, width)
    api.nvim_buf_clear_namespace(buf, -1, 0, -1)

    api.nvim_buf_add_highlight(buf, -1, "SimpleSessionTitle", 0, 0, -1)

    local line_nr = 1
    for _, item in ipairs(items) do
        local is_current = item.id == current_id
        local stale = not item.exists

        api.nvim_buf_add_highlight(
            buf,
            -1,
            is_current and "SimpleSessionCurrent" or "SimpleSessionName",
            line_nr,
            0,
            math.min(width, 3)
        )

        api.nvim_buf_add_highlight(
            buf,
            -1,
            is_current and "SimpleSessionCurrent" or "SimpleSessionName",
            line_nr,
            4,
            -1
        )

        api.nvim_buf_add_highlight(buf, -1, "SimpleSessionPath", line_nr + 1, 2, -1)

        if stale then
            api.nvim_buf_add_highlight(buf, -1, "SimpleSessionStale", line_nr, 0, -1)
        end

        line_nr = line_nr + 3
    end
end

local function make_lines(items, current_id, width, height, sort_by)
    local lines = {}

    table.insert(lines, "")

    if #items == 0 then
        table.insert(lines, "  No sessions found.")
        table.insert(lines, "")
    else
        for i, item in ipairs(items) do
            local marker = item.id == current_id and "*" or " "
            local stale = item.exists and "" or " [stale]"
            local top = string.format(
                "%s %2d %s%s",
                marker,
                i,
                item.name or item.id,
                stale
            )
            local bottom = string.format(
                "  %s   %s",
                shorten_path(item.cwd or "", math.max(20, width - 24)),
                format_time(item.updated_at)
            )

            table.insert(lines, top)
            table.insert(lines, bottom)
            table.insert(lines, "")
        end
    end

    local reserved_footer_lines = 1
    while #lines < height - reserved_footer_lines do
        table.insert(lines, "")
    end

    if #lines > height - reserved_footer_lines then
        lines = vim.list_slice(lines, 1, height - reserved_footer_lines)
    end

    table.insert(
        lines,
        string.format(
            " Load - <CR> | Delete - d | Clean Stale - x | Refresh - r | Sort:%s - s | Close - q ",
            sort_by
        )
    )

    return lines
end

local function item_index_from_cursor(items, cursor_line)
    if #items == 0 then
        return nil
    end

    local line = 2
    for i, _ in ipairs(items) do
        if cursor_line >= line and cursor_line <= line + 1 then
            return i
        end
        line = line + 3
    end

    return nil
end

local function close_win(win)
    if win and api.nvim_win_is_valid(win) then
        api.nvim_win_close(win, true)
    end
end

function M.open_ui()
    define_highlights()

    local items = list_session_meta(state.sort_by)
    local current_id = current_session_paths().id

    local buf = api.nvim_create_buf(false, true)

    local width = math.min(100, math.floor(vim.o.columns * 0.75))
    local height = math.min(30, math.floor(vim.o.lines * 0.75))
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    local win = api.nvim_open_win(buf, true, {
        relative = "editor",
        style = "minimal",
        border = "rounded",
        width = width,
        height = height,
        row = row,
        col = col,
        title = " Session Manager ",
        title_pos = "center",
    })

    api.nvim_set_option_value("winhl", "FloatBorder:SimpleSessionBorder", {
        win = win,
    })

    api.nvim_buf_set_option(buf, "bufhidden", "wipe")
    api.nvim_buf_set_option(buf, "filetype", "simple-session")
    api.nvim_buf_set_option(buf, "modifiable", false)

    local function get_selected_item()
        local cursor = api.nvim_win_get_cursor(win)
        local idx = item_index_from_cursor(items, cursor[1])
        if not idx then
            return nil, nil
        end
        return items[idx], idx
    end

    local function render()
        items = list_session_meta(state.sort_by)
        current_id = current_session_paths().id

        local lines = make_lines(items, current_id, width, height, state.sort_by)
        set_buf_lines(buf, lines)
        apply_highlights(buf, items, current_id, width)

        if #items > 0 then
            api.nvim_win_set_cursor(win, { 2, 0 })
        end
    end

    local function refresh_keep_cursor()
        local cursor = api.nvim_win_get_cursor(win)
        render()
        local max_line = api.nvim_buf_line_count(buf)
        local line = math.min(cursor[1], max_line)
        pcall(api.nvim_win_set_cursor, win, { line, cursor[2] })
    end

    local function load_selected()
        local item = get_selected_item()
        if not item then
            notify("No session selected", vim.log.levels.WARN)
            return
        end

        if not item.exists then
            notify("Selected session file is missing", vim.log.levels.WARN)
            return
        end

        if not confirm_replace() then
            return
        end

        close_win(win)

        vim.cmd("silent! wall")
        vim.cmd("cd " .. fn.fnameescape(item.cwd))
        vim.cmd("silent! %bwipeout!")
        local ok = M.load(item.cwd)

        if ok then
            notify("Loaded session: " .. (item.name or item.id))
        else
            notify("Failed to load session", vim.log.levels.WARN)
        end
    end

    local function delete_selected()
        local item = get_selected_item()
        if not item then
            notify("No session selected", vim.log.levels.WARN)
            return
        end

        local answer = fn.confirm(
            "Delete session '" .. (item.name or item.id) .. "'?\n" .. (item.cwd or ""),
            "&Yes\n&No",
            2
        )

        if answer ~= 1 then
            return
        end

        M.delete(item)
        refresh_keep_cursor()
        notify("Deleted session: " .. (item.name or item.id))
    end

    local function cleanup_stale()
        local answer = fn.confirm(
            "Delete all stale metadata entries?",
            "&Yes\n&No",
            2
        )

        if answer ~= 1 then
            return
        end

        M.cleanup_stale()
        refresh_keep_cursor()
    end

    local function cycle_sort_mode()
        state.sort_by = cycle_sort(state.sort_by)
        refresh_keep_cursor()
    end

    local function map(lhs, rhs)
        vim.keymap.set("n", lhs, rhs, {
            buffer = buf,
            nowait = true,
            noremap = true,
            silent = true,
        })
    end

    map("q", function()
        close_win(win)
    end)

    map("<Esc>", function()
        close_win(win)
    end)

    map("<CR>", load_selected)
    map("d", delete_selected)
    map("r", refresh_keep_cursor)
    map("s", cycle_sort_mode)
    map("x", cleanup_stale)

    render()
end

function M.setup(opts)
    if opts then
        M.config = vim.tbl_deep_extend("force", M.config, opts)
    end

    state.sort_by = M.config.sort_by or "updated"

    ensure_dir(SESSION_DIR)

    local group = api.nvim_create_augroup("SimpleSessionManager", { clear = true })

    api.nvim_create_autocmd("VimEnter", {
        group = group,
        callback = function()
            M.load()
        end,
    })

    api.nvim_create_autocmd("VimLeavePre", {
        group = group,
        callback = function()
            M.save()
        end,
    })

    api.nvim_create_user_command("SessionSave", function()
        M.save()
        notify("Session saved")
    end, {})

    api.nvim_create_user_command("SessionLoad", function()
        local ok = M.load()
        if ok then
            notify("Session loaded")
        else
            notify("No session for current cwd", vim.log.levels.WARN)
        end
    end, {})

    api.nvim_create_user_command("SessionManager", function()
        M.open_ui()
    end, {})

    api.nvim_create_user_command("SessionCleanupStale", function()
        M.cleanup_stale()
    end, {})
end

return M
