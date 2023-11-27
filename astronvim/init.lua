local utils = require "astronvim.utils"
return {
  options = {
    opt = {
      -- cmdheight = 1,
      listchars = { tab = "»·", trail = "·", extends = "…", precedes = "…", nbsp = "␣" },
      list = true,
      foldcolumn = "0",
      signcolumn = "yes",
      smarttab = true,
      expandtab = true,
      smartindent = true,
      autoindent = true,
      backspace = { "indent", "eol", "start" },
      mouse = "", -- forbid mouse
      mps = vim.opt.mps + { "<:>" },
    },
    g = {
      icons_enabled = true,
      -- diagnostics_mode = 2,
    },
  },

  colorscheme = "gruvbox-material",

  mappings = {
    n = {
      ["<S-l>"] = {
        function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end,
        desc = "Next buffer",
      },
      ["<S-h>"] = {
        function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
        desc = "Previous buffer",
      },
      ["<Cr>"] = {
        function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
        desc = "Comment line",
      },
      ["<esc>"] = {
        "<cmd>nohl<cr>",
      },
      ["<leader>ti"] = {
        function() utils.toggle_term_cmd "ipython" end,
        desc = "ToggleTerm ipython",
      },
    },
    v = {
      ["<Cr>"] = {
        "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
        desc = "Toggle comment line",
      },
    },
    i = {},
  },

  lsp = {
    -- List of language servers to be set up that are already
    -- installed without mason
    servers = {
      "racket_lsp",
    },

    formatting = {
      format_on_save = false, -- enable or disable automatic formatting on save
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
          -- "--fallback-style=Webkit",
          "--fallback-style=Google",
          "-j=4",
        },
        single_file_support = true,
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

      asm_lsp = function()
        return {
          cmd = { "asm-lsp" },
          filetypes = { "asm" },
          root_dir = require("lspconfig.util").root_pattern("*.asm", "*.s", "*.S", ".git"),
        }
      end,
    },
  },

  plugins = {
    "AstroNvim/astrocommunity",
    { import = "astrocommunity.completion.copilot-lua-cmp" },
    {
      "zbirenbaum/copilot.lua",
      opts = function(_, opts)
        opts.filetypes = {
          markdown = true,
        }
        return opts
      end,
    },
    { import = "astrocommunity.completion.cmp-cmdline" },
    { import = "astrocommunity.color.transparent-nvim" },
    { import = "astrocommunity.editing-support.vim-move" },
    { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },
    { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.bash" },
    { import = "astrocommunity.pack.python" },
    { import = "astrocommunity.pack.java" },
    { import = "astrocommunity.pack.markdown" },

    {
      "sainnhe/gruvbox-material",
      config = function()
        vim.g.gruvbox_material_foreground = "mix"
        vim.g.gruvbox_material_background = "medium"
        vim.g.gruvbox_material_ui_contrast = 1
        vim.g.gruvbox_material_enable_bold = 1
        vim.g.gruvbox_material_enable_italic = 1
        vim.g.gruvbox_material_diagnostic_text_highlight = 1
        vim.g.gruvbox_material_diagnostic_line_highlight = 1
        vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      end,
    },

    {
      "jose-elias-alvarez/null-ls.nvim",
      opts = function(_, config)
        -- config variable is the default configuration table for the setup function call
        local null_ls = require "null-ls"

        -- Check supported formatters and linters
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
        -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
        config.sources = {
          -- Set a formatter
          -- null_ls.builtins.formatting.stylua,
          -- null_ls.builtins.formatting.prettier,
          -- null_ls.builtins.formatting.autopep8,
          -- null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.clang_check,
        }
        return config -- return final config table
      end,
    },

    {
      "nvim-treesitter/nvim-treesitter",
      opts = {
        indent = {
          -- disable = { "python" },
        },
      },
    },

    {
      "williamboman/mason-lspconfig.nvim",
      opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "asm_lsp") end,
    },

    {
      "jay-babu/mason-null-ls.nvim",
      opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "asmfmt") end,
    },

    {
      "nvim-jdtls",
      opts = function(_, opts)
        opts.settings.java["project"] = {
          referencedLibraries = {
            "lib/**/*.jar",
            "/usr/share/java/*.jar",
          },
        }
        return opts
      end,
    },

    {
      "hrsh7th/nvim-cmp",
      dependencies = {
        "hrsh7th/cmp-calc",
        {
          "uga-rosa/cmp-dictionary",
          config = function()
            local dict = require "cmp_dictionary"
            dict.setup {
              exact = 3,
              first_case_insensitive = false,
              document = true,
              document_command = "wn %s -over",
              async = false,
              sqlite = false,
              max_items = 20,
              capacity = 7,
              debug = false,
            }

            dict.switcher {
              spelllang = {
                en = "/home/qianlv/.config/english.dict",
                -- en = "/home/qianlv/.config/largest_possible_aspell_wordlist_without_diacritic.txt",
                -- en = "/home/qianlv/.config/google-10000-english.txt",
              },
            }
          end,
        },
      },

      opts = function(_, opts)
        local cmp = require "cmp"
        local sources = {
          { name = "calc" },
          {
            name = "dictionary",
            keyword_length = 2,
          },
        }
        opts.sources = cmp.config.sources(vim.list_extend(opts.sources, sources))
        opts.mapping["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" })
        opts.mapping["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" })
        return opts
      end,
    },

    {
      "rebelot/heirline.nvim",
      opts = function(_, opts)
        opts.winbar = nil
        return opts
      end,
    },

    {
      "rcarriga/nvim-notify",
      opts = {
        background_colour = "#000000",
      },
    },

    {
      "nvim-telescope/telescope.nvim",
      opts = {
        pickers = {
          man_pages = { sections = { "1", "2", "3" } },
        },
      },
    },

    {
      "Badhi/nvim-treesitter-cpp-tools",
      ft = { "h", "cpp", "hpp", "c", "cc", "cxx" },
      depends = { "nvim-treesitter/nvim-treesitter" },
      config = function()
        require("nt-cpp-tools").setup {
          preview = {
            quit = "q", -- optional keymapping for quit preview
            accept = "<tab>", -- optional keymapping for accept preview
          },
          header_extension = "h", -- optional
          source_extension = "cpp", -- optional
          custom_define_class_function_commands = { -- optional
            TSCppImplWrite = {
              output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
            },
          },
        }
      end,
    },
    {
      "NMAC427/guess-indent.nvim",
      config = function()
        require("guess-indent").setup {
          auto_cmd = false,
        }
      end,
    }
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    vim.on_key(nil, vim.api.nvim_get_namespaces()["auto_hlsearch"])
  end,
}
