vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = '*.go',
  callback = function()
    vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' } }, apply = true })
  end
})

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col('.') - 1
    if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        return true
    else
        return false
    end
end

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        return t "<C-x><C-o>"
    end
end

_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    else
        return t "<C-h>"
    end
end

_G.enter_key = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-y>"
    else
        return t "<CR>"
    end
end

vim.api.nvim_set_keymap("i", "<tab>", "<C-R>=v:lua.tab_complete()<CR>" ,{silent = true, noremap = true})
vim.api.nvim_set_keymap("i", "<s-tab>", "<C-R>=v:lua.s_tab_complete()<CR>" ,{silent = true, noremap = true})
vim.api.nvim_set_keymap('i', '<enter>', '<C-R>=v:lua.enter_key()<CR>' ,{silent = true, noremap = true})

require"structrue-go".setup({
	show_others_method = true, -- bool show methods of struct whose not in current file
	show_filename = true, -- bool
	number = "no", -- show number: no | nu | rnu
	fold_open_icon = " ",
	fold_close_icon = " ",
	cursor_symbol_hl = "guibg=Gray guifg=White", -- symbol hl under cursor,
	indent = "┠",  -- Hierarchical indent icon, nil or empty will be a tab
	position = "botright", -- window position,default botright,also can set float
	symbol = { -- symbol style
		filename = {
				hl = "guifg=#0096C7", -- highlight symbol
				icon = " " -- symbol icon
		},
		package = {
				hl = "guifg=#0096C7",
				icon = " "
		},
		import = {
				hl = "guifg=#0096C7",
				icon = " ◈ "
		},
		const = {
				hl = "guifg=#E44755",
				icon = " π ",
		},
		variable = {
				hl = "guifg=#52A5A2",
				icon = " ◈ ",
		},
		func = {
				hl = "guifg=#CEB996",
				icon = "  ",
		},
		interface = {
				hl = "guifg=#00B4D8",
				icon = "❙ "
		},
		type = {
				hl = "guifg=#00B4D8",
				icon = "▱ ",
		},
		struct = {
				hl = "guifg=#00B4D8",
				icon = "❏ ",
		},
		field = {
				hl = "guifg=#CEB996",
				icon = " ▪ "
		},
		method_current = {
				hl = "guifg=#CEB996",
				icon = " ƒ "
		},
		method_others = {
				hl = "guifg=#CEB996",
				icon = "  "
		},
	},
	keymap = {
		toggle = "<leader>m", -- toggle structure-go window
		show_others_method_toggle = "H", -- show or hidden the methods of struct whose not in current file
		symbol_jump = "<CR>", -- jump to then symbol file under cursor
		center_symbol = "\\f", -- Center the highlighted symbol
		fold_toggle = "\\z",
		refresh = "R", -- refresh symbols
		preview_open = "P", -- preview  symbol context open
		preview_close = "\\p" -- preview  symbol context close
	},
	fold = { -- fold symbols
		import = true,
		const = false,
		variable = false,
		type = false,
		interface = false,
		func = false,
	},
})

vim.g.copilot_no_tab_map = true
vim.api.nvim_set_keymap("i", "<C-j>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-y>", 'copilot#Previous()', { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<C-g>", 'copilot#Next()', { silent = true, expr = true })
