local M = {}

local function relative_motion(key)
  return vim.wo.wrap and "g" .. key or key
end

function M.setup(map)
  map({ "n", "v", "o" }, "$", function()
    return relative_motion("$")
  end, "Wrap-relative end", { expr = true })
  map({ "n", "v", "o" }, "<End>", function()
    return relative_motion("$")
  end, "Wrap-relative end", { expr = true })
  map({ "n", "v", "o" }, "0", function()
    return relative_motion("0")
  end, "Wrap-relative start", { expr = true })
  map({ "n", "v", "o" }, "<Home>", function()
    return relative_motion("0")
  end, "Wrap-relative start", { expr = true })
  map({ "n", "v", "o" }, "^", function()
    return relative_motion("^")
  end, "Wrap-relative first non-blank", { expr = true })

  map("n", "<leader>fc", "/\\v^[<\\|=>]{7}( .*\\|$)<cr>", "Find conflict marker")
  map("n", "<leader>q", "gwip", "Format paragraph")
  map("n", "<leader>jt", function()
    if vim.fn.executable("python3") == 1 then
      vim.cmd("%!python3 -m json.tool")
      vim.bo.filetype = "json"
    else
      vim.notify("python3 is required to format JSON", vim.log.levels.WARN)
    end
  end, "Format JSON")
  map("n", "<leader>ff", function()
    vim.cmd("normal! [I")
    local choice = vim.fn.input("Which one: ")
    if choice ~= "" then
      vim.cmd("normal! " .. choice .. "[\t")
    end
  end, "Find keyword occurrences")
end

return M
