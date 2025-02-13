local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [[  ______  ______  ______  ______  ______  __  __  __   __  __   __  ______  ______    ]],
  [[ /\  == \/\  __ \/\  == \/\  ___\/\  == \/\ \/\ \/\ "-.\ \/\ "-.\ \/\  ___\/\  == \   ]],
  [[ \ \  __<\ \ \/\ \ \  _-/\ \  __\\ \  __<\ \ \_\ \ \ \-.  \ \ \-.  \ \  __\\ \  __<   ]],
  [[  \ \_\ \_\ \_____\ \_\   \ \_____\ \_\ \_\ \_____\ \_\\"\_\ \_\\"\_\ \_____\ \_\ \_\ ]],
  [[   \/_/ /_/\/_____/\/_/    \/_____/\/_/ /_/\/_____/\/_/ \/_/\/_/ \/_/\/_____/\/_/ /_/ ]],
  [[                                                                                     ]],
}
-- Buttons
dashboard.section.buttons.val = {
    dashboard.button("f", "📂 Find File", ":Telescope find_files<CR>"),
    dashboard.button("p", "📁 Open Project", ":Telescope projects<CR>"),
    dashboard.button("n", "🆕 New File", ":ene <BAR> startinsert<CR>"),
    dashboard.button("q", "❌ Quit", ":qa<CR>"),
}

-- Setup Alpha
alpha.setup(dashboard.opts)

