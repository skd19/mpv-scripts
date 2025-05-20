-- window-scale-adjust.lua

local mp = require "mp"

local scale_step = 0.05  -- Change in scale per scroll
local min_scale = 0.1
local max_scale = 5.0

local function adjust_scale(direction)
    local current_scale = tonumber(mp.get_property("window-scale"))
    if not current_scale then return end

    if direction == "up" then
        current_scale = math.min(current_scale + scale_step, max_scale)
    elseif direction == "down" then
        current_scale = math.max(current_scale - scale_step, min_scale)
    end

    mp.set_property("window-scale", tostring(current_scale))
end

mp.register_script_message("window-scale-adjust", adjust_scale)
