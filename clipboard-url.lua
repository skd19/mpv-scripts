-- Save as ~/.config/mpv/scripts/clipboard-url.lua

local function get_clipboard()
    local OS = package.config:sub(1,1) == '\\' and 'Windows' or
        (io.popen('uname -s'):read('*a') or ''):gsub('[\n\r]+', '')  -- Detect OS
    
    local cmd
    if OS == 'Darwin' then  -- macOS
        cmd = 'pbpaste'
    elseif OS == 'Windows' then
        cmd = 'powershell -Command Get-Clipboard'
    else  -- Linux/BSD
        cmd = 'xclip -selection clipboard -o 2>/dev/null'
    end

    local handle = io.popen(cmd)
    if not handle then return nil end
    local content = handle:read('*a')
    handle:close()
    
    return content and content:gsub('^%s*(.-)%s*$', '%1')  -- Trim whitespace
end

mp.add_key_binding('ctrl+v', 'paste-url', function()
    local success, clipboard = pcall(get_clipboard)
    
    if not success or not clipboard then
        mp.osd_message("Failed to access clipboard")
        return
    end
    
    -- Simple URL validation pattern
    local url_pattern = '^[%w]+://.*'
    if clipboard:match(url_pattern) then
        mp.commandv('loadfile', clipboard)
        mp.osd_message("Loading URL: " .. clipboard)
    else
        mp.osd_message("No valid URL found in clipboard")
    end
end)
