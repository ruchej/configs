local utils = {}

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

function utils.opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end

function utils.map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function utils.merge(t1, t2)
    for k, v in pairs(t2) do
        if type(v) == 'table' then
            t1[k] = utils.merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end

    return t1
end

return utils
