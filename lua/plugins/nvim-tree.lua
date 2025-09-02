return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    -- registra cedo (lazy.nvim) e funciona mesmo antes do plugin carregar
    { "<C-n>", "<cmd>NvimTreeFindFileToggle<CR>", desc = "Toggle NvimTree" },
    { "<leader>e", "<cmd>NvimTreeFocus<CR>",      desc = "Focus NvimTree"   },
  },
  config = function()
    -- desabilita netrw (recomendado)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local api = require("nvim-tree.api")

    require("nvim-tree").setup({
      -- janela
      view = {
        side = "left",
        width = 30,
        preserve_window_proportions = true,
      },

      -- ícones/renderer
      renderer = {
        highlight_git = true,
        highlight_opened_files = "name",
        indent_markers = { enable = true },
        icons = {
          show = { git = true, folder = true, file = true, folder_arrow = true },
          glyphs = {
            git = {
              unstaged = "",
              staged = "S",
              unmerged = "",
              renamed  = "R",
              untracked= "U",
              deleted  = "D",
              ignored  = "",
            },
          },
        },
      },

      -- git e diagnostics
      git = { enable = true, ignore = false, show_on_dirs = true },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = { hint = "󰌶", info = "", warning = "", error = "" },
      },

      -- comportamento de abrir arquivos
      actions = {
        open_file = {
          quit_on_open = false,        -- mantém o explorer aberto
          resize_window = true,
          window_picker = { enable = false }, -- evita prompt pra escolher janela
        },
      },

      -- sincroniza com diretório do projeto/arquivo
      update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = { "node_modules", ".git" },
      },

      -- filtros úteis
      filters = {
        dotfiles = false,
        git_ignored = false,
      },

      -- mapeamentos dentro do NvimTree
      on_attach = function(bufnr)
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = bufnr, noremap = true, silent = true, nowait = true, desc = "nvim-tree: "..desc })
        end
        api.config.mappings.default_on_attach(bufnr)      -- mantém os padrões
        map("v", api.node.open.vertical,   "Open: Vertical Split")   -- v = split vertical
        map("s", api.node.open.horizontal, "Open: Horizontal Split") -- s = split horizontal
        map("t", api.node.open.tab,        "Open: New Tab")          -- t = nova aba
        map("h", api.node.navigate.parent_close, "Close Directory")  -- navegação estilo netrw
        map("l", api.node.open.edit,            "Open")              -- l = abrir
        map("o", api.node.open.edit,            "Open")              -- o = abrir
      end,
    })
  end,
}

