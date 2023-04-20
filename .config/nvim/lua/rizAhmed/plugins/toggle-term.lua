local status, toggle_term = pcall(require, "toggleterm")
if not status then
    print("toggle terminal didn't launch")
    return 
end

toggle_term.setup{}
