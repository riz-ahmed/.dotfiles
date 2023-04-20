local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local setup, packer = pcall(require, 'packer')
if not setup then
    return
end

return packer.startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- colorscheme
    --use "lunarvim/darkplus.nvim"
    use "Mofiqul/vscode.nvim"
    --use 'Mofiqul/dracula.nvim'
    --use "arcticicestudio/nord-vim"
    -- use 'folke/tokyonight.nvim'
    -- essential lua funtions required by other plugins
    use "nvim-lua/plenary.nvim"

    -- plugin to manage nvim and tmux split planes
    use "christoomey/vim-tmux-navigator"

    -- plugin for resizing splits in the window
    use "szw/vim-maximizer"

    -- surrounding quotes, braces, etc.,
    use "tpope/vim-surround"

    -- replacing copied items
    use "vim-scripts/ReplaceWithRegister"

    -- commenting using gc comment
    use "numToStr/Comment.nvim"

    -- file-explorer plugin
    use {"nvim-tree/nvim-tree.lua", requires={"nvim-tree/nvim-web-devicons"}, tag="nightly"}

    -- status line
    use {
       'nvim-lualine/lualine.nvim',
       requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- fuzzyfinder for searching files, function definitions, live grep etc,.
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- telescope requires this plugin to work properly
    use {
       'nvim-telescope/telescope.nvim', tag = '0.1.0',
       requires = { {'BurntSushi/ripgrep', opt = true} }
     }

    -- autopairs quotes, braces etc.,
    use "windwp/nvim-autopairs"
    use "windwp/nvim-ts-autotag"

    -- vim plugin for viewing function definitions in the sidebar
    use "https://github.com/preservim/tagbar"

    -- use treesitter for better syntac highlighting as well as language syntax recognition
    use({
       "nvim-treesitter/nvim-treesitter",
       run = function()
           local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
           ts_update()
       end,
    })
    -- leap - for fast motions using page hints (just like in qutebrowser)
    use ("ggandor/leap.nvim")

    -- a game based learning of VIM motions
    --use "ThePrimeagen/vim-be-good"

    -- rainbow parenthesis
    use "p00f/nvim-ts-rainbow"

    -- CoC (completions and LSP server)
    use ({"neoclide/coc.nvim", branch = 'release'})

    -- vimwiki
    use 'vimwiki/vimwiki'

    -- which-key that docs key bindings
    use {
       "folke/which-key.nvim",
       config = function()
           vim.o.timeout = true
           vim.o.timeoutlen = 300
       end
    }
    --
  --  use({
	 --  'rose-pine/neovim',
	 --  as = 'rose-pine',
	 --  config = function()
		--   vim.cmd('colorscheme rose-pine')
	 --  end
  -- })  
    --
    if packer_bootstrap then
        require('packer').sync()
    end


end)
