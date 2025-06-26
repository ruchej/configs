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

function utils.camelToSnake(str)
    local word = str:gsub("(%u)(%u%l)", "%1_%2")  -- разделяем заглавные буквы
              :gsub("(%l)(%u)", "%1_%2")   -- добавляем нижнее подчеркивание перед заглавной буквой
              :lower()                     -- приводим к нижнему регистру
    return word
end

function utils.snakeToCamel(snake_str)
    local word = snake_str:gsub("(_%l)", function(x) return x:sub(2):upper() end):gsub("^%u", string.lower)
    return word:sub(1, 1):lower() .. word:sub(2) -- Первая буква маленькая
end

-- Функция для преобразования слова под курсором
function utils.convertWordUnderCursor()
    -- Получаем текущее слово под курсором
    local word = vim.fn.expand("<cword>")
    local new_word = word
    if word == "" then
        print("Нет слова под курсором!") -- Проверка, если слово не найдется
        return
    end

    local snake_case_word = utils.camelToSnake(word)
    local camel_case_word = utils.snakeToCamel(word) -- Добавим функцию для преобразования в camelCase

    -- Проверяем, есть ли нижние подчеркивания в слове
    if word:find("_") then
        -- Если есть нижние подчеркивания, преобразуем в camelCase
        new_word = camel_case_word
    else
        -- Если нет, преобразуем в snake_case
        new_word = snake_case_word
    end

    -- Получаем текущую позицию курсора
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local line_number = cursor_pos[1] - 1

    -- Получаем текущее содержимое строки
    local current_line = vim.api.nvim_buf_get_lines(0, line_number, line_number + 1, false)[1]

    -- Заменяем слово в строке
    local updated_line = current_line:gsub(word, new_word, 1)
    -- Обновляем строку в буфере
    vim.api.nvim_buf_set_lines(0, line_number, line_number + 1, false, { updated_line })

    -- Возвращаем курсор на позицию конца нового слова
    local new_pos = cursor_pos[2] - #word + #new_word
    vim.api.nvim_win_set_cursor(0, { cursor_pos[1], new_pos })
end

_G.convertWordUnderCursor = utils.convertWordUnderCursor
_G.camelToSnake = utils.camelToSnake
_G.snakeToCamel = utils.snakeToCamel

return utils
