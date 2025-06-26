local fn = vim.fn

-- Auto install packer.nvim if not exists
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  local packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]
vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua


return require('packer').startup(function(use)

    use {'neovim/nvim-lspconfig'}
    use {'williamboman/mason.nvim', opts = {ensure_installed = {"cland"}}}
    use {'williamboman/mason-lspconfig.nvim'}
    use {'hrsh7th/nvim-cmp'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'saadparwaiz1/cmp_luasnip'}
    use {'L3MON4D3/LuaSnip'}

    -- Для дебагов, точки остановки
    use {'mfussenegger/nvim-dap'}
    use {'mfussenegger/nvim-dap-python'}
    use { "rcarriga/nvim-dap-ui", requires = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
    -- plenary.nvim набор функций для работы с lua
    use {'nvim-lua/plenary.nvim'}
    -- gitsigns.nvim Сверхбыстрые украшения git реализованы чисто в lua/teal.
    use {'lewis6991/gitsigns.nvim'}
    -- Сведения о текущей выбранной строке см. в разделе Git Blame в строке состояния.
    use {'zivyangll/git-blame.vim'}

    -- Этот плагин добавляет направляющие отступов ко всем линиям (включая пустые линии).
    use {'lukas-reineke/indent-blankline.nvim', main = "ibl", opts = {}}

    --use {'preservim/nerdtree'}
    use {'francoiscabrol/ranger.vim'}
    use {'rbgrouleff/bclose.vim'}
    use {'kylechui/nvim-surround'}
    use {'easymotion/vim-easymotion'}

    -- color schemas
    use {'morhetz/gruvbox'}  -- colorscheme gruvbox
    use {'mhartington/oceanic-next'}  -- colorscheme OceanicNext
    use {'kaicataldo/material.vim', branch = 'main' }
    use {'ayu-theme/ayu-vim'}

    -- For JS/JSX
    use {'yuezk/vim-js'}
    use {'maxmellon/vim-jsx-pretty'}

    -- python pep8 indent
    use {'Vimjas/vim-python-pep8-indent'}

    -- Поиск по файлам
    use {'nvim-telescope/telescope.nvim',  tag = '0.1.8', requires = { {'nvim-lua/plenary.nvim'} } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release' }

    --
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    -- install without yarn or npm
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    use {'mechatroner/rainbow_csv'}
    use {'sindrets/diffview.nvim'}

    use {'folke/zen-mode.nvim'}

    use {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
        }
    }

    use {
      'antosha417/nvim-lsp-file-operations',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-neo-tree/neo-tree.nvim',
      },
      config = function()
        require("lsp-file-operations").setup()
      end,
    }

  --if packer_bootstrap then
  --  require('packer').sync()
  --end
end)
