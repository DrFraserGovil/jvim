-- Save session on exit, unique to the directory
vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        -- Prevent saving empty sessions if no buffers are open
        local bufs = vim.fn.getbufinfo({ buflisted = 1 })
        if #bufs == 0 then return end

        -- Save session file directly in your project root
        -- Using a distinct name so it doesn't clutter generic git status
        vim.cmd("mksession! .jvim.session")
    end,
})

-- Custom command to manually restore when you want it
vim.api.nvim_create_user_command("RestoreSession", function()
    local session_file = vim.fn.getcwd() .. "/.jvim.session"
    
    if vim.fn.filereadable(session_file) == 1 then
        -- Wipe out any empty, unused [No Name] buffers that block layouts
        local initial_buf = vim.api.nvim_get_current_buf()
        if vim.api.nvim_buf_get_name(initial_buf) == "" and not vim.bo[initial_buf].modified then
            vim.cmd("silent! bdelete " .. initial_buf)
        end

        -- Wrap the source command to aggressively override window layouts
        -- Using pcall ensures that if a minor option fails, it doesn't crash Lua
        local success, err = pcall(function()
            vim.cmd("silent! source " .. vim.fn.fnameescape(session_file))
        end)

        if success then
            print("Project session restored.")
        else
            -- If it fails, force-source it as a fallback
            vim.cmd("source! " .. vim.fn.fnameescape(session_file))
            print("Project session force-restored.")
        end
    else
        print("No session file found for this project.")
    end
end, {})
