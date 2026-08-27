-- ==========================================================================
-- PLUGIN: NVIM-CMP & LUASNIP (Autovervollständigung & Deine Snippets)
-- ==========================================================================

return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",     -- LSP-Vorschläge ins Menü einspeisen
    "L3MON4D3/LuaSnip",         -- Die Snippet-Engine
    "saadparwaiz1/cmp_luasnip", -- Snippets im cmp-Menü anzeigen
  },
  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local s, t, i = luasnip.snippet, luasnip.text_node, luasnip.insert_node

    -- ==========================================================================
    -- DEINE CUSTOM SNIPPETS (Java & C#)
    -- ==========================================================================

    -- Java Snippets
    luasnip.add_snippets("java", {
      s("psvm", { t("public static void main(String[] args) {"), t({ "", "    " }), i(1), t({ "", "}" }) }),
      s("sout", { t("System.out.println("), i(1), t(");") })
    })

    -- C# Snippets
    luasnip.add_snippets("cs", {
      s("cw", { t("Console.WriteLine("), i(1), t(");") }),
      s("sim", { t("static void Main(string[] args) {"), t({ "", "    " }), i(1), t({ "", "}" }) })
    })

    -- ==========================================================================
    -- NVIM-CMP SETUP (Das Vorschlags-Fenster)
    -- ==========================================================================
    cmp.setup({
      -- Abgerundete Fensterrahmen für ein modernes, sauberes UI
      window = {
        completion = cmp.config.window.bordered({ border = "rounded" }),
        documentation = cmp.config.window.bordered({ border = "rounded" })
      },

      -- Verknüpfung mit Luasnip zur Code-Erweiterung
      snippet = {
        expand = function(args) luasnip.lsp_expand(args.body) end
      },

      -- Deine originalen Tastenkombinationen für die Navigation im Menü
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
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
      }),

      -- Die Quellen für deine Vorschläge (Snippets werden ganz oben gelistet)
      sources = cmp.config.sources({
        { name = "luasnip", priority = 1000 },
        { name = "nvim_lsp", priority = 500 }
      }),
    })
  end
}
