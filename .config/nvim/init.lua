--------------------------------------------------
--- I. Autocmds
--------------------------------------------------

-- Highlight on yank
vim.api.nvim_create_augroup("highlight_yank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "highlight_yank",
	callback = function()
		(vim.hl or vim.highlight).on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_augroup("resize_splits", { clear = true })
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = "resize_splits",
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_augroup("last_loc", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
	group = "last_loc",
	callback = function(event)
		local exclude = { "gitcommit" }
		local buf = event.buf
		if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
			return
		end
		vim.b[buf].lazyvim_last_loc = true
		local mark = vim.api.nvim_buf_get_mark(buf, '"')
		local lcount = vim.api.nvim_buf_line_count(buf)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_augroup("close_with_q", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "close_with_q",
	pattern = {
		"PlenaryTestPopup",
		"checkhealth",
		"dbout",
		"gitsigns-blame",
		"grug-far",
		"help",
		"lspinfo",
		"neotest-output",
		"neotest-output-panel",
		"neotest-summary",
		"notify",
		"qf",
		"snacks_win",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.schedule(function()
			vim.keymap.set("n", "q", function()
				vim.cmd("close")
				pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
			end, {
				buffer = event.buf,
				silent = true,
				desc = "Quit buffer",
			})
		end)
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_augroup("wrap_spell", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	group = "wrap_spell",
	pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_augroup("json_conceal", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	group = "json_conceal",
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Netrw settings
vim.cmd([[
let g:netrw_keepdir = 0
let g:netrw_winsize = 30
let g:netrw_localcopydircmd = 'cp -r'
hi! link netrwMarkFile Search
let g:netrw_bufsettings = 'noma nomod nu nobl nowrap ro'
function! NetrwMapping()
	nmap <buffer> H u
	nmap <buffer> h -^
	nmap <buffer> l <CR>
	nmap <buffer> . gh
	nmap <buffer> P <C-w>z
endfunction
augroup netrw_mapping
	autocmd!
	autocmd filetype netrw call NetrwMapping()
augroup END
]])

--------------------------------------------------
--- II. General options
--------------------------------------------------
vim.g.mapleader = " "
vim.g.localmapleader = " "
vim.g.autoformat = true
vim.g.markdown_folding = 1 -- enalbles recursive folding in markdown files
vim.g.have_nerd_font = false

local opt = vim.opt
opt.clipboard = "unnamedplus"
opt.conceallevel = 2
opt.confirm = true
opt.expandtab = false -- don't use spaces instead of tabs
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt"
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.inccommand = "nosplit"
opt.jumpoptions = "view"
opt.linebreak = true
opt.list = false
opt.mouse = "a"
opt.number = true
opt.pumblend = 10
opt.pumheight = 10
opt.relativenumber = true
opt.scrolloff = 10
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { "en" }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = "screen"
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = vim.g.vscode and 1000 or 300 -- Lower than default (1000) to quickly trigger which-key
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = false -- Disable line wrap
opt.background = "dark"

--------------------------------------------------
--- III. general keymaps
--------------------------------------------------
local map = vim.keymap.set
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- map jk to esc and clear hlsearch
map({ "i" }, "jk", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-n>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-p>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-n>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-p>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-n>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-p>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
map("n", "<A-h>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<A-l>", "<cmd>bnext<cr>", { desc = "Next Buffer" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- commenting
map("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

map("n", "[q", vim.cmd.cprev, { desc = "Previous Quickfix" })
map("n", "]q", vim.cmd.cnext, { desc = "Next Quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- highlights under cursor
map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
map("n", "<leader>uI", "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- windows
map("n", "<leader>w", "<c-w>", { desc = "Windows", remap = true })

--------------------------------------------------
--- IV. Plugins
--------------------------------------------------
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		-- add your plugins here
		-- 1. which-key
		{
			"folke/which-key.nvim",
			event = "VimEnter",
			config = true,
			keys = {
				{
					"<leader>?",
					function()
						require("which-key").show({ global = false })
					end,
					desc = "Buffer Local Keymaps (which-key)",
				},
			},
		},

		-- 2. mini-icons
		{ "echasnovski/mini.icons", version = "*" },

		-- 3. lsp
		{
			"neovim/nvim-lspconfig",
			cmd = "LspInfo",
			event = { "BufReadPre", "BufNewFile" },
			dependencies = {
				{ "hrsh7th/cmp-nvim-lsp", "nvimdev/lspsaga.nvim" },
			},
			config = function()
				local lsp_defaults = require("lspconfig").util.default_config
				-- configuration for all servers
				-- Add cmp_nvim_lsp capabilities settings to lspconfig
				-- This should be executed before you configure any language server
				lsp_defaults.capabilities = vim.tbl_deep_extend(
					"force",
					lsp_defaults.capabilities,
					require("cmp_nvim_lsp").default_capabilities()
				)

				-- LspAttach is where you enable features that only work
				-- if there is a language server active in the file
				vim.api.nvim_create_autocmd("LspAttach", {
					desc = "LSP actions",
					callback = function(event)
						local opts = { buffer = event.buf }

						-- vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
						vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
						vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
						-- vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
						vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
						vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
						vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
						vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
						-- vim.keymap.set("n", "<leader>a", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
						-- keybindings for lspsaga
						vim.keymap.set("n", "<leader>lf", "<cmd>Lspsaga finder<cr>", opts)
						vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<cr>", opts)
						vim.keymap.set("n", "<leader>li", "<cmd>Lspsaga incoming_calls<cr>", opts)
						vim.keymap.set("n", "<leader>lo", "<cmd>Lspsaga outgoing_calls<cr>", opts)
						vim.keymap.set("n", "<leader>a", "<cmd>Lspsaga code_action<cr>", opts)
						vim.keymap.set("n", "<leader>lt", "<cmd>Lspsaga outline<cr>", opts)
						vim.keymap.set("n", "<leader>gi", "<cmd>Lspsaga finder imp<cr>", opts)
						vim.keymap.set({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<cr>", opts)
					end,
				})

				-- diagnostics for all servers
				vim.diagnostic.config({
					signs = {
						text = {
							[vim.diagnostic.severity.ERROR] = "✘",
							[vim.diagnostic.severity.WARN] = "▲",
							[vim.diagnostic.severity.HINT] = "⚑",
							[vim.diagnostic.severity.INFO] = "»",
						},
					},
				})
				-- launch lua server
				require("lspconfig").lua_ls.setup({
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentFormattingRangeProvider = false
					end,
				})

				-- launch clangs server
				require("lspconfig").clangd.setup({
					on_attach = function(client)
						client.server_capabilities.semanticTokensProvider = nil
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentFormattingRangeProvider = false
					end,
				})

				-- launch python server
				require("lspconfig").pylsp.setup({
					on_attach = function(client)
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentFormattingRangeProvider = false
					end,
				})

				-- launch markdown server
				require("lspconfig").markdown_oxide.setup({
					on_attach = function(client)
						client.server_capabilities.semanticTokensProvider = nil
						client.server_capabilities.documentFormattingProvider = false
						client.server_capabilities.documentFormattingRangeProvider = false
					end,
				})
			end,
		},

		-- 4. autocompletion
		{
			"hrsh7th/nvim-cmp",
			event = "InsertEnter",
			dependencies = {
				{
					"L3MON4D3/LuaSnip",
					"hrsh7th/cmp-buffer",
					"hrsh7th/cmp-path",
					"onsails/lspkind.nvim",
				},
			},
			config = function()
				local cmp = require("cmp")
				require("luasnip.loaders.from_vscode").lazy_load()

				cmp.setup({
					window = {
						completion = cmp.config.window.bordered(),
						documentation = cmp.config.window.bordered(),
					},
					preselect = "item",
					completion = {
						completeopt = "menu,menuone,noinsert",
					},
					sources = {
						{
							name = "nvim_lsp",
							option = {
								markdown_oxide = {
									keyword_pattern = [[\(\k\| \|\/\|#\)\+]],
								},
							},
						},
						{ name = "luasnip" },
						{ name = "buffer" },
						{ name = "path" },
					},
					fomatting = {
						fields = { "abbr", "kind", "menu" },
						format = require("lspkind").cmp_format({
							mode = "symbol",
							maxwidth = 50,
							ellipsis_char = "...",
						}),
					},
					mapping = cmp.mapping.preset.insert({
						-- Jump to the next snippet placeholder
						["<C-f>"] = cmp.mapping(function(fallback)
							local luasnip = require("luasnip")
							if luasnip.locally_jumpable(1) then
								luasnip.jump(1)
							else
								fallback()
							end
						end, { "i", "s" }),
						-- Jump to the previous snippet placeholder
						["<C-b>"] = cmp.mapping(function(fallback)
							local luasnip = require("luasnip")
							if luasnip.locally_jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						["<C-p>"] = cmp.mapping.scroll_docs(-4),
						["<C-n>"] = cmp.mapping.scroll_docs(4),
						-- Super tab
						["<Tab>"] = cmp.mapping(function(fallback)
							local luasnip = require("luasnip")
							local col = vim.fn.col(".") - 1

							if cmp.visible() then
								cmp.select_next_item({ behavior = "select" })
							elseif luasnip.expand_or_locally_jumpable() then
								luasnip.expand_or_jump()
							elseif col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
								fallback()
							else
								cmp.complete()
							end
						end, { "i", "s" }),

						-- Super shift tab
						["<S-Tab>"] = cmp.mapping(function(fallback)
							local luasnip = require("luasnip")

							if cmp.visible() then
								cmp.select_prev_item({ behavior = "select" })
							elseif luasnip.locally_jumpable(-1) then
								luasnip.jump(-1)
							else
								fallback()
							end
						end, { "i", "s" }),
					}),
					snippet = {
						expand = function(args)
							require("luasnip").lsp_expand(args.body)
						end,
					},
				})
			end,
		},

		-- 4. render-markdown
		{
			"MeanderingProgrammer/render-markdown.nvim",
			dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.icons" }, -- if you use standalone mini plugins
			config = true,
		},

		-- 5. paste images in markdown
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			config = true,
			keys = {
				{ "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
			},
		},

		-- 6. colorscheme
		{
			"cdmill/neomodern.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				require("neomodern").setup({})
				require("neomodern").load()
			end,
		},

		-- 7. treesitter / treesitter-textobjects
		{
			"nvim-treesitter/nvim-treesitter",
			build = function()
				pcall(require("nvim-treesitter.install").update({ with_sync = true }))
			end,
			dependencies = {
				"nvim-treesitter/nvim-treesitter-textobjects",
			},
			config = function()
				require("nvim-treesitter.configs").setup({
					highlight = { enbale = true },
					indent = { enable = true },
					incremental_selection = {
						enable = true,
						keymaps = {
							init_selection = "<c-space>",
							node_incremental = "<c-space>",
							scope_incremental = "<c-s>",
							node_decremental = "<c-backspace>",
						},
					},
					textobjects = {
						select = {
							enable = true,
							lookahead = true,
							keymaps = {
								["af"] = "@function.outer",
								["if"] = "@function.inner",
								["ac"] = "@class.outer",
								["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
								["as"] = {
									query = "@local.scope",
									query_group = "locals",
									desc = "Select language scope",
								},
							},
							selection_modes = {
								["@parameter.outer"] = "v", -- charwise
								["@function.outer"] = "V", -- linewise
								["@class.outer"] = "<c-v>", -- blockwise
							},
							include_surrounding_whitespace = true,
						},
						move = {
							enable = true,
							set_jumps = true, -- whether to set jumps in the jumplist
							goto_next_start = {
								["]m"] = "@function.outer",
								["]]"] = { query = "@class.outer", desc = "Next class start" },
								["]o"] = "@loop.*",
								["]s"] = { query = "@local.scope", query_group = "locals", desc = "Next scope" },
								["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
							},
							goto_next_end = {
								["]M"] = "@function.outer",
								["]["] = "@class.outer",
							},
							goto_previous_start = {
								["[m"] = "@function.outer",
								["[["] = "@class.outer",
							},
							goto_previous_end = {
								["[M"] = "@function.outer",
								["[]"] = "@class.outer",
							},
							goto_next = {
								["]d"] = "@conditional.outer",
							},
							goto_previous = {
								["[d"] = "@conditional.outer",
							},
						},
					},
				})
			end,
		},

		-- 8. telescope
		{ -- Fuzzy Finder (files, lsp, etc)
			"nvim-telescope/telescope.nvim",
			event = "VimEnter",
			branch = "0.1.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				{
					"nvim-telescope/telescope-fzf-native.nvim",
					build = "make",
					cond = function()
						return vim.fn.executable("make") == 1
					end,
				},
				{ "nvim-telescope/telescope-ui-select.nvim" },

				-- Useful for getting pretty icons, but requires a Nerd Font.
				{ "nvim-tree/nvim-web-devicons", enabled = vim.g.have_nerd_font },
			},
			config = function()
				-- Two important keymaps to use while in Telescope are:
				--  - Insert mode: <c-/>
				--  - Normal mode: ?
				require("telescope").setup({
					-- defaults = {
					--   mappings = {
					--     i = { ['<c-enter>'] = 'to_fuzzy_refine' },
					--   },
					-- },
					-- pickers = {}
					extensions = {
						["ui-select"] = {
							require("telescope.themes").get_dropdown(),
						},
					},
				})

				-- Enable Telescope extensions if they are installed
				pcall(require("telescope").load_extension, "fzf")
				pcall(require("telescope").load_extension, "ui-select")

				-- See `:help telescope.builtin`
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
				vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
				vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "[S]earch [F]iles" })
				vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "[S]earch [S]elect Telescope" })
				vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch current [W]ord" })
				vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch by [G]rep" })
				vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "[S]earch [D]iagnostics" })
				vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "[S]earch [R]esume" })
				vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
				vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "[ ] Find existing buffers" })

				-- Slightly advanced example of overriding default behavior and theme
				vim.keymap.set("n", "<leader>/", function()
					-- You can pass additional configuration to Telescope to change the theme, layout, etc.
					builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
						winblend = 10,
						previewer = false,
					}))
				end, { desc = "[/] Fuzzily search in current buffer" })

				-- It's also possible to pass additional configuration options.
				--  See `:help telescope.builtin.live_grep()` for information about particular keys
				vim.keymap.set("n", "<leader>s/", function()
					builtin.live_grep({
						grep_open_files = true,
						prompt_title = "Live Grep in Open Files",
					})
				end, { desc = "[S]earch [/] in Open Files" })

				-- Shortcut for searching your Neovim configuration files
				vim.keymap.set("n", "<leader>sn", function()
					builtin.find_files({ cwd = vim.fn.stdpath("config") })
				end, { desc = "[S]earch [N]eovim files" })
			end,
		},

		-- 9. mini.paris
		{ "echasnovski/mini.pairs", version = "*", config = true },

		-- 10. indents
		{
			"nvimdev/indentmini.nvim",
			config = function()
				require("indentmini").setup()
			end,
		},

		--11. formatter
		{
			"stevearc/conform.nvim",
			event = { "BufWritePre" },
			cmd = { "ConformInfo" },
			keys = {
				{
					-- Customize or remove this keymap to your liking
					"<leader>gq",
					function()
						require("conform").format({ async = true })
					end,
					mode = "",
					desc = "Format buffer",
				},
			},
			-- This will provide type hinting with LuaLS
			---@module "conform"
			---@type conform.setupOpts
			opts = {
				-- Define your formatters
				formatters_by_ft = {
					lua = { "stylua" },
					python = { "black" },
					markdown = { "dprint" },
					javascript = { "prettierd", "prettier", stop_after_first = true },
				},
				-- Set default options
				default_format_opts = {
					lsp_format = "fallback",
				},
				-- Set up format-on-save
				format_on_save = { timeout_ms = 500 },
				-- Customize formatters
				formatters = {
					shfmt = {
						prepend_args = { "-i", "2" },
					},
				},
			},
			init = function()
				-- If you want the formatexpr, here is the place to set it
				vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
			end,
		},

		-- 12. colorful delimeters
		{
			"HiPhish/rainbow-delimiters.nvim",
			config = function()
				require("rainbow-delimiters")
			end,
		},

		--13. lspsaga
		{
			"nvimdev/lspsaga.nvim",
			dependencies = {
				"nvim-treesitter/nvim-treesitter", -- optional
				"nvim-tree/nvim-web-devicons", -- optional
			},
			config = true,
		},

		-- 14. markdown-preview
		{
			"iamcco/markdown-preview.nvim",
			cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
			build = "cd app && yarn install",
			init = function()
				vim.g.mkdp_filetypes = { "markdown" }
			end,
			ft = { "markdown" },
		},
	},
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	install = { colorscheme = { "neomodern" } },
	-- automatically check for plugin updates
	checker = { enabled = false },
})

--------------------------------------------------
--- V. colorscheme
--------------------------------------------------
vim.cmd.colorscheme("neomodern")
