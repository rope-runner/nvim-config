
-- ~/.config/nvim/after/plugin/lsp.lua
-- NVIM 0.10.x — lspconfig + Mason binaries + Blink completion

-------------------------------------------------------
-- Mason binary resolver
-------------------------------------------------------
local MASON = vim.fn.stdpath('data') .. '/mason'
local BIN   = MASON .. '/bin'
local function bin(exe) return BIN .. '/' .. exe end
local function exists(p) return vim.fn.filereadable(p) == 1 end

-------------------------------------------------------
-- Blink (completion)
-------------------------------------------------------
vim.o.completeopt = 'menu,menuone,noselect'

local ok_blink, blink = pcall(require, 'blink.cmp')
if ok_blink then
  blink.setup({
    keymap  = {
      preset = 'default',
      ['<CR>'] = { 'accept', 'fallback' }, -- accept selection; newline only if no menu
    },
    sources = { default = { 'lsp' } },
    -- keep Lua fuzzy to avoid native binary requirement
    fuzzy   = { use_native = false },

    completion = {
        documentation = {
            auto_show = true,          -- show docs as you move in the list
            auto_show_delay_ms = 60,   -- quick
            window = { border = 'rounded', max_width = 84, max_height = 20 },
        },
    },
})
end

-- LSP capabilities (default is fine for Blink)
local caps = vim.lsp.protocol.make_client_capabilities()

-------------------------------------------------------
-- lspconfig helpers
-------------------------------------------------------
local lspconfig = require('lspconfig')
local util      = require('lspconfig.util')

-- Pretty signature float (and non-focusable)
vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    focusable = false,
    close_events = { "CursorMoved", "BufHidden", "InsertLeave" },
    max_width = 84,
  })

-- Make CursorHoldI responsive
if vim.o.updatetime > 250 then
  vim.o.updatetime = 250
end

-- Debounced signature trigger
local sig_pending = false
local function trigger_sig()
  if sig_pending then return end
  sig_pending = true
  vim.defer_fn(function()
    sig_pending = false
    pcall(vim.lsp.buf.signature_help)
  end, 80)
end

-- Are we inside an argument list? (handles existing "()")
local function inside_args()
  local line = vim.api.nvim_get_current_line()
  local col  = vim.api.nvim_win_get_cursor(0)[2] + 1 -- 1-based
  local depth = 0
  for i = col, 1, -1 do
    local ch = line:sub(i, i)
    if ch == ')' then
      depth = depth + 1
    elseif ch == '(' then
      if depth == 0 then
        return true -- nearest unmatched '(' to the left → we're inside args
      else
        depth = depth - 1
      end
    end
  end
  return false
end


local on_attach = function(_, bufnr)
  local o = { buffer = bufnr, noremap = true, silent = true }

  -- navigation
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, o)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, o)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, o)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, o)

  -- docs / signatures
  vim.keymap.set("n", "K",  vim.lsp.buf.hover, o)               -- hover on symbol
  vim.keymap.set("i", "<C-h>", function() pcall(vim.lsp.buf.signature_help) end, o)

  -- inlay hints (Neovim 0.10+)
  -- per-buffer group to avoid dupes on reload
  local grp = vim.api.nvim_create_augroup("LspSig_" .. bufnr, { clear = true })

  -- Auto-show/refresh signatures while editing or moving inside arguments
  vim.api.nvim_create_autocmd("InsertCharPre", {
    group = grp,
    buffer = bufnr,
    callback = function(args)
      if args.char == "(" or args.char == "," then
        trigger_sig()
      end
    end,
  })

  vim.api.nvim_create_autocmd({ "TextChangedI", "CursorHoldI", "CursorMovedI" }, {
    group = grp,
    buffer = bufnr,
    callback = function()
      if inside_args() then
        trigger_sig()
      end
    end,
  })

  -- Show signature if you enter Insert mode already inside ()
 vim.api.nvim_create_autocmd("InsertEnter", {
    group = grp,
    buffer = bufnr,
    callback = function()
      trigger_sig()  -- unconditional
    end,
  })

  -- Normal → Insert transitions (no buffer+pattern together)
  vim.api.nvim_create_autocmd("ModeChanged", {
    group = grp,
    pattern = "n:i",
    callback = function()
      if vim.api.nvim_get_current_buf() ~= bufnr then return end
      trigger_sig()  -- unconditional
    end,
  })

  if vim.bo[bufnr].filetype == "rust" then
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = false })
      end,
    })
  end
end


local function setup_if_present(name, cfg)
  if not lspconfig[name] then return end
  cfg = vim.tbl_deep_extend('force', { on_attach = on_attach, capabilities = caps }, cfg or {})
  lspconfig[name].setup(cfg)
end

-------------------------------------------------------
-- Servers (install via :Mason if missing)
-------------------------------------------------------

-- Lua (Neovim config)
if exists(bin('lua-language-server')) then
  setup_if_present('lua_ls', {
    cmd = { bin('lua-language-server') },
    settings = {
      Lua = {
        workspace   = { checkThirdParty = false },
        diagnostics = { globals = { 'vim' } },
        hint = { enable = true },
      },
    },
  })
end

-- TypeScript (ts_ls or tsserver)
if exists(bin('typescript-language-server')) then
  if lspconfig.ts_ls then
    setup_if_present('ts_ls', {
      cmd = { bin('typescript-language-server'), '--stdio' },
    })
  else
    setup_if_present('tsserver', {
      cmd = { bin('typescript-language-server'), '--stdio' },
    })
  end
end

-- Angular
if exists(bin('angular-language-server')) then
  setup_if_present('angularls', {
    cmd = { bin('angular-language-server'), '--stdio' },
    root_dir = util.root_pattern('angular.json', 'project.json', 'package.json', '.git'),
    single_file_support = false,
  })
end

-- Go
if exists(bin('gopls')) then
  setup_if_present('gopls', {
    cmd = { bin('gopls') },
    settings = {
      gopls = {
        analyses = { unusedparams = true, unusedwrite = true },
        staticcheck = true,
        usePlaceholders = true,
        completeUnimported = true,
      },
    },
  })
end

-- C/C++
if exists(bin('clangd')) then
  setup_if_present('clangd', {
    cmd = { bin('clangd') },
  })
end

if exists(bin('rust-analyzer')) or vim.fn.executable('rust-analyzer') == 1 then
  setup_if_present('rust_analyzer', {
    cmd = { bin('rust-analyzer') },
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = "clippy" },
        inlayHints = {
          enable = true,
          typeHints = true,
          parameterHints = true,
          chainingHints = true,
        },
        completion = {
          autoimport = { enable = true },
        },
      },
    },
  })
end
-- HTML / CSS / ESLint / Docker / Emmet
if exists(bin('vscode-html-language-server')) then
  setup_if_present('html',  { cmd = { bin('vscode-html-language-server'),  '--stdio' } })
end
if exists(bin('vscode-css-language-server')) then
  setup_if_present('cssls', {
    cmd = { bin('vscode-css-language-server'), '--stdio' },
    settings = {
      css = { validate = true },
      scss = { validate = true },
      less = { validate = true },
    },
  })
end
if exists(bin('vscode-eslint-language-server')) then
  setup_if_present('eslint',{ cmd = { bin('vscode-eslint-language-server'), '--stdio' } })
end
if exists(bin('docker-langserver')) then
  setup_if_present('dockerls', { cmd = { bin('docker-langserver'), '--stdio' } })
end
if exists(bin('emmet-language-server')) then
  setup_if_present('emmet_ls', { cmd = { bin('emmet-language-server'), '--stdio' } })
end

