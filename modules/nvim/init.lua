local cmd = vim.cmd
local g = vim.g

g.mapleader = " "


-- misc utils
local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= "o" then
        scopes["o"][key] = value
    end
end

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

opt("o", "hidden", true)
opt("o", "ignorecase", true)
opt("o", "splitbelow", true)
opt("o", "splitright", true)
opt("o", "termguicolors", true)
opt("w", "number", true)
opt("w", "relativenumber", true)
opt("o", "numberwidth", 2)
opt("b", "undofile", true)
opt("b", "textwidth", 0)
opt("w", "wrap", true)
opt("w", "cursorline", true)
opt("w", "colorcolumn", "+1")

opt("o", "mouse", "a")
opt("b", "spelllang", "en,fr")


opt("w", "signcolumn", "yes")
opt("o", "cmdheight", 1)

opt("o", "updatetime", 250) -- update interval for gitsigns
opt("o", "clipboard", "unnamedplus")

-- for indenline
opt("b", "expandtab", true)
opt("b", "shiftwidth", 4)

-- folding
opt("o", "foldlevelstart", 50)  -- open most folds by default
opt("w", "foldnestmax", 2)  -- 2 nested fold max


-- colors

local bar_bg = "#002b36"
local activeBuffer_bg = "#657b83"
local inactiveBuffer_bg = "#073642"
local activeBuffer_fg = "#fdf6e3"
local visibleBuffer_fg = "#eee8d5"
local inactiveBuffer_fg = "#93a1a1"
local duplicate_fg = "#586e75"
local modified_fg = "#b58900"
local info_fg = "#268bd2"
local warning_fg = "#cb4b16"
local error_fg = "#dc322f"


local opt = {silent = true}

local map = vim.api.nvim_set_keymap
vim.g.mapleader = " "

--command that adds new buffer and moves to it
map("n", "<C-t>", [[<Cmd>tabnew<CR>]], opt)

--removing a buffer
map("n", "<S-x>", [[<Cmd>bdelete<CR>]], opt)

-- tabnew and tabprev
map("n", "<S-t>", [[<Cmd>BufferLineCycleNext<CR>]], opt)
map("n", "<S-n>", [[<Cmd>BufferLineCyclePrev<CR>]], opt)
map("n", "gb", [[<Cmd>BufferLinePick<CR>]], opt)

-- Statusline

local colors = {
    bg = "#073642",
    line_bg = "#073642",
    fg = "#839496",
    fg_green = "#859900",
    fg_dark = "#002b36";
    yellow = "#b58900",
    cyan = "#2aa198",
    darkblue = "#268bd2",
    green = "#859900",
    orange = "#cb4b16",
    purple = "#6c71c4",
    magenta = "#d33682",
    blue = "#268bd2",
    red = "#dc322f",
    lightbg = "#657b83",
} 

local mode_colors = {
    __ = {colors.fg_dark, colors.yellow},
    c  = {colors.fg_dark, colors.magenta},
    i  = {colors.fg_dark, colors.orange},
    ic = {colors.fg_dark, colors.orange},
    ix = {colors.fg_dark, colors.orange},
    n  = {colors.fg_dark, colors.yellow},
    ni = {colors.fg_dark, colors.yellow},
    no = {colors.fg_dark, colors.yellow},
    R  = {colors.fg_dark, colors.orange},
    Rv = {colors.fg_dark, colors.orange},
    s  = {colors.fg_dark, colors.orange},
    S  = {colors.fg_dark, colors.orange},
    [""] = {colors.fg_dark, colors.red},
    t  = {colors.fg_dark, colors.yellow},
    v  = {colors.fg_dark, colors.green},
    V  = {colors.fg_dark, colors.green},
    ['']  = {colors.fg_dark, colors.green},
}

local function highlight(group, fg, bg, gui)
    local cmd = string.format('highlight %s guifg=%s guibg=%s', group, fg, bg)
    if gui ~= nil then cmd = cmd .. ' gui=' .. gui end
    vim.cmd(cmd)
end

local checkwidth = function()
    local squeeze_width = vim.fn.winwidth(0) / 2
    if squeeze_width > 40 then
        return true
    end
    return false
end

require("colorizer").setup()

-- Lspconfig
function on_attach(client, bufnr)
    local function map(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings
    local opts = {noremap = true, silent = true}
    map("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
    map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
    map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
    map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    map("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
    map("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
    map("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
    map("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
    map("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
    map("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
    map("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)
    map("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
    map("n", "ga", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

    -- Set some keybinds conditional on server capabilities
    if client.server_capabilities.document_formatting then
        map("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)
    elseif client.server_capabilities.document_range_formatting then
        map("v", "<leader>f", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
end

local lspconf = require "lspconfig"
local servers = {"pyright" , "bashls", "rls", "jsonls", "rnix"}

for k, lang in pairs(servers) do
    lspconf[lang].setup {
        root_dir = vim.loop.cwd,
        on_attach = on_attach,
        -- capabilities = capabilities,
    }
  end

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

-- lua lsp settings
require "lspconfig".sumneko_lua.setup {
    --cmd = {"lua-lsp"},
    root_dir = function()
        return vim.loop.cwd()
    end,
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
                path = vim.split(package.path, ";")
            },
            diagnostics = {
                globals = {"vim"}
            },
            workspace = {
                library = {
                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                    [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true
                }
            },
            telemetry = {
                enable = false
            }
        }
    }
}

require "lspconfig".jsonls.setup { 
    cmd = {"json-languageserver"},
    root_dir = function()
        return vim.loop.cwd()
    end,
    on_attach = on_attach,
}

require "lspconfig".html.setup { 
    cmd = {"html-languageserver"},
    root_dir = function()
        return vim.loop.cwd()
    end,
    on_attach = on_attach,
}

require "lspconfig".cssls.setup { 
    cmd = {"css-languageserver"},
    root_dir = function()
        return vim.loop.cwd()
    end,
    on_attach = on_attach,
}

require "lspconfig".luau_lsp.setup {
    cmd = {"lua-languageserver"},
    root_dir = function()
        return vim.loop.cwd()
    end,
    on_attach = on_attach,
} 

-- Compe
vim.o.completeopt = "menuone,noselect"
vim.o.shortmess = vim.o.shortmess .. "c"

local capabilities

local t = function(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
end

local check_back_space = function()
    local col = vim.fn.col(".") - 1
    if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
        return true
    else
        return false
    end
end

-- tab completion

_G.tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-n>"
    elseif check_back_space() then
        return t "<Tab>"
    else
        -- return vim.fn["compe#complete"]()
        return cmp.mapping.complete()
    end
end
_G.s_tab_complete = function()
    if vim.fn.pumvisible() == 1 then
        return t "<C-p>"
    elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
        return t "<Plug>(vsnip-jump-prev)"
    else
        return t "<S-Tab>"
    end
end

--  mappings

-- map("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- map("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- map("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- map("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})

function _G.completions()
    local npairs = require("nvim-autopairs")
    if vim.fn.pumvisible() == 1 then
        if vim.fn.complete_info()["selected"] ~= -1 then
            return vim.fn["compe#confirm"]("<CR>")
        end
    end
    return npairs.check_break_line_char()
end

-- local base16 = require "base16"
-- base16(base16.themes["solarized-dark"], true)
vim.cmd('colorscheme dracula')

-- blankline
local indent = 4

g.indent_blankline_char = "▏"
g.indent_blankline_use_treesitter = true
g.indent_blankline_show_current_context = true

cmd "highlight IndentBlanklineChar guifg=#073642 gui=nocombine"

g.indent_blankline_filetype_exclude = { "help", "terminal" }
g.indent_blankline_buftype_exclude = { "terminal" }

g.indent_blankline_show_trailing_blankline_indent = false
g.indent_blankline_show_first_indent_level = false


-- Mappings

local opt = {}

-- vim.cmd([[nnoremap <expr> s v:count ? (v:count > 5 ? "m'" . v:count : '') . 's' : 'gs']])
-- vim.cmd([[nnoremap <expr> r v:count ? (v:count > 5 ? "m'" . v:count : '') . 'r' : 'gr']])

-- dont copy any deleted text , this is disabled by default so uncomment the below mappings if you want them!

-- map("n", "dd", [=[ "_dd ]=], opt)
-- map("v", "dd", [=[ "_dd ]=], opt)
map("v", "x", [=[ "_x ]=], opt)

-- copy any selected text with pressing y

map("", "<leader>c", '"+y', opt)

-- OPEN TERMINALS --
map("n", "<C-S-h>", [[<Cmd>vnew term://zsh <CR>]], opt) -- open term over right
map("n", "<C-H>", [[<Cmd> split term://zsh | resize 10 <CR>]], opt) -- open term bottom

-- COPY EVERYTHING --
-- map("n", "<C-a>", [[ <Cmd> %y+<CR>]], opt)

-- toggle numbers ---
map("n", "<leader>n", [[ <Cmd> set nu!<CR>]], opt)
map("n", "<leader>m", [[ <Cmd> set nu! rnu!<CR>]], opt)

map("n", "<leader>z", [[ <Cmd> ZenMode<CR>]], opt)
-- Writing mode
local writing_mode = false
-- local spell_mode = vim.wo.spell
function toggle_writing_mode()
  require("zen-mode").toggle({
    window = {width = 100, options = {number = false, relativenumber = false, signcolumn = "no", linebreak = true, cursorline = false, colorcolumn = "", spell=true}},
    plugins = {options = {textwidth = 0}}
  })
  if writing_mode then
    -- base16(base16.themes["solarized-dark"], true)
    vim.cmd('colorscheme base16-solarized-dark')
    set_highlights()
    writing_mode = false
  else
    -- base16(base16.themes["solarized-light"], true)
    vim.cmd('colorscheme base16-solarized-light')
    writing_mode = true
  end
end

map("n", "<leader>Z", [[ <Cmd> lua toggle_writing_mode()<CR>]], opt)
map("i", "<down>", "<c-\\><c-o>gj", {nowait = true, noremap = true})
map("i", "<up>", "<c-\\><c-o>gk", {nowait = true, noremap = true})
    


map("n", "<F11>", [[ <Cmd> set spell!<CR>]], opt)
map("i", "<F11>", [[ <Cmd> set spell!<CR>]], opt)
map("n", "<F2>", [[ <Cmd>set paste!<CR>]], opt)
map("i", "<F2>", [[ <Cmd>set paste!<CR>]], opt)


map('n', '<C-c>', '<cmd> let @/ = ""<CR>', opt)

map('n', '<leader>ç', '<cmd> MinimapToggle<CR>', opt)
map('t', '<Esc>', '<C-\\><C-n>', opt)

-- highlights --
function set_highlights()

  cmd "hi LineNr guifg=#657b83 guibg=NONE"
  cmd "hi Comment guifg=#657b83"

  cmd "hi SignColumn guibg=NONE"
  cmd "hi VertSplit guibg=NONE guifg=#073642"
  cmd "hi EndOfBuffer guifg=#073642"
  cmd "hi PmenuSel guibg=#859900"
  cmd "hi Pmenu  guibg=#002b36"

  cmd "hi Normal guibg=NONE ctermbg=NONE"
  -- cmd "hi Normal guibg=#002b36"

  cmd "hi CursorLine guibg=#073642"
  cmd "hi ColorColumn guibg=#073642"
end
set_highlights()

local opt = {noremap = true, silent = true}

vim.g.mapleader = " "

-- mappings
map("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
map("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
map("n", "<Leader>fg", [[<Cmd>lua require('telescope.builtin').live_grep()<CR>]], opt)
map("n", "<Leader>fs", [[<Cmd>lua require('telescope.builtin').spell_suggest()<CR>]], opt)
map("n", "<Leader>fa", [[<Cmd>lua require('telescope.builtin').lsp_code_actions()<CR>]], opt)
map("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
map("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
map("n", "<Leader>fe", [[<Cmd>lua require('telescope.builtin').symbols()<CR>]], opt)
map("n", "<Leader>ft", [[<Cmd>lua require('telescope.builtin').treesitter()<CR>]], opt)
map("n", "<Leader>fm", [[<Cmd> Neoformat<CR>]], opt)

-- nvimTree
vim.o.termguicolors = true



local get_lua_cb = function(cb_name)
    return string.format(":lua require'nvim-tree'.on_keypress('%s')<CR>", cb_name)
end

-- Mappings for nvimtree

map("n", "<leader>a", ":NvimTreeToggle<CR>", opt)

-- local tree_cb = require'nvim-tree.config'.nvim_tree_callback
-- vim.g.nvim_tree_bindings = {
--   { key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit") },
--   { key = {"<2-RightMouse>", "<C-]>"},    cb = tree_cb("cd") },
--   { key = "<C-v>",                        cb = tree_cb("vsplit") },
--   { key = "<C-x>",                        cb = tree_cb("split") },
--   { key = "<C-t>",                        cb = tree_cb("tabnew") },
--   { key = "<",                            cb = tree_cb("prev_sibling") },
--   { key = ">",                            cb = tree_cb("next_sibling") },
--   { key = "P",                            cb = tree_cb("parent_node") },
--   { key = "<BS>",                         cb = tree_cb("close_node") },
--   { key = "<S-CR>",                       cb = tree_cb("close_node") },
--   { key = "<Tab>",                        cb = tree_cb("preview") },
--   { key = "K",                            cb = tree_cb("first_sibling") },
--   { key = "J",                            cb = tree_cb("last_sibling") },
--   { key = "I",                            cb = tree_cb("toggle_ignored") },
--   { key = "H",                            cb = tree_cb("toggle_dotfiles") },
--   { key = "R",                            cb = tree_cb("refresh") },
--   { key = "a",                            cb = tree_cb("create") },
--   { key = "d",                            cb = tree_cb("remove") },
--   { key = "r",                            cb = tree_cb("rename") },
--   { key = "<C-r>",                        cb = tree_cb("full_rename") },
--   { key = "x",                            cb = tree_cb("cut") },
--   { key = "c",                            cb = tree_cb("copy") },
--   { key = "p",                            cb = tree_cb("paste") },
--   { key = "y",                            cb = tree_cb("copy_name") },
--   { key = "Y",                            cb = tree_cb("copy_path") },
--   { key = "gy",                           cb = tree_cb("copy_absolute_path") },
--   { key = "[c",                           cb = tree_cb("prev_git_item") },
--   { key = "]c",                           cb = tree_cb("next_git_item") },
--   { key = "-",                            cb = tree_cb("dir_up") },
--   { key = "q",                            cb = tree_cb("close") },
--   { key = "g?",                           cb = tree_cb("toggle_help") },
-- }
local tree_cb = require'nvim-tree.config'.nvim_tree_callback
require'nvim-tree'.setup {
  -- side = "left",
  -- width = 25,
  -- ignore = {".git", "node_modules", ".cache"},
  -- auto_ignore_ft = {'startify'},
  -- auto_open = true,
  -- tab_open = true,
  -- auto_close = false,
  -- quit_on_open = true,
  -- follow = true,
  -- indent_markers = true,
  -- hide_dotfiles = true,
  -- git_hl = true,
  -- root_folder_modifier = ":~",
  -- -- tab_open = false,
  -- allow_resize = true,
  -- -- lsp_diagnostics = true,
  -- diagnostics = {
  --   enable = true,
  --   icons = {
  --     hint = "",
  --     info = "",
  --     warning = "",
  --     error = "",
  --   }
  -- },
  -- disable_netrw = false,
  -- bindings = {
  --   -- ["<CR>"] = ":YourVimFunction()<cr>",
  --   -- ["u"] = ":lua require'some_module'.some_function()<cr>",

  --   -- default mappings
  --   ["<CR>"]           = tree_cb("edit"),
  --   ["o"]              = tree_cb("edit"),
  --   ["<2-LeftMouse>"]  = tree_cb("edit"),
  --   ["<2-RightMouse>"] = tree_cb("cd"),
  --   ["<C-]>"]          = tree_cb("cd"),
  --   ["<C-v>"]          = tree_cb("vsplit"),
  --   ["<C-x>"]          = tree_cb("split"),
  --   ["<C-t>"]          = tree_cb("tabnew"),
  --   ["<"]              = tree_cb("prev_sibling"),
  --   [">"]              = tree_cb("next_sibling"),
  --   ["<BS>"]           = tree_cb("close_node"),
  --   ["<S-CR>"]         = tree_cb("close_node"),
  --   ["<Tab>"]          = tree_cb("preview"),
  --   ["I"]              = tree_cb("toggle_ignored"),
  --   ["H"]              = tree_cb("toggle_dotfiles"),
  --   ["R"]              = tree_cb("refresh"),
  --   ["a"]              = tree_cb("create"),
  --   ["d"]              = tree_cb("remove"),
  --   ["r"]              = tree_cb("rename"),
  --   ["<C-r>"]          = tree_cb("full_rename"),
  --   ["x"]              = tree_cb("cut"),
  --   ["c"]              = tree_cb("copy"),
  --   ["p"]              = tree_cb("paste"),
  --   ["y"]              = tree_cb("copy_name"),
  --   ["Y"]              = tree_cb("copy_path"),
  --   ["gy"]             = tree_cb("copy_absolute_path"),
  --   ["[c"]             = tree_cb("prev_git_item"),
  --   ["]c"]             = tree_cb("next_git_item"),
  --   ["-"]              = tree_cb("dir_up"),
  --   ["q"]              = tree_cb("close"),
  -- }
  renderer = {
    icons = {
      show = {
        git = true,
        folder = true,
        file = true
      },
      glyphs = {
        default = " ",
        symlink = " ",
        git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★"
        },
        folder = {
            default = "",
            open = "",
            symlink = ""
        }

      }
    }
  }
}

cmd "hi NvimTreeFolderIcon guifg = #268bd2"
cmd "hi NvimTreeFolderName guifg = #268bd2"
cmd "hi NvimTreeIndentMarker guifg=#073642"

-- Gitsigns
require("gitsigns").setup {
    signs = {
        add = {hl = "DiffAdd", text = "▌", numhl = "GitSignsAddNr"},
        change = {hl = "DiffChange", text = "▌", numhl = "GitSignsChangeNr"},
        delete = {hl = "DiffDelete", text = "_", numhl = "GitSignsDeleteNr"},
        topdelete = {hl = "DiffDelete", text = "‾", numhl = "GitSignsDeleteNr"},
        changedelete = {hl = "DiffChange", text = "~", numhl = "GitSignsChangeNr"}
    },
    numhl = false,
    keymaps = {
        -- Default keymap options
        noremap = true,
        buffer = true,
        ["n ]c"] = {expr = true, '&diff ? \']c\' : \'<cmd>lua require"gitsigns".next_hunk()<CR>\''},
        ["n [c"] = {expr = true, '&diff ? \'[c\' : \'<cmd>lua require"gitsigns".prev_hunk()<CR>\''},
        ["n <leader>hs"] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
        ["n <leader>hu"] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
        ["n <leader>hr"] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
        ["n <leader>hp"] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
        ["n <leader>hb"] = '<cmd>lua require"gitsigns".blame_line()<CR>'
    },
    watch_gitdir = {
        interval = 100
    },
    sign_priority = 5,
    status_formatter = nil -- Use default
}

-- local actions = require("diffview.actions")
require("diffview").setup()


-- LSP_signature

cfg = {}

require("nvim-autopairs").setup({
  check_ts = true
})

-- hide line numbers in terminal windows
vim.api.nvim_exec([[
   au BufEnter term://* setlocal nonumber
]], false)

-- inactive statuslines as thin splitlines
cmd("highlight! StatusLineNC gui=underline guibg=NONE guifg=#073642")

-- cmd "hi clear CursorLine"
cmd "hi cursorlinenr guibg=NONE guifg=#fdf6e3"


-- Minimap
g.minimap_width = 10
g.minimap_auto_start = 1
g.minimap_auto_start_win_enter = 1
g.minimap_highlight_range = 1
g.minimap_block_buftypes = {'terminal', 'help'}

-- quick-scope
g.qs_highlight_on_keys = {'f', 'F', 't', 'T', 'à', 'À'}  -- à doesn't seem to work?
g.qs_buftype_blacklist = {'terminal', 'nofile'}


vim.cmd('colorscheme base16-railscasts')
--vim.cmd("set background=dark")
