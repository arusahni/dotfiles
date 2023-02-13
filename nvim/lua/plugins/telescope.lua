local actions = require "telescope.actions"

require("telescope").setup {
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
        }
    }
}

require("telescope").load_extension("fzf")

