-- Helper to detect which Ruby linter/formatter the project uses
local function detect_ruby_formatter()
  local gemfile = vim.fn.findfile("Gemfile", ".;")
  if gemfile == "" then
    return "rubocop" -- default fallback
  end

  local gemfile_content = vim.fn.readfile(gemfile)
  local content = table.concat(gemfile_content, "\n")

  if content:match("['\"]standard['\"]") or content:match("['\"]standardrb['\"]") then
    return "standardrb"
  end
  return "rubocop"
end

return {
  -- Override conform.nvim for Ruby auto-detection
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.ruby = function()
        return { detect_ruby_formatter() }
      end

      -- Use -A (auto-correct-all) instead of -a to fix indentation
      opts.formatters = opts.formatters or {}
      opts.formatters.rubocop = {
        args = {
          "--server",
          "-A",
          "-f",
          "quiet",
          "--stderr",
          "--stdin",
          "$FILENAME",
        },
      }

      return opts
    end,
  },

  -- Configure ruby_lsp to auto-detect formatter
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        ruby_lsp = {
          init_options = {
            formatter = "auto",
            linters = { "standard", "rubocop" },
          },
        },
      },
    },
  },
}
