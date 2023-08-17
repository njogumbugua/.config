vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Treesitter mappings
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true })
vim.keymap.set('n', '<leader>c', ':NvimTreeCollapse<CR>', { noremap = true })
vim.keymap.set('n', '<leader>s', ':NvimTreeFindFile<CR>', { noremap = true })
vim.keymap.set('n', '<leader>h', ':nohlsearch<CR>', { noremap = true })
vim.keymap.set('i', 'jk', '<ESC>', { noremap = true })

-- Telescope mappings
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { noremap = true })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { noremap = true })

-- Diagnostics mappings
 --vim.keymap.set("n", "<leader>nn", "<cmd>TroubleToggle<cr>",
   --{silent = true, noremap = true}
 --)
 --vim.keymap.set("n", "<leader>nw", "<cmd>TroubleToggle workspace_diagnostics<cr>",
   --{silent = true, noremap = true}
 --)
 --vim.keymap.set("n", "<leader>nd", "<cmd>TroubleToggle document_diagnostics<cr>",
   --{silent = true, noremap = true}
 --)
 --vim.keymap.set("n", "<leader>nl", "<cmd>TroubleToggle loclist<cr>",
   --{silent = true, noremap = true}
 --)
 --vim.keymap.set("n", "<leader>nq", "<cmd>TroubleToggle quickfix<cr>",
   --{silent = true, noremap = true}
 --)
 --vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>",
   --{silent = true, noremap = true}
 --)

 -- Lua
vim.keymap.set("n", "<leader>nn", function() require("trouble").open() end)
vim.keymap.set("n", "<leader>nw", function() require("trouble").open("workspace_diagnostics") end)
vim.keymap.set("n", "<leader>nd", function() require("trouble").open("document_diagnostics") end)
vim.keymap.set("n", "<leader>nq", function() require("trouble").open("quickfix") end)
vim.keymap.set("n", "<leader>nl", function() require("trouble").open("loclist") end)
vim.keymap.set("n", "gR", function() require("trouble").open("lsp_references") end)

-- Lazy git mappings
vim.keymap.set("n", "<leader>g", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", {noremap = true, silent = true})

-- Debugger mappings
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)
