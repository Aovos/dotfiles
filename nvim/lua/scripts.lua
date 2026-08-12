-- ==========================================================================
-- SCRIPTS (Deine eigenen Funktionen und Logiken - Komplett ohne Plugins!)
-- ==========================================================================

-- 1. Schlaues Speichern (Normal, Schließen oder mit Pfad-Eingabe)
_G.smart_save = function(action)
  -- Wenn action == "as" ist, fragen wir direkt nach einem neuen Pfad/Namen
  if action == "as" then
    vim.ui.input({
      prompt = "Speichern unter (Pfad/Dateiname): ",
      completion = "file" -- Aktiviert die Tab-Vervollständigung für Pfade und Dateien
    }, function(input)
      if input and input ~= "" then
        vim.cmd("write " .. input)
      else
        print("Abgebrochen.")
      end
    end)
  -- Wenn die Datei noch keinen Namen hat, fragen wir wie gewohnt nach einem Namen
  elseif vim.api.nvim_buf_get_name(0) == "" then
    vim.ui.input({
      prompt = "Dateiname mit Endung: ",
      completion = "file" -- Aktiviert die Tab-Vervollständigung auch hier, falls du Pfade tippst
    }, function(input)
      if input and input ~= "" then
        vim.cmd("write " .. input .. (action == "quit" and " | quit" or ""))
      else
        print("Abgebrochen.")
      end
    end)
  -- Standard-Verhalten für bereits benannte Dateien
  else
    vim.cmd(action == "quit" and "wq" or "write")
  end
end

-- 2. Code-Ausführer im Terminal-Split (Java, C#, Lua, Bash)
_G.smart_run_file = function()
  if vim.bo.modified then vim.cmd("write") end
  local ext_map = {
    java = "java " .. vim.fn.shellescape(vim.fn.expand("%:t")),
    cs = "dotnet run",
    lua = "lua " .. vim.fn.shellescape(vim.fn.expand("%:t")),
    sh = "bash " .. vim.fn.shellescape(vim.fn.expand("%:t"))
  }
  if ext_map[vim.bo.filetype] then
    vim.cmd("botright split | resize 12 | terminal cd " .. vim.fn.shellescape(vim.fn.expand("%:p:h")) .. " && " .. ext_map[vim.bo.filetype])
    vim.cmd("startinsert")
  else
    print("Kein Runner für '" .. vim.bo.filetype .. "' definiert.")
  end
end

-- 3. Interaktiver Projekt-Generator für C# und Java
_G.smart_generate_project = function()
  vim.ui.input({ prompt = "Projekt/Ordner-Name: " }, function(name)
    if not name or name == "" then return print("Abgebrochen.") end
    vim.ui.select({ "C# (.NET)", "Java (Single File)" }, { prompt = "Sprache wählen:" }, function(lang)
      if not lang then return end
      if lang == "C# (.NET)" then
        vim.ui.select({ "Console App", "Web API", "Class Library" }, { prompt = "Typ wählen:" }, function(type)
          if not type then return end
          local map = { ["Console App"] = "console", ["Web API"] = "webapi", ["Class Library"] = "classlib" }
          vim.fn.system({ "mkdir", name })
          vim.fn.system({ "dotnet", "new", map[type], "-o", name })
          vim.cmd("cd " .. name .. " | edit Program.cs")
        end)
      else
        vim.fn.system({ "mkdir", "-p", name })
        vim.cmd("cd " .. name .. " | edit Main.java")
        vim.api.nvim_buf_set_lines(0, 0, -1, false, {
          "public class Main {",
          "    public static void main(String[] args) {",
          "        System.out.println(\"Hello World!\");",
          "    }",
          "}"
        })
        vim.cmd("write")
      end
    end)
  end)
end
