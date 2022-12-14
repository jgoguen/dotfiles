return {
  autoselect_one = true,
  include_current = true,
  filter_rules = {
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { 'neo-tree', "neo-tree-popup", "notify", "Trouble" },
      -- if the buffer type is one of following, the window will be ignored
      buftype = { 'terminal', "quickfix" },
    },
  },
}
