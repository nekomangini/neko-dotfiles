return {
  'goolord/alpha-nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local alpha = require 'alpha'
    local dashboard = require 'alpha.themes.dashboard'
    local resession = require("resession")
    resession.setup()

    dashboard.section.header.val = {
      -- [[                               __                ]],
      -- [[  ___     ___    ___   __  __ /\_\    ___ ___    ]],
      -- [[ / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
      -- [[/\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
      -- [[\ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
      -- [[ \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
      [[  ⠀⠀⠀⠀⠀⠀⣀⡠⠄⠒⠠⢄⠀⣀⠤⠒⠂⠤⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠤⠐⠒⠤⡀⢀⡠⠔⠂⠠⢄⣀⠀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⠀⣠⠞⠂⢀⣀⣀⠀⠀⠉⠁⠀⣀⣀⣀⠀⠑⣤⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣴⠋⠀⣀⣀⣀⠀⠈⠉⠀⢀⣀⣀⠀⠈⠲⡀⠀⠀⠀⠀ ]],
      [[ ⠀⠀⠀⣸⡏⠀⣴⢋⠤⢌⠙⠆⠀⢠⠎⢁⠤⠍⢧⠀⠀⣷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡿⠁⢠⡞⡡⠤⡉⠳⠀⠀⡴⠉⡠⠬⡹⡄⠀⢸⡄⠀⠀⠀ ]],
      [[ ⠀⠀⢀⣽⡁⠀⣿⡀⢀⡘⡄⡇⠀⢸⢢⠇⢀⢢⣺⠀⠀⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣨⣇⠀⢸⣏⠀⡐⢣⢸⠀⠀⡗⡜⢀⠐⣄⣧⠀⢸⣇⠀⠀⠀ ]],
      [[ ⠀⣰⠉⠙⠷⠀⢛⣟⣦⣄⣣⡇⠀⠘⣎⣰⣤⣾⡿⠁⠴⠋⠈⠱⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⡎⠉⠻⠆⠈⣿⣳⣤⣙⣼⠂⠀⢻⣁⣦⣼⣿⠇⠠⠞⠁⠙⣆⠀ ]],
      [[ ⣺⠁⠀⣠⠒⠶⣄⠉⠓⢚⣣⡠⠤⢤⣈⡓⠛⠋⢠⠖⠲⢤⡀⠀⢷⠀⠀⠀⠀⠀⠀⠀⢐⡟⠀⢀⠔⠲⢦⡈⠑⠛⣋⣡⠤⠤⣄⣙⠚⠛⢁⡴⠒⠦⣄⠀⠨⡆ ]],
      [[ ⣽⠀⢸⠄⠣⡐⢹⠀⡤⠏⢁⢀⢀⠠⢀⠉⢦⡀⢹⡁⠔⡁⣗⠀⢸⡅⠀⠀⠀⠀⠀⠀⢸⡇⠀⡗⠘⢄⢈⡇⢠⠖⠉⡀⣀⠠⠄⡈⠳⣄⠈⣟⠠⢈⢸⠀⠀⣿ ]],
      [[ ⠹⣄⠸⣷⣤⣧⠞⣾⢁⠐⢀⠀⠠⠄⣀⠑⠄⢱⡸⣧⣴⣶⡟⢠⡟⠁⠀⠀⠀⠀⠀⠀⠈⢷⡀⢿⣦⣾⡼⢳⡏⡠⠁⡀⠠⠠⢄⠈⠢⠈⣆⢿⣤⢶⣾⠃⣼⠃ ]],
      [[ ⠀⡸⢷⠈⠉⠉⢸⡟⣆⠀⢂⠌⣁⠒⡈⠢⢈⣾⣧⠈⠉⠉⢴⢏⡀⠀⠀⠀⠀⠀⠀⠀⠀⢀⠿⡆⠉⠉⠁⣾⣳⠀⡀⠆⡑⠄⢂⠙⠄⣱⣿⠀⠉⠉⠡⡾⡅⠀ ]],
      [[ ⠐⡇⠀⠀⠀⠀⠘⣿⡞⣦⣅⣂⣄⣂⣰⣵⣻⣽⠏⠀⠀⠀⠀⢰⡆⠀⠀⠀⠀⠀⠀⠀⠀⢺⠀⠀⠀⠀⠀⢻⣷⢳⣴⣈⣐⣈⣄⣮⣞⣯⡿⠂⠀⠀⠀⠀⣸⠀ ]],
      [[ ⠀⠘⢄⠀⠀⠀⠀⠈⠻⠶⣝⣮⣳⣭⣳⣧⠟⠋⠀⠀⠀⠀⣠⠟⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠣⡀⠀⠀⠀⠀⠙⠷⢮⣽⣭⣻⣜⣷⠾⠛⠁⠀⠀⠀⠀⡼⠃⠀ ]],
      [[ ⠀⠀⠈⡗⢠⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠁⠀⠀⠀⠀⡠⢾⡏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡆⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠀⠀⠀⠀⢀⠴⣟⠁⠀⠀ ]],
      [[ ⠀⠀⠀⢸⠏⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠨⡷⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⢻⠇⠀⠀⠀ ]],
      [[ ⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢸⡅⠀⠀⠀ ]],
      [[ ⠀⠀⠀⢽⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣾⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢨⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢰⡇⠀⠀⠀ ]],
    }
    dashboard.section.buttons.val = {
      dashboard.button("n", "  New file", ":enew <BAR> startinsert <cr>"),
      dashboard.button("f", "󰍉  Find file", "<cmd>Telescope find_files<cr>"),
      dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
      dashboard.button("w", "󰍉  Find word", "<cmd>Telescope live_grep<cr>"),
      dashboard.button("b", "󰃁  Bookmarks", "<cmd>Telescope marks<cr>"),
      dashboard.button("l", "󰏖  Load last session", resession.load),
      -- dashboard.button("s", "󰆓  Save session", resession.save),
      dashboard.button("q", "󰅚  Quit Nekovim", ":qa<CR>"),
    }
    -- local handle = io.popen('fortune')
    -- local fortune = handle:read("*a")
    -- handle:close()
    -- dashboard.section.footer.val = fortune

    dashboard.config.opts.noautocmd = true

    vim.cmd [[autocmd User AlphaReady echo 'ready']]

    alpha.setup(dashboard.config)
  end
}
