-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  keys = {
    { '<F3>', ':Neotree toggle reveal<CR>', desc = 'NeoTree reveal', silent = true },
  },
  opts = {
    filesystem = {
      commands = {
        avante_add_files = function(state)
          local node = state.tree:get_node()
          local filepath = node:get_id()
          local relative_path = require('avante.utils').relative_path(filepath)

          local sidebar = require('avante').get()

          local open = sidebar:is_open()
          -- 确保 avante 侧边栏已打开
          if not open then
            require('avante.api').ask()
            sidebar = require('avante').get()
          end

          sidebar.file_selector:add_selected_file(relative_path)

          -- 删除 neo tree 缓冲区
          if not open then
            sidebar.file_selector:remove_selected_file 'neo-tree filesystem [1]'
          end
        end,
      },
      window = {
        mappings = {
          ['<F3>'] = 'close_window',
          ['oa'] = 'avante_add_files',
        },
      },
    },
  },
}
