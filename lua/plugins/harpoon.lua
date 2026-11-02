return {
{
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        local harpoon = require("harpoon")
        -- save_on_toggle: edits made in the quick menu are kept even when it's closed with <Esc>
        harpoon:setup({ settings = { save_on_toggle = true } })
    end,
}


}
