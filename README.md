# nvim-im-switch

🌸 A simple Windows-only Neovim plugin to auto-switch input method between Chinese (or other language) and English using Windows API (imm32.dll).
🌸 

## Features

- Auto switch to English when leaving insert mode.
- Restore previous input method when entering insert mode.
- Directly call Windows API, no external tool required.
- No global side effect — only affects current foreground window.

## Quickstart
---

### Requirements

- [neovim](https://github.com/neovim/neovim) 0.9+

🔧 Install

Install the plugin with your preferred package manager:

```lua
-- lazy.nvim
{
  "jedpoet/nvim-im-switch",
  cond = vim.loop.os_uname().sysname == "Windows_NT",
  config = function()
    require("nvim_im_switch").setup()
  end,
}
```
# 📚 Usage

Automatically works after setup.

# 📎 Note

- Windows only
- if you use [neovide](https://neovide.dev/) add this to init.lua or somewhere

```lua
if vim.g.neovide then
    vim.g.neovide_input_ime = false
end
```
