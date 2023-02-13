local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap =
    fn.system({"git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path})
end


vim.api.nvim_cmd({
    cmd = "packadd",
    args = {"packer.nvim"},
}, {})

return require("packer").startup {
  function(use)
    -- Packer can manage itself
    use "wbthomason/packer.nvim"

    use "RRethy/nvim-base16"

    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = [[ require('plugins/treesitter') ]]
    }

    use 'tpope/vim-repeat'

    -- use 'szw/vim-ctrlspace'

    use {
      'nkakouros-original/numbers.nvim',
      config = [[ require('plugins/numbers') ]]
    }

    use {
      'kyazdani42/nvim-tree.lua',
      requires = {
        'kyazdani42/nvim-web-devicons' -- optional, for file icons
      },
      config = [[ require('plugins/nvim-tree') ]]
    }

    -- use {
    --   'junegunn/fzf.vim',
    --   requires = {
    --     { 'junegunn/fzf', run = ":call fzf#install()" }
    --   }
    -- }

    use {
      'nvim-telescope/telescope.nvim',
      tag = '0.1.1',
      requires = {
        {'nvim-lua/plenary.nvim' },
        {
          'nvim-telescope/telescope-fzf-native.nvim',
          run = 'make'
        }
      },
      config = [[ require('plugins/telescope') ]]
    }

    use 'tpope/vim-surround'

    use 'tpope/vim-fugitive'

    use 'tpope/vim-eunuch'

    use 'thinca/vim-localrc'

    use 'simnalamburt/vim-mundo'

    use {
      'lukas-reineke/indent-blankline.nvim',
      config = [[ require('plugins/indent-blankline') ]]
    }

    use {
      'nvim-lualine/lualine.nvim',
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = [[ require('plugins/lualine') ]]
    }

    use 'wellle/targets.vim'

    use 'bronson/vim-trailing-whitespace'

    use {
      'kassio/neoterm',
      config = [[ require('plugins/neoterm') ]]
    }

    use {
      'janko-m/vim-test',
      config = [[ require('plugins/test') ]]
    }

    use {
      'neoclide/coc.nvim',
      branch = 'release',
      run = ':CocInstall coc-json coc-yaml coc-snippets coc-ultisnips coc-css coc-eslint coc-prettier coc-tsserver coc-vetur coc-pyright coc-rust-analyzer coc-elixir coc-diagnostic coc-stylelint coc-flutter'
    }

    -- use {
    --   'Shougo/deoplete.nvim',
    --   run = ':UpdateRemotePlugins'
    -- }

    -- use {
    --   'Shougo/vimproc.vim',
    --   run = 'make'
    -- }

    use 'JoosepAlviste/nvim-ts-context-commentstring'

    use {
      'numToStr/Comment.nvim',
      config = [[ require('plugins/comment') ]]
    }

    use 'junegunn/vim-easy-align'

    use {
      'norcalli/nvim-colorizer.lua',
      config = [[ require('plugins/nvim-colorizer') ]]
    }

    use 'gpanders/editorconfig.nvim'

    if packer_bootstrap then
      require("packer").sync()
    end
  end
}
