local status, lualine = pcall(require, "lualine")
local icon_loaded, icon = pcall(require, "nvim-web-devicons")

if (not status) then return end
if (not icon_loaded) then return end

lualine.setup {
    options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {{
      'buffers',
      mode = 1,
      icons_enabled = false,
    }},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {{
      'filename',
      path = 1,
      shorting_target = 20
    }},
    lualine_x = {{
      'filetype',
      colored = true,
      icon = { align = 'left' },
    }},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
