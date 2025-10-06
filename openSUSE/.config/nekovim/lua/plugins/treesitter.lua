return {
	{
		"nvim-treesitter/nvim-treesitter",
		"nvim-treesitter/nvim-treesitter-context",
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
          "bash",
          "c",
          "cpp",
          "css",
					"dart",
					"diff",
          "fish",
					"go",
					"gomod",
					"gosum",
					"gowork",
					"jsdoc",
					"json",
					"jsonc",
					"lua",
					"luadoc",
					"luap",
					"markdown",
					"markdown_inline",
					"printf",
					"query",
					"regex",
					"rust",
					"toml",
					"vim",
					"vimdoc",
					"xml",
					"yaml",
          -- python
          "python",
          "requirements",  -- for requirements.txt files
          "dockerfile",    -- often used with Python projects
          "gitignore",     -- for .gitignore files
          "ini",           -- for setup.cfg, pyproject.toml alternatives
          -- html
          "html",
          "css",
          "astro",
          "javascript",
          "typescript",
				},
        context_commentstring = {
          enable = true,
          enable_autocmd = false,
        },
        highlight = { enable = true },
        indent = { enable = true },
        autotag = { enable = true },
			})
		end,
	},
}
