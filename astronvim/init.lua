local utils = require "astronvim.utils"
local italic = false
return {
  options = {
    opt = {
      -- cmdheight = 1,
      listchars = { tab = "»·", trail = "·", extends = "…", precedes = "…", nbsp = "␣" },
      list = true,
      foldcolumn = "0",
      signcolumn = "yes",
      -- tabstop = 4,
      -- shiftwidth = 4,
      -- softtabstop = 4,
      smarttab = true,
      expandtab = true,
      smartindent = true,
      autoindent = true,
      backspace = { "indent", "eol", "start" },
      mouse = "", -- forbid mouse
      mps = vim.opt.mps + { "<:>" },
      clipboard = "",
      background = "dark",
    },
    g = {
      icons_enabled = true,
      diagnostics_mode = 1,
    },
  },

  colorscheme = "gruvbox-material",
  -- colorscheme = "dracula",
  -- colorscheme = "rose-pine",
  -- colorscheme = "rose-pine-moon",

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
      -- ["<leader>ih"] = {
      --   function()
      --     local lsp = require "vim.lsp"
      --     lsp.inlay_hint.enable(0, not lsp.inlay_hint.is_enabled())
      --   end,
      --   desc = "Toggle inlay hints",
      -- },
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
          "--clang-tidy-checks=performance-*, bugprone-*, misc-*, google-*, readability-*, portability-*",
          "--all-scopes-completion",
          "--completion-parse=auto",
          "--completion-style=detailed",
          "--header-insertion=iwyu",
          "--pch-storage=memory",
          "--ranking-model=decision_forest",
          "--suggest-missing-includes",
          "--function-arg-placeholders",
          "--cross-file-rename",
          "--enable-config",
          -- "--fallback-style=Webkit",
          "--fallback-style=Google",
          "-j=4",
        },
        fallbackFlags = {
          "-pedantic",
          "-Wall",
          "-Wextra",
          "-Wcast-align",
          "-Wdouble-promotion",
          "-Wformat=2",
          "-Wimplicit-fallthrough",
          "-Wmisleading-indentation",
          "-Wnon-virtual-dtor",
          "-Wnull-dereference",
          "-Wold-style-cast",
          "-Woverloaded-virtual",
          "-Wpedantic",
          "-Wshadow",
          "-Wunused",
          "-pthread",
          "-fuse-ld=lld",
          "-fsanitize=address",
          "-fsanitize=undefined",
          -- "-stdlib=libc++",
          "-std=c++20",
        },
        single_file_support = true,
      },
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              loadOutDirsFromCheck = true,
            },
            checkOnSave = {
              command = "clippy",
              allFeatures = true,
              extraArgs = { "--no-deps" },
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
    { import = "astrocommunity.indent.mini-indentscope" },
    { import = "astrocommunity.color.transparent-nvim" },

    { import = "astrocommunity.editing-support.vim-move" },
    { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

    { import = "astrocommunity.lsp.lsp-signature-nvim" },

    { import = "astrocommunity.pack.lua" },
    { import = "astrocommunity.pack.rust" },
    { import = "astrocommunity.pack.cpp" },
    { import = "astrocommunity.pack.bash" },
    { import = "astrocommunity.pack.python-ruff" },
    { import = "astrocommunity.pack.java" },
    { import = "astrocommunity.pack.markdown" },
    { import = "astrocommunity.pack.html-css" },
    { import = "astrocommunity.pack.typescript" },
    { import = "astrocommunity.lsp.lsp-inlayhints-nvim" },

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
          null_ls.builtins.hover.dictionary,
        }
        return config -- return final config table
      end,
    },

    {
      "williamboman/mason-lspconfig.nvim",
      opts = function(_, opts) opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "asm_lsp") end,
    },

    {
      "jay-babu/mason-null-ls.nvim",
      opts = function(_, opts)
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "asmfmt")
        opts.ensure_installed = utils.list_insert_unique(opts.ensure_installed, "markuplint")
      end,
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
        local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", ".project", ".idea" }
        opts.root_dir = require("jdtls.setup").find_root(root_markers)
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
              paths = { "/home/qianlv/.config/english.dict" },
              exact_length = 2,
              first_case_insensitive = true,
              document = {
                enable = true,
                command = { "wn", "${label}", "-over" },
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
            priority = 300,
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
      dependencies = { "nvim-treesitter/nvim-treesitter" },
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
    },

    {
      "NvChad/nvim-colorizer.lua",
      opts = function(_, opts)
        opts.filetypes = {
          "*",
          css = { names = true, css = true, css_fn = true },
          html = { names = true },
        }
        return opts
      end,
    },

    {
      "lukas-reineke/indent-blankline.nvim",
      enabled = false,
    },

    -- themes
    {
      "rose-pine/neovim",
      name = "rose-pine",
      opts = function(_, opts)
        opts.styles = {
          bold = true,
          italic = italic,
          transparency = true,
        }
        return opts
      end,
    },
    {
      "Mofiqul/dracula.nvim",
      name = "dracula",
      opts = function(_, opts)
        opts.transparent_bg = true
        opts.italic_comment = italic
        return opts
      end,
    },

    {
      "sainnhe/gruvbox-material",
      config = function()
        vim.g.gruvbox_material_foreground = "mix"
        vim.g.gruvbox_material_background = "medium"
        vim.g.gruvbox_material_better_performance = 1
        vim.g.gruvbox_material_ui_contrast = "high"
        vim.g.gruvbox_material_enable_bold = 1
        vim.g.gruvbox_material_enable_italic = italic and 1 or 0
        vim.g.gruvbox_material_disable_italic_comment = not italic and 1 or 0
        vim.g.gruvbox_material_diagnostic_text_highlight = 1
        vim.g.gruvbox_material_diagnostic_line_highlight = 1
        vim.g.gruvbox_material_diagnostic_virtual_text = "colored"
      end,
    },
  },

  -- This function is run last and is a good place to configuring
  -- augroups/autocommands and custom filetypes also this just pure lua so
  -- anything that doesn't fit in the normal config locations above can go here
  polish = function()
    vim.on_key(nil, vim.api.nvim_get_namespaces()["auto_hlsearch"])
    vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
      desc = "Lazy load clipboard",
      once = true,
      callback = function()
        if vim.fn.has "win32" == 1 or vim.fn.has "wsl" == 1 then
          vim.g.clipboard = {
            copy = {
              ["+"] = "win32yank.exe -i --crlf",
              ["*"] = "win32yank.exe -i --crlf",
            },
            paste = {
              ["+"] = "win32yank.exe -o --lf",
              ["*"] = "win32yank.exe -o --lf",
            },
          }
        elseif vim.fn.has "unix" == 1 then
          if vim.fn.executable "xclip" == 1 then
            vim.g.clipboard = {
              copy = {
                ["+"] = "xclip -selection clipboard",
                ["*"] = "xclip -selection clipboard",
              },
              paste = {
                ["+"] = "xclip -selection clipboard -o",
                ["*"] = "xclip -selection clipboard -o",
              },
            }
          elseif vim.fn.executable "xsel" == 1 then
            vim.g.clipboard = {
              copy = {
                ["+"] = "xsel --clipboard --input",
                ["*"] = "xsel --clipboard --input",
              },
              paste = {
                ["+"] = "xsel --clipboard --output",
                ["*"] = "xsel --clipboard --output",
              },
            }
          end
        end

        vim.opt.clipboard = "unnamedplus"
      end,
    })
  end,
}
