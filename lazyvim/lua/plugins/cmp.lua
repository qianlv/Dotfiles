return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- "zbirenbaum/copilot-cmp",
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
              en = "/home/qianlv/.config/english.dict",
            },
          })
        end,
      },
    },

    opts = function(_, opts)
      local cmp = require("cmp")
      print("in cmp")
      local sources = {
        { name = "calc" },
        {
          name = "copilot",
          keyword_length = 0,
          max_item_count = 3,
          group_index = 2,
        },
        {
          name = "dictionary",
          keyword_length = 2,
        },
      }
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, sources))

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
            -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
            -- they way you will only jump inside the snippet region
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-n>"] = cmp.mapping(function()
          if cmp.visible() then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
          else
            return cmp.complete()
          end
        end, { "i", "s" }),
      })

      opts.formatters = {
        insert_text = require("copilot_cmp.format").remove_existing,
      }
    end,
  },
}
