local utils = require('utils')
local zenmode = require('zen-mode')


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
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Настройки для включения превьюшки файла MarkDown
utils.map('n', '<c-p>', '<cmd>MarkdownPreviewToggle<cr>')

-- Настройка для  Gitsigns
utils.map('n', '<leader>hn', '<cmd>lua require"gitsigns".nav_hunk("next")<cr>') -- Следующее изменение
utils.map('n', '<leader>hp', '<cmd>lua require"gitsigns".nav_hunk("prev")<cr>') -- Предылущее изменение
utils.map('n', '<leader>hv', '<cmd>lua require"gitsigns".preview_hunk()<cr>') -- Показать изменения
utils.map('n', '<leader>td', '<cmd>lua require"gitsigns".preview_hunk_inline()()<cr>') -- Показать удалённые строки

-- Настройка для zen-mode
vim.keymap.set('n', '<C-w>o', zenmode.toggle, {})

utils.map('n', '<leader>cs', ':lua convertWordUnderCursor()<CR>', { noremap = true, silent = true })
