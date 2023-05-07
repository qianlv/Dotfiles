return {
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
          name = "dictionary",
          keyword_length = 2,
        },
      }

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, sources))
    end,
  },
}
