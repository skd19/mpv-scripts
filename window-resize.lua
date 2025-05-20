-- window-resize.lua

local mp = require 'mp'
local utils = require 'mp.utils'

-- Size step in pixels
local step = 50

function resize(direction)
    local w, h = mp.get_property_native("osd-width"), mp.get_property_native("osd-height")

    if not w or not h then return end

    local scale = (direction == "increase") and 1 or -1
    local new_w = w + (step * scale)
    local new_h = h + (step * scale)

    mp.commandv("set", "window-scale", "1") -- reset scaling
    mp.commandv("script-message", "osc-visible") -- workaround for some GUI bugs

    mp.set_property("geometry", string.format("%dx%d", new_w, new_h))
end

mp.register_script_message("window-resize", resize)
