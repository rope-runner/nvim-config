require('git-conflict').setup({
  default_mappings = true, -- Enable default key bindings
  disable_diagnostics = false, -- Temporarily disable diagnostics during conflicts
  highlights = { -- Customize highlights if needed
    incoming = 'DiffText',
    current = 'DiffAdd',
  },
})
