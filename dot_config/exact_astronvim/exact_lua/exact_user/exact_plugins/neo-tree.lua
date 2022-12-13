return {
  close_if_last_window = true,
  window = {
    width = 40,
    mappings = {
      ["<CR>"] = "open_with_window_picker",
      ["a"] = {
        "add",
        config = {
          show_path = "relative",
        },
      },
      ["A"] = {
        "add_directory",
        config = {
          show_path = "relative",
        },
      },
      ["c"] = {
        "copy",
        config = {
          show_path = "relative",
        },
      },
      ["m"] = {
        "move",
        config = {
          show_path = "relative",
        },
      },
      ["i"] = "split_with_window_picker",
      ["s"] = "vsplit_with_window_picker",
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      never_show = {
        ".DS_Store",
        "thumbs.db",
      },
    },
    use_libuv_file_watcher = true,
  },
}
