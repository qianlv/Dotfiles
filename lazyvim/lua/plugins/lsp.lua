return {
  {
    "neovim/nvim-lspconfig",

    event = { "BufReadPre", "BufNewFile" },

    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "mfussenegger/nvim-jdtls",
    },

    opts = {
      servers = {
        pyright = {},
        clangd = {},
        bashls = {},
        rust_analyzer = {},
        grammarly = {},
      },

      autoformat = false,

      setup = {
        clangd = function(_, opts)
          opts.capabilities.offsetEncoding = { "utf-16" }
          opts.cmd = {
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
          }
          opts.single_file_support = true
          -- opts.root_dir = function(fname)
          --   local util = require("lspconfig.util")
          --   local root_files = {
          --     ".clangd",
          --     ".clang-tidy",
          --     ".clang-format",
          --     "compile_commands.json",
          --     "compile_flags.txt",
          --     "configure.ac", -- AutoTools
          --   }
          --   return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
          -- end
          opts.init_options = {
            compilationDatabasePath = "./",
          }
        end,

        rust_analyzer = function(_, opts)
          opts.settings = {
            ["rust-analyzer"] = {
              checkOnSave = {
                command = "clippy",
              },
              cargo = {
                loadOutDirsFromCheck = true,
              },
              procMacro = {
                enable = true,
              },
              -- inlayHints = {
              --   chainingHints = true,
              --   typeHints = {
              --     enabled = true,
              --     parameterNames = true,
              --     typeBoundaries = true,
              --   },
              --   parameterHints = true,
              --   maxLength = 80,
              -- },
            },
          }
        end,
      },
    },
  },

  -- inlay hints
  {
    "lvimuser/lsp-inlayhints.nvim",
    dependencies = "simrat39/rust-tools.nvim",
    event = "LspAttach",
    opts = {},
    config = function(_, opts)
      require("rust-tools").setup({
        tools = {
          inlay_hints = {
            auto = false,
          },
        },
      })

      require("lsp-inlayhints").setup(opts)
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end,
      })
    end,
  },
}
