local lsp = require("lsp-zero")

lsp.preset("recommended")

require('mason').setup({})
require('mason-lspconfig').setup({
  -- Replace the language servers listed here
  -- with the ones you want to install
  ensure_installed = {	'ts_ls',
  'eslint',
  'clangd',
  'emmet_language_server',
  'gopls',
  'html',
  'angularls',
  'dockerls',
  'biome',
  'lua_ls',
  'autotools_ls',
  'tsserver',
  },
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  }
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = false}),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<Up>'] = cmp.mapping.select_prev_item({behavior = 'select'}),
    ['<Down>'] = cmp.mapping.select_next_item({behavior = 'select'}),
    ['<C-p>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
    ['<C-n>'] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_next_item({behavior = 'insert'})
      else
        cmp.complete()
      end
    end),
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false, noremap = true, silent = true,}

	vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "<leader>gD", function() vim.lsp.buf.declaration() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
end)

local on_attach = function(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }

  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

  vim.api.nvim_create_user_command("AutoImport", function()
      local params = vim.lsp.util.make_range_params()
      params.context = { diagnostics = {}, only = { "quickfix" } }

      local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
      if not result or vim.tbl_isempty(result) then
          print("No import actions available for the symbol under the cursor.")
          return
      end

      for _, res in pairs(result) do
          print(result, "first loop")
          for _, action in pairs(res.result or {}) do
              print(action.title)
              if action.title:lower():match("import") then
                  if action.edit then
                      vim.lsp.util.apply_workspace_edit(action.edit, "utf-16")
                  end

                  if action.command then
                      vim.lsp.buf.execute_command(action.command)
                  end
                  print("Successfully imported the symbol.")
                  return
              end
          end
      end

      print("No suitable import action found for the symbol.")
  end, { desc = "Try to import the symbol under the cursor" })
end

require("lspconfig")["ts_ls"].setup({
  on_attach = on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(), -- Optional: for completion capabilities
    commands = {
        OrganizeImports = {
            function()
                vim.lsp.buf.code_action({ only = { "source.organizeImports" } })
            end,
            description = "Organize Imports"
        }
    }
})

lsp.setup()


