local utils = require('utils')
local nvim_lsp = require('lspconfig')

local cmd = vim.cmd
local autocmd = vim.api.nvim_create_autocmd
local indent = 4


utils.opt('o', 'mouse', 'a')
utils.opt('o', 'clipboard', 'unnamedplus')
utils.opt('o', 'encoding', 'utf-8')
utils.opt('o', 'timeoutlen', 3000)

utils.opt('w', 'number', true)
utils.opt('w', 'relativenumber', true)
utils.opt('w', 'scrolloff', 7)
utils.opt('w', 'cursorline', true)

utils.opt('o', 'tabstop', indent)
utils.opt('o', 'softtabstop', indent)
utils.opt('o', 'shiftwidth', indent)
utils.opt('o', 'expandtab', true)
utils.opt('o', 'smartindent', true)
utils.opt('o', 'fileformat', 'unix')

utils.opt('o', 'splitright', true)
utils.opt('o', 'splitbelow', true)
utils.opt('o', 'incsearch', true)
utils.opt('o', 'diffopt', 'vertical')
utils.opt('o', 'foldmethod', 'indent')
utils.opt('o', 'foldlevelstart', 99)

utils.opt('o', 'path', '**')
utils.opt('o', 'wildmenu', true)
utils.opt('o', 'completeopt', 'menuone,noselect')
utils.opt('o', 'langmap', [[ёйцукенгшщзхъфывапролджэячсмитьбю;`qwertyuiop[]asdfghjkl\;'zxcvbnm\,.,ЙЦУКЕHГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>]])
utils.opt('o', 'statusline', '%{expand("%:~:.")} %h%w%m%r %=%(%l,%c%V %= %P%)')

cmd 'syntax enable'
cmd 'filetype plugin indent on'
cmd 'colorscheme gruvbox'
cmd 'set noendofline'
cmd 'set swapfile'
cmd 'syn sync fromstart'

autocmd('BufWritePre', {pattern = '*.py', command = [[%s/\s\+$//e]]})

-- nvim-lspconfig

vim.lsp.set_log_level 'warn'
require('vim.lsp.log').set_format_func(vim.inspect)

-- Mappings.
-- See: https://github.com/neovim/nvim-lspconfig/tree/54eb2a070a4f389b1be0f98070f81d23e2b1a715#suggested-configuration
local opts = { noremap=true, silent=true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
local bufopts = { noremap=true, silent=true, buffer=bufnr }

-- Переход к объявлению
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
-- Переход к определению
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
-- Показать всплывающую подсказку
vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
-- Переход к реализации
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
-- Показать информацию о сигнатуре функции
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
-- Добавить папку в рабочее пространство
vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
-- Удалить папку из рабочего пространства
vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
-- Показать список папок рабочего пространства
vim.keymap.set('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end, bufopts)
-- Показать определение типа
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
-- Переименование символа
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
-- Показать действия кода (code actions)
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
-- Показать ссылки на символ
vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
-- Форматировать файл (асинхронно)
vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

-- Configure `ruff-lsp`.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#ruff_lsp
-- For the default config, along with instructions on how to customize the settings
--require('lspconfig').ruff_lsp.setup {
--  on_attach = on_attach,
--  init_options = {
--    settings = {
--      -- Any extra CLI arguments for `ruff` go here.
--      args = {},
--    }
--  }
--}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
vim.g.python3_host_prog = '/usr/bin/python'
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local servers = {
        'pyright',
        'lua_ls',
        'ruff',
        'jsonls',
        'marksman',
        'bashls',
        'ts_ls',
        'volar',
        'clangd',
--        'ruff_lsp',
    }
for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup {
        on_attach = on_attach,
        capabilities = capabilities,
        flags = { debounce_text_changes = 150, }
    }
    require('servers/' .. lsp)
end

-- end nvim-lspconfig

--  Настройки для дебага python файла. Плагин dap
--  https://github.com/mfussenegger/nvim-dap#usage
require('dap-python').setup('/usr/bin/python')

table.insert(require('dap').configurations.python, {
  type = 'python',
  request = 'launch',
  name = 'My custom launch configuration',
  program = '${file}',
})

vim.fn.sign_define('DapBreakpoint', {text='⏺', texthl='DapBreakpoint', linehl='DapBreakpoint', numhl='DapBreakpoint'})
vim.fn.sign_define('DapStopped', {text='⏹', texthl='DapStopped', linehl='DapStopped', numhl='DapStopped'})


local dap, dapui = require("dap"), require("dapui")

dap.listeners.after["event_initialized"]["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before["event_terminated"]["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before["event_exited"]["dapui_config"] = function()
  dapui.close()
end


dapui.setup({
  icons = {
    expanded = "▾",
    collapsed = "▸",
    current_frame = "🔵",
  },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  element_mappings = {}, -- Добавьте соответствующие отображения элементов
  force_buffers = true, -- Добавьте соответствующее значение
  controls = {
    enabled = true,
    element = "widgets",
    icons = {
      enabled = true,
      pause = "⏸️",
      play = "▶️",
      step_into = "↘️",
      step_over = "➡️",
      step_out = "↖️",
      step_back = "⏪",
      run_last = "⏩",
      terminate = "⛔",
    },
  },
  expand_lines = vim.fn.has("nvim-0.9.2"),
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40,
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25,
      position = "bottom",
    },
  },
  floating = {
    max_height = nil,
    max_width = nil,
    border = "single",
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    indent = 2, -- Добавьте соответствующее значение
    max_type_length = nil,
  },
})
-----------------------------------------------------------------------


vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require('gitsigns').setup {
  signs = {
    add          = { text = '┃' },
    change       = { text = '┃' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
  numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = false,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 100,
  },
  current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000, -- Disable if file is longer than this (in lines)
  preview_config = {
    -- Options passed to nvim_open_win
    border = 'single',
    style = 'minimal',
    relative = 'cursor',
    row = 0,
    col = 1
  },
}

require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup()

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

    modules = {
    -- Set this to true to enable the TypeScript parser
    -- If you want to enable TypeScript highlighting, you need to set this to true
    -- even if you don't have any TypeScript files in your project
    -- enabled = true,

    -- If you want to enable TypeScript highlighting, you need to set this to true
    -- even if you don't have any TypeScript files in your project
    --disable = {},

    -- Setting this to true will run the TypeScript compiler and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    -- additional_vim_regex_highlighting = false,
  },
  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
    -- -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require'lspconfig'.volar.setup{
  init_options = {
    typescript = {
      tsdk = '/usr/local/lib/node_modules/typescript/lib'
    }
  }
}

-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                       -- the default case_mode is "smart_case"
    }
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- require('lspconfig').ruff_lsp.setup{}
require("ibl").setup()
require('zen-mode').setup({window={width=0.85}})
require("lsp-file-operations").setup()
require('nvim-surround').setup()

