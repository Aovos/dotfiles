# 📂 MEINE MODULARE NEOVIM KONFIGURATION

Hier ist die aktuelle, flache und saubere Architektur meines Editors.
Alle eigenen Einstellungen liegen direkt auf der ersten Ebene unter `lua/`.
Die externen Programmier-Plugins sind sauber im Ordner `plugins/` isoliert.

```text
~/.config/nvim/
├── init.lua                # 🎛️ Die Haupt-Schaltzentrale (Einstiegspunkt)
├── README.md               # 🗺️ Diese ASCII-Übersicht
└── lua/
    ├── options.lua         # ⚙️ Funktionale Basis (Tabs=4, Maus, Clipboard, Zeilennummern)
    ├── appearance.lua      # 🎨 Reines Neovim-Aussehen (Terminal-Transparenz, Diagnostics-Look)
    ├── scripts.lua         # 🧠 Deine Skripte (smart_save, smart_run_file, smart_generate_project)
    ├── shortcuts.lua       # ⌨️ Dein zentrales, verschachteltes Which-Key Shortcut-Menü
    │
    └── plugins/            # 🔌 REINE IDE-PLUGINS (Das Programmier-Gehirn)
        ├── lsp.lua         # 🔍 Code-Analyse für Java (jdtls) & C# (csharp_ls) [Zukunftssicher]
        ├── completion.lua  # 🪟 Pop-up-Menü (nvim-cmp) & Deine Snippets (psvm, sout, cw, sim)
        ├── treesitter.lua  # 🌈 Syntax-Highlighting (Erweitert um Python, Nix, Bash, YAML)
        └── telescope.lua   # 🔎 Die interaktive Dateisuche
```
