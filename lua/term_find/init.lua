local api = vim.api
local fn = vim.fn

local M = {}

function TermJump(beforeCallback)
    local word = fn.expand("<cWORD>"):match("^[%s[(]*(.-)[%s%]%)]*$")
    local parts = fn.split(word, ":");
    local f = fn.findfile(parts[1])

    if f == "" then return end

    beforeCallback()

    vim.cmd("edit " .. f)

    if empty(parts[2]) and empty(parts[3]) then return end

    if empty(parts[3]) then
        api.nvim_win_set_cursor(0, {tonumber(parts[2]), 1})
    else
        api.nvim_win_set_cursor(0, {tonumber(parts[2]), tonumber(parts[3])})
    end
end

M.setup = function(opts)
    opts = opts or {}

    autocmd_pattern = opts.autocmd_pattern or "floaterm"

    keymap_mode = opts.keymap_mode or "n"
    keymap_mapping = opts.keymap_mapping or "gf"
    keymap_opts = opts.keymap_opts or {}

    callback = opts.callback or function() vim.cmd("FloatermHide") end

    api.nvim_create_autocmd("FileType", {
        pattern = autocmd_pattern,
        callback = function()
            vim.keymap.set(keymap_mode, keymap_mapping,
                           function() TermJump(callback) end, keymap_opts)
        end
    })
end

return M
