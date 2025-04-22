-- 提供呼叫函數
local M = {}

if vim.g.neovide then
    function M.setup()
        vim.g.neovide_input_ime = false
        vim.api.nvim_create_autocmd("InsertEnter", {
            callback = function()
                vim.g.neovide_input_ime = true
            end,
        })
        vim.api.nvim_create_autocmd("InsertLeave", {
            callback = function()
                vim.g.neovide_input_ime = false
            end,
        })
    end
    return M
end

if vim.loop.os_uname().sysname ~= "Windows_NT" then
    function M.setup()
    end
    return M
end

local ffi = require("ffi")

-- 宣告 Windows API
ffi.cdef[[
    typedef void* HWND;
    typedef int BOOL;
    typedef unsigned long DWORD;
    HWND GetForegroundWindow(void);
    DWORD GetWindowThreadProcessId(HWND hWnd, DWORD* lpdwProcessId);
    long GetKeyboardLayout(DWORD idThread);
    BOOL PostMessageA(HWND hWnd, unsigned int Msg, unsigned long wParam, long lParam);
]]

-- 常數
local WM_INPUTLANGCHANGEREQUEST = 0x0050

-- 取得前景視窗
local function get_foreground_window()
    return ffi.C.GetForegroundWindow()
end

-- 取得當前輸入法 layout
local function get_keyboard_layout()
    local hwnd = get_foreground_window()
    local pid = ffi.new("DWORD[1]")
    local tid = ffi.C.GetWindowThreadProcessId(hwnd, pid)
    local layout = ffi.C.GetKeyboardLayout(tid)
    return layout
end

-- 設定輸入法 (layout 為 16 進位 4 碼，通常 0x0409 英文，0x0804 中文簡體，0x0404 繁體)
local function set_keyboard_layout(layout)
    local hwnd = get_foreground_window()
    ffi.C.PostMessageA(hwnd, WM_INPUTLANGCHANGEREQUEST, 0, layout)
end

-- 初始 layout 記錄
M.last_im_layout = 0x0409

-- 取當前輸入法 layout
function M.get_current_layout()
    return get_keyboard_layout()
end

-- 英文輸入
function M.to_english()
    set_keyboard_layout(0x0409) -- US English
end

-- 中文輸入 (依你系統的 layout id 調整)
function M.to_chinese()
    set_keyboard_layout(0x0404) -- 中文繁體
end

-- 自動掛載 autocmd
function M.setup()
    -- 讀取當前 layout
    M.last_im_layout = M.get_current_layout()

    -- 進入 Insert 恢復離開時的 layout
    vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
            set_keyboard_layout(M.last_im_layout)
        end,
    })

    -- 離開 Insert 記錄當前 layout 並切英文
    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            M.last_im_layout = M.get_current_layout()
            M.to_english()
        end,
    })

    vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
            M.to_english()
        end,
    })

end

return M
