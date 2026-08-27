-- ==========================================================================
-- PLUGIN: LSPCONFIG (Die Code-Analyse für Java & C#)
-- ==========================================================================

return {
  "neovim/nvim-lspconfig",
  dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- Verknüpft die LSP-Intelligenz mit dem Pop-up-Menü
  config = function()
    -- Holt die Standard-Fähigkeiten des Vervollständigungsservers
    local caps = require("cmp_nvim_lsp").default_capabilities()

    -- 1. JAVA (jdtls) über die moderne native API einrichten
    vim.lsp.config("jdtls", {
      cmd = { "jdtls" }, -- Ruft direkt das jdtls-Paket aus deinem NixOS-System auf
      capabilities = caps
    })
    vim.lsp.enable("jdtls")

    -- 2. C# (csharp_ls) über die moderne native API einrichten
    vim.lsp.config("csharp_ls", {
      cmd = { "csharp-ls" }, -- Ruft direkt das csharp-ls-Paket aus deinem NixOS-System auf
      capabilities = caps
    })
    vim.lsp.enable("csharp_ls")

    -- 3. MARKDOWN (marksman) über die moderne native API einrichten
    vim.lsp.config("marksman", {
      cmd = { "marksman" }, -- Nur "marksman", ohne "server"
      capabilities = caps
    })
    vim.lsp.enable("marksman") 
    
  end
}
