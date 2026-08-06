local function navigate(wincmd, direction)
  local previous_window = vim.api.nvim_get_current_win()
  vim.cmd("wincmd " .. wincmd)
  if vim.api.nvim_get_current_win() ~= previous_window then
    return
  end

  if vim.env.HERDR_PANE_ID and vim.env.HERDR_PANE_ID ~= "" then
    local herdr = vim.env.HERDR_BIN_PATH
    if not herdr or herdr == "" then
      herdr = "herdr"
    end
    vim.fn.system({ herdr, "pane", "focus", "--direction", direction, "--current" })
  elseif vim.env.TMUX and vim.env.TMUX ~= "" then
    local tmux_direction = { left = "Left", down = "Down", up = "Up", right = "Right" }
    pcall(vim.cmd, "TmuxNavigate" .. tmux_direction[direction])
  end
end

local function navigate_key(wincmd, direction)
  return function()
    navigate(wincmd, direction)
  end
end

return {
  {
    "christoomey/vim-tmux-navigator",
    lazy = false,
    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,
    keys = {
      { "<C-h>", navigate_key("h", "left"), desc = "Navigate left (vim/herdr)" },
      { "<C-j>", navigate_key("j", "down"), desc = "Navigate down (vim/herdr)" },
      { "<C-k>", navigate_key("k", "up"), desc = "Navigate up (vim/herdr)" },
      { "<C-l>", navigate_key("l", "right"), desc = "Navigate right (vim/herdr)" },
      { "<C-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Navigate to previous tmux pane" },
    },
  },
}
