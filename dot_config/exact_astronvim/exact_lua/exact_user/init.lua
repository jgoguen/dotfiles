local settings_paths = {
  "settings/*.vim",
  "settings/plugins/*.vim",
  "settings/post/*.vim",
}

local config = {
  -- Configure AstroNvim updates
  updater = {
    remote = "origin",
    channel = "stable",
    version = "latest",
    pin_plugins = nil,
    skip_prompts = false,
    show_changelog = true,
  },

  colorscheme = 'tokyonight',

  polish = function()
    local has_telescope, telescope = pcall(require, 'telescope')
    if has_telescope then
      telescope.load_extension('fzf')
    end

    require("keybindings").setup()

    for _, path in ipairs(settings_paths) do
      local settings = vim.fn.globpath(vim.o.runtimepath, path, 0, 1)
      for _, f in ipairs(settings) do
        vim.cmd("source " .. f)
      end
    end

    local xdg_config = os.getenv('XDG_CONFIG_HOME')
    if xdg_config == nil then
      xdg_config = os.getenv('HOME') .. '/.config'
    end

    if vim.fn.filereadable(xdg_config .. '/vim-local.vim') ~= 0 then
      vim.cmd('source ' .. xdg_config .. '/vim-local.vim')
    end

    if vim.fn.filereadable(xdg_config .. '/vim-local.lua') ~= 0 then
      vim.cmd('source ' .. xdg_config .. '/vim-local.lua')
    end
  end,
}

return config
