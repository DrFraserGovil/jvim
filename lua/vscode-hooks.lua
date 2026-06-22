local vscode = require("vscode")

-- Workspace Context Jumps
vim.keymap.set("n", "<leader>t", function()
    vscode.action("workbench.action.terminal.focus")
end)

vim.keymap.set("n","Q", function()
    vscode.action("editor.action.showHover")
end)

vim.keymap.set("i","<C-q>", function()
    vscode.action("hideSuggestWidget")
end)

-- Toggle current fold (za)
vim.keymap.set("n", "za", function()
    vim.fn.VSCodeNotify("editor.toggleFold")
end)

-- Close current fold (zc)
vim.keymap.set("n", "zc", function()
    vim.fn.VSCodeNotify("editor.fold")
end)

-- Open current fold (zo)
vim.keymap.set("n", "zo", function()
    vim.fn.VSCodeNotify("editor.unfold")
end)

-- Close ALL folds (zM)
vim.keymap.set("n", "zM", function()
    vim.fn.VSCodeNotify("editor.foldAll")
end)

-- Open ALL folds (zR)
vim.keymap.set("n", "zR", function()
    vim.fn.VSCodeNotify("editor.unfoldAll")
end)


vim.api.nvim_create_user_command("Only",function()
    vscode.call("workbench.action.closeOtherEditors")
end,{})
vim.cmd([[
    cnoreabbrev only Only
    cnoreabbrev on Only
]])


vim.keymap.set("n","<leader>s",function()
    vim.fn.VSCodeNotify("workbench.action.gotoSymbol")
end)

vim.keymap.set("n","ge",function()
    vscode.call("editor.action.marker.nextInFiles")
end)
vim.keymap.set("n","gE",function()
    vscode.call("editor.action.marker.prevInFiles")
end)
 
local function trigger_code_action()
    require('vscode').call('editor.action.codeAction', {
        kind = 'refactor',
        apply = 'first'
    })
end

vim.keymap.set('n', 'gm', function()
    local line = vim.api.nvim_get_current_line()
    if string.match(line, ";%s*$") then
        local new_line = line:gsub(";%s*$", " {}")
        vim.api.nvim_set_current_line(new_line)
        vim.defer_fn(trigger_code_action, 10)
    else
        trigger_code_action()
    end
end)

