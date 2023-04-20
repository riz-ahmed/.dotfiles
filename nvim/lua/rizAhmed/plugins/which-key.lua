local status, which_key = pcall(require, "which-key")
if not status then
    print("which key didn't work")
end

which_key.register({
    f = {
        name = "file",
        f = {"<cmd>Telescope find_files<CR>", "Find File"},
        g = {"<cmd>Telescope live_grep<CR>", "Live Grep"},
        b = {"<cmd>Telescope buffers<CR>", "View Buffers"},
        h = {"<cmd>Telescope help_tags<CR>", "Help Tags"},
        c = {"<cmd>Telescope grep_string<CR>", "Funtion Definition"},
    },
    s ={
        name = "windows",
        v = {"<C-w>v", "Split left and right"},
        h = {"<C-w>s", "Split top and bottom"},
        e = {"<C-w>=", "Make splits of equal widths"},
        x = {":close<CR>", "close the current split"},
        m = {":MaximizerToggle<CR>", "Maximise/Toggle current split"},
    },
    t = {
        name = "tabs and tagbar",
        b = {":TagbarToggle<CR>", "Toggle Tagbar"},
        o = {":tabnew<CR>", "Open New Tab"},
        x = {":tabclose<CR>", "Close Tab"},
        n = {":tabn<CR>", "Next Tab"},
        p = {":tabp<CR>", "Previous Tab"},
    },
}, {prefix = "<Leader>"})
