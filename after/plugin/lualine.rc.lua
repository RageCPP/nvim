local status, lualine = pcall(require, "lualine")
local icon_loaded, icon = pcall(require, "nvim-web-devicons")

if (not status) then return end
if (not icon_loaded) then return end

local colors = {
    active_fg   = "#ffc773",
    active_bg   = "#5D2099",
    fg          = "#808080",
    bg          = "transparent",
}

-- config
local config = {
  options = {
    component_separators = '',
    section_separators = '',
    theme = {
      normal = { c = { fg = colors.fg, bg = colors.bg } },
     -- inactive = { c = { fg = colors.active_fg, bg = colors.active_bg } }
    },
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
  refresh = {
    statusline = 1000,
    tabline = 1000,
    winbar = 1000,
  }
}

local function insert(section, widget)
  table.insert(section, widget)
end

insert(config.sections.lualine_a, {
  'branch'
})

insert(config.sections.lualine_a, {
  'diff',
  colored = true
})

insert(config.sections.lualine_b, { 'diagnostics' })

insert(config.sections.lualine_x, {
  'buffers',
  mode = 0,
  icons_enabled = false,
  buffers_color = {
    active = { fg = colors.active_fg,  bg = colors.active_bg },
    normal = { fg = colors.fg, bg = colors.bg }
  }
})

insert(config.sections.lualine_x, {
  'filetype',
  colored = true,
  icon = { align = 'left' }
})

insert(config.sections.lualine_y, {'progress'})

insert(config.sections.lualine_z, {'location'})

lualine.setup(config)
