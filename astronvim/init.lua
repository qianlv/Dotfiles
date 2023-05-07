return { 
  options = {
    opt = {
      cmdheight = 1,
      listchars = {
        tab = "»·",
        trail = "·",
      },
      list = true,
    },
  },

  colorscheme = "gruvbox-material",

  mappings = {
    n = {
      ["<S-l>"] = { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" },
      ["<S-h>"] = {
        function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        desc = "Previous buffer",
      },
      ["<Cr>"] = {
        function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
        desc = "Comment line",
      },
    },
    v = {
      ["<Cr>"] = {
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Toggle comment line"
      },
    },
  },
  lsp = {
    servers = {
      "pyright",
      "clangd",
      "jdtls",
      "rust_analyzer",
    },
    formatting = {
      format_on_save = false, -- enable or disable automatic formatting on save
    },
    setup_handlers = {
      -- add custom handler
      clangd = function(_, opts) require("clangd_extensions").setup { server = opts } end
    },
    config = {
      clangd = {
        capabilities = {
          offsetEncoding = "utf-8",
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--completion-style=bundled",
          "--header-insertion=iwyu",
          "--pch-storage=memory",
          "--suggest-missing-includes",
          "--enable-config",
          "--function-arg-placeholders",
          "--cross-file-rename",
          "-j=4",
        },
        single_file_support = true
      },
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              loadOutDirsFromCheck = true,
              features = "all",
            },
            checkOnSave = {
              command = "clippy",
            },
            procMacro = {
              enable = true,
            },
            experimental = {
              procAttrMacros = true,
            },
            -- https://github.com/AstroNvim/AstroNvim/issues/1225
            completion = {
              postfix = {
                enable = false,
              },
            },
          },
        },
      },
    },
  },
  plugins = {
    "sainnhe/gruvbox-material",
    config = function() 
      print("init gruvbox-material")
      vim.g.gruvbox_material_foreground = "mix"
      vim.g.gruvbox_material_background = "medium"
      vim.g.gruvbox_material_ui_contrast = 1
      vim.g.gruvbox_material_enable_bold = 1
      vim.g.gruvbox_material_enable_italic = 1
      vim.g.gruvbox_material_diagnostic_text_highlight = 1
      vim.g.gruvbox_material_diagnostic_line_highlight = 1
      vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
    end,

    "hardhackerlabs/theme-vim",

    "p00f/clangd_extensions.nvim", -- install lsp plugin
    {
      "williamboman/mason-lspconfig.nvim",
      opts = {
        ensure_installed = { "clangd" }, -- automatically install lsp
      },
    },

    "AstroNvim/astrocommunity",
    { import = "astrocommunity.completion.copilot-lua" },
    { -- further customize the options set by the community
      "copilot.lua",
      opts = {
        suggestion = {
          keymap = {
            accept = "<C-l>",
            accept_word = false,
            accept_line = false,
            next = "<C-.>",
            prev = "<C-,>",
            dismiss = "<C/>",
          },
        },
      },
    },
    {
      "nvim-telescope/telescope.nvim",
      opts = {
        pickers = {
          man_pages = { sections = { "1", "2", "3" } }
        }
      }
    },
    -- { import = "astrocommunity.bars-and-lines.lualine-nvim"},
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.bash" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.java" },
    {
      "nvim-jdtls",
      opts = {
        settings = {
          java = {
            project = {
              referencedLibraries = {
                "lib/**/*.jar",
                "/usr/share/java/*.jar",
              }
            },
          },
        },
      },
    },
    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-calc",
        {
          "uga-rosa/cmp-dictionary",
          config = function()
            local dict = require("cmp_dictionary")
            -- dict.update()
            dict.setup({
              exact = 3,
              first_case_insensitive = false,
              document = true,
              document_command = "wn %s -over",
              async = false,
              sqlite = false,
              max_items = 7,
              capacity = 7,
              debug = false,
            })

            dict.switcher({
              spelllang = {
                -- en = "/home/qianlv/.config/english.dict",
                en = "/home/qianlv/.config/google-10000-english.txt",
              },
            })
          end,
        },
      },
      opts = function(_, opts)
        local cmp = require("cmp")
        local sources = {
          { name = "calc" },
          {
            name = "dictionary",
            keyword_length = 2,
          },
        }
        opts.sources = cmp.config.sources(vim.list_extend(opts.sources, sources))
        return opts
      end
    },
    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        opts.winbar = nil
        return opts
      end
    },
  },
}
