local M = {}
function M.togglewrap()
    vim.wo.wrap = not vim.wo.wrap
    vim.wo.linebreak = vim.wo.wrap -- Only break at words when wrapped

    if vim.wo.wrap then
        print("Line wrap enabled")
    else
        print("Line wrap disabled")
    end
end
return M
