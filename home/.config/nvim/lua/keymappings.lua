local utils = require('utils')
local cmp = require('cmp')


utils.map('n', ',<space>', '<cmd>noh<cr>')      -- Clear highlights
utils.map('i', 'jk', '<Esc>')                   -- jk to escape
utils.map('n', '<space><space>', 'za')          -- Свернуть/развернуть складку

-- Переключение содержимого буфера
utils.map('n', 'gn', '<cmd>bn<cr>')             -- Следующее окно
utils.map('n', 'gp', '<cmd>bp<cr>')             -- Предыдущее окно
utils.map('n', 'gw', '<cmd>Bclose<cr>')         -- Закрыть окно

utils.map('n', '<C-n>', '<cmd>Ranger<cr>')      -- Вызвать файловый менеджер Ranger
utils.map('n', '<leader>s', '<cmd>call gitblame#echo()<cr>')

-- Настройки для модуля dap, отладчика python
utils.map('n', '<leader>b', '<cmd>lua require"dap".toggle_breakpoint()<cr>')
utils.map('n', '<f9>', '<cmd>lua require"dap".continue()<cr>')
utils.map('n', '<f8>', '<cmd>lua require"dap".step_over()<cr>')
utils.map('n', '<f7>', '<cmd>lua require"dap".step_into()<cr>')
utils.map('n', '<M-f8>', '<cmd>lua require"dap".repl.open()<cr>')
utils.map('n', '<leader>di', '<cmd>lua require"dap.ui.variables".hover()<cr>')
utils.map('v', '<leader>di', '<cmd>lua require"dap.ui.variables".visual_hover()<cr>')
utils.map('n', '<leader>d?', '<cmd>lua require"dap.ui.variables".scope()<cr>')
utils.map('n', '<leader>dui', '<cmd>lua require"dapui".toggle()<cr>')

-- Настройки для поиска файлов модуля telescope
utils.map('n', ',f', '<cmd>Telescope find_files<cr>')
utils.map('n', ',g', '<cmd>Telescope live_grep<cr>')

-- Настройки для включения превьюшки файла MarkDown
utils.map('n', '<c-p>', '<cmd>MarkdownPreviewToggle<cr>')

-- Настройка для  Gitsigns
utils.map('n', '<leader>hn', '<cmd>lua require"gitsigns".next_hunk()<cr>') -- Следующее изменение
utils.map('n', '<leader>hp', '<cmd>lua require"gitsigns".prev_hunk()<cr>') -- Предылущее изменение
