return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        pyright = {},
        tsserver = {},
        lua_ls = {},
	rust_analyzer = {},
	nixd = {},
	nginx_language_server = {},
	solc = {},
	svelte = {},
	tailwindcss = {},
	docker_compose_language_service = {},
	docker_language_server = {},
	bashls = {},
	gopls = {},
      },
    },
  },
}
