return {
  ensure_installed = {
    "bash", "c", "c_sharp", "comment", "cpp", "css", "dockerfile", "dot",
    "go", "gomod", "html", "http", "javascript", "jsdoc", "json", "json5",
    "jsonc", "latex", "lua", "make", "markdown", "php", "python", "ruby",
    "scss", "toml", "vim", "yaml",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown", "pandoc.markdown" },
  },
  rainbow = {
    extended_mode = true,
  },
  textobjects = { enable = true },
}
