-- ==========================================================================
-- SCRIPT MODULE: generate_project
-- Zuständigkeit: Interaktive Erstellung von C#- und Java-Projektstrukturen
-- ==========================================================================

return function()
  vim.ui.input({ prompt = "Projekt/Ordner-Name: " }, function(name)
    if not name or name == "" then 
      return print("Abgebrochen.") 
    end
    
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

