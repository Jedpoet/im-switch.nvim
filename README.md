# im-switch.nvim

🌸 A simple Windows-only Neovim plugin to auto-switch input method between Chinese (or other language) and English using Windows API (imm32.dll).

🌸 一個簡單的Neovim插件，讓你不用每次在Normal 和 Instrt 模式中切換時要一直切換輸入法。使用Windows的API(imm32.dll)，不用另外安裝其他工具。

## Features

- Auto switch to English when leaving insert mode.
- Restore previous input method when entering insert mode.
- Directly call Windows API, no external tool required.
- No global side effect — only affects current foreground window.
- 當離開Insert模式時，自動切換為英文輸入法
- 當進入Insert模式時，還原離開時使用的輸入法
- 不用額外安裝其他軟體，直接呼叫Windows的API
- 本地生效，不會影響其他視窗

## Quickstart
---

### Requirements

- [neovim](https://github.com/neovim/neovim) 0.9+
- At least one installed English input method（安裝任意一種純英文輸入法

🔧 Install

Install the plugin with your preferred package manager:

```lua
-- lazy.nvim
{
    "Jedpoet/im-switch.nvim",
    cond = vim.loop.os_uname().sysname == "Windows_NT",
    config = function()
        require("im-switch").setup()
    end,
},
```
# 📚 Usage

The plugin works automatically after installation and setup — no extra commands needed.

安裝完成後自動生效，無須額外指令。

# 📎 Note

- Windows only
- If you're using [Neovide](https://neovide.dev/), add the following setting to your init.lua (or equivalent config):
- 目前只支援Windows
- 如果你使用[Neovide](https://neovide.dev/)，請把下面的設定加到你的nvim設定檔中

```lua
if vim.g.neovide then
    vim.g.neovide_input_ime = false
end
```

# 📦 License

MIT © 2025 Jedpoet
