local status, glow = pcall(require, 'glow')
if not status then
    return 
end

glow.setup({
  style = "dark",
  width = 120,
})
