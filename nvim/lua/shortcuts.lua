-- ==========================================================================
-- 1. GLOBAL KEY DEACTIVATION WITH EXCEPTIONS
-- ==========================================================================
local exceptions = {
  [" "] = true, -- Leader key (Spacebar)
  [":"] = true, -- Command-line mode access
  ["u"] = true, -- Built-in undo operation
  ["d"] = true, -- Built-in delete operation
  ["i"] = true, -- Insert mode toggle

}

-- Mute all standard ASCII keys (32-126) in normal and visual modes
for i = 32, 126 do
  local char = string.char(i)
  if not exceptions[char] then
    vim.keymap.set({ "n", "v" }, char, function() end, { noremap = true, silent = true })
  end
end

-- ==========================================================================
-- 2. CUSTOM SCRIPTS & WHICH-KEY CONFIGURATION
-- ==========================================================================
local wk = require("which-key")

local smart_save       = require("scripts.smart_save")
local run_code         = require("scripts.run_code")
local generate_project = require("scripts.generate_project")
local close_tab        = require("scripts.close_tab")
local delete_target    = require("scripts.delete_target")
local create_target    = require("scripts.create_target")
local rename_target    = require("scripts.rename_target")
local move_target      = require("scripts.move_target")

local git_stage        = require("scripts.git_scripts.git_stage")
local git_commit       = require("scripts.git_scripts.git_commit")
local git_push         = require("scripts.git_scripts.git_push")
local git_pull         = require("scripts.git_scripts.git_pull")

local cd_path          = require("scripts.cd_path")
local toggle_comment   = require("scripts.toggle_comment")


require("scripts.terminal_setup")

-- Register custom keybindings via Which-Key (v3+ format)
wk.add({
  { "<leader>/", toggle_comment.normal_mode, desc = "Toggle Comment", mode = "n" },
  { "<leader>/", toggle_comment.visual_mode, desc = "Toggle Comment", mode = "v" },

  { "<leader>s", group = "Save..." },
  { "<leader>ss", function() smart_save("normal") end, desc = "Save" },
  { "<leader>sS", function() smart_save("as") end,     desc = "Save as" },

  { "<leader>c", group = "Code..." },
  { "<leader>cr", run_code,                         desc = "Run Code" },
  { "<leader>cf", function() vim.lsp.buf.format({ async = true }) end, desc = "Format Code" },
  { "<leader>cg", generate_project,                 desc = "Generate Project" },

  { "<leader>g", group = "Git..." },

  { "<leader>gs", group = "Stage..." },
  { "<leader>gsa", git_stage.stage_all,     desc = "Stage All" },
  { "<leader>gss", git_stage.stage_current, desc = "Stage Current File" },
  { "<leader>gsS", git_stage.unstage_all,   desc = "Unstage All" },

  { "<leader>gc", git_commit, desc = "Commit" },
  { "<leader>gl", git_pull,   desc = "Pull from GitHub" },
  { "<leader>gp", git_push,   desc = "Push to GitHub" },

  { "<leader>gb", "<cmd>Gitsigns blame<cr>",    desc = "Blame" },
  { "<leader>gd", "<cmd>Gitsigns diffthis<cr>", desc = "Diff" },

  { "<leader>n", group = "New..." },
  { "<leader>nf", function() create_target("file") end, desc = "New File" },
  { "<leader>np", function() create_target("path") end, desc = "New Folder" },
  { "<leader>nt", "<cmd>enew<cr>",                   desc = "New Tab" },

  { "<leader>q", group = "Close..." },
  { "<leader>qq", "<cmd>quit!<cr>",                  desc = "Close" },
  { "<leader>qQ", function() smart_save("quit") end, desc = "Save and Close" },
  { "<leader>qt", close_tab,                         desc = "Close Tab" },

  { "<leader>f", "<cmd>Telescope find_files cwd=~<cr>",   desc = "Search" },
  { "<leader>l", "<cmd>Lazy<cr>",                   desc = "Lazy Menu" },

  { "<leader><Tab>", "<cmd>Neotree toggle<cr>",     desc = "Treeview" },
  { "<leader>h", function() require("neo-tree.sources.filesystem.commands").toggle_hidden(require("neo-tree.sources.manager").get_state("filesystem")) end, desc = "Toggle Hidden Files" },
  { "<leader>r", rename_target,                     desc = "Rename" },
  { "<leader>x", function() move_target(false) end, desc = "Cut" },
  { "<leader><Insert>", function() move_target(true) end, desc = "Insert" },
  { "<leader><Delete>", delete_target,               desc = "Delete" },
  { "<C-Tab>",   "<cmd>BufferLineCycleNext<cr>",    desc = "Next Tab" },
  { "<C-S-Tab>", "<cmd>BufferLineCyclePrev<cr>",    desc = "Previous Tab" },

  { "<leader>p", group = "cd_path..." },
  { "<leader>ph", cd_path.to_home, desc = "cd_path Home (~)" },
  { "<leader>pf", cd_path.to_file, desc = "cd_path File (Aktuelle Datei)" },
})

-- ==========================================================================
-- 3. WINDOW NAVIGATION & CLIPBOARD
-- ==========================================================================
-- Alt+Arrows for window split focus mapping (Normal, Visual, Terminal)
local directions = { Left = "h", Down = "j", Up = "k", Right = "l" }
for key, dir in pairs(directions) do
  vim.keymap.set({ "n", "v", "t" }, "<A-" .. key .. ">", "<cmd>wincmd " .. dir .. "<cr>", { desc = "Move focus" })
end

-- Clipboard operations targeting system clipboard register
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy (System Clipboard)" })
vim.keymap.set("v", "<leader>x", '"+x', { desc = "Cut (System Clipboard)" })
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Paste (Normal Mode)" })
vim.keymap.set("i", "<C-v>", '<C-r>+', { desc = "Paste (Insert Mode)" })

-- Select all document content and switch to Visual mode
vim.keymap.set({ "n", "i", "v" }, "<C-a>", "<Esc>ggVG", { desc = "Select All" })

-- ==========================================================================
-- 4. WINDOWS-STYLE TEXT SELECTION (SHIFT + ARROWS)
-- ==========================================================================
-- Normal mode selection initialization
vim.keymap.set("n", "<S-Up>",    "v<Up>",    { desc = "Start selection" })
vim.keymap.set("n", "<S-Down>",  "v<Down>",  { desc = "Start selection" })
vim.keymap.set("n", "<S-Left>",  "v<Left>",  { desc = "Start selection" })
vim.keymap.set("n", "<S-Right>", "v<Right>", { desc = "Start selection" })

-- Visual mode selection extension
vim.keymap.set("v", "<S-Up>",    "<Up>",    { desc = "Extend selection" })
vim.keymap.set("v", "<S-Down>",  "<Down>",  { desc = "Extend selection" })
vim.keymap.set("v", "<S-Left>",  "<Left>",  { desc = "Extend selection" })
vim.keymap.set("v", "<S-Right>", "<Right>", { desc = "Extend selection" })

-- Insert mode temporary command execution for selection initialization
vim.keymap.set("i", "<S-Up>",    "<C-o>v<Up>",    { desc = "Start selection" })
vim.keymap.set("i", "<S-Down>",  "<C-o>v<Down>",  { desc = "Start selection" })
vim.keymap.set("i", "<S-Left>",  "<C-o>v<Left>",  { desc = "Start selection" })
vim.keymap.set("i", "<S-Right>", "<C-o>v<Right>", { desc = "Start selection" })
