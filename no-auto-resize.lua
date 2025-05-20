local stored_width = nil
local stored_height = nil

mp.register_event("end-file", function()
    stored_width = mp.get_property_native("current-window-width")
    stored_height = mp.get_property_native("current-window-height")
end)

mp.register_event("file-loaded", function()
    if stored_width and stored_height then
        mp.set_property("geometry", string.format("%dx%d", stored_width, stored_height))
    end
end)


local locked = false

mp.register_event("file-loaded", function()
    if not locked then
        local w = mp.get_property_native("current-window-width")
        local h = mp.get_property_native("current-window-height")
        mp.set_property("geometry", string.format("%dx%d", w, h))
        locked = true
    end
end)
