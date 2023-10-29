return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    event = "VeryLazy",
    dependencies = {
        'nvim-lua/plenary.nvim',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = 'make'
        }
    },
    opts = function()
        local actions = require "telescope.actions"
        return {
            defaults = {
                layout_strategy = 'horizontal',
                layout_config = {
                    horizontal = {
                        height = 0.6,
                        -- prompt_position = "top",
                    },
                },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                    }
                },
                sorting_strategy = 'descending',
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                }
            },
            pickers = {
                find_files = {
                    -- prompt_prefix = "🔍"
                },
                buffers = {
                    show_all_buffers = true,
                    mappings = {
                        i = {
                            ["<C-d>"] = actions.delete_buffer,
                        },
                        n = {
                            ["d"] = actions.delete_buffer,
                        },
                    }
                }
            },
        }
    end,
    config = function(_, opts)
        require("telescope").setup(opts)
        require("telescope").load_extension("fzf")
    end
}
