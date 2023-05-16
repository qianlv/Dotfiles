return {
  options = {
    opt = {
      cmdheight = 1,
      listchars = { tab = "» ", trail = "·", extends = "…", precedes = "…", nbsp = "␣" },
      list = true,
    },
    g = {
      icons_enabled = false,
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
      ["<A-j>"] = {
        "<cmd>m .+1<CR>==", desc = "Move line down"
      },
      ["<A-k>"] = {
        "<cmd>m .-2<CR>==", desc = "Move line up"
      },
    },
    v = {
      ["<Cr>"] = {
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Toggle comment line"
      },
      ["<A-j>"] = {
        "<cmd>m '>+1<CR>gv=gv", desc = "Move line down"
      },
      ["<A-k>"] = {
        "<cmd>m '<-2<CR>gv=gv", desc = "Move line up"
      },
    },
    i = {
      ["<A-j>"] = {
        "<esc><cmd>m .+1<CR>==gi", desc = "Move line down"
      },
      ["<A-k>"] = {
        "<esc><cmd>m .-2<CR>==gi", desc = "Move line up"
      },
    },
  },
  lsp = {
    servers = {
      "pyright",
      "clangd",
      "jdtls",
      "rust_analyzer",
      "lua_ls",
      "racket_lsp"
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
      racket_lsp = function()
        return {
          cmd = { "/usr/bin/racket", "--lib", "racket-langserver" },
          filetypes = { "racket" },
          root_dir = require("lspconfig.util").root_pattern("*.rkt", ".git"),
        }
      end,
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
        local _, luasnip = pcall(require, "luasnip")
        local lspkind_status_ok, lspkind = pcall(require, "lspkind")
        local function has_words_before()
          local line, col = unpack(vim.api.nvim_win_get_cursor(0))
          return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match "%s" == nil
        end

        local sources = {
          { name = "calc" },
          {
            name = "dictionary",
            keyword_length = 2,
          },
        }
        opts.sources = cmp.config.sources(vim.list_extend(opts.sources, sources))

        opts.formatting = {
          fields = { "abbr", "menu", "kind" },
          format = lspkind_status_ok and lspkind.cmp_format(astronvim.lspkind) or nil,
        }

        opts.mapping["<Tab>"] = cmp.mapping(function(fallback)
          print("Tab pressed")
          if require("copilot.suggestion").is_visible() then
            require("copilot.suggestion").accept()
          elseif cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" })
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
