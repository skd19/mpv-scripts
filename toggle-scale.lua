local scale_state = 1.0

mp.add_key_binding('1', 'toggle-window-scale', function()
    scale_state = scale_state == 1.0 and 0.5 or 1.0
    -- Reset video-scale to ensure window scaling works properly
    mp.set_property('video-scale', 1)
    -- Apply window scaling
    mp.set_property('window-scale', scale_state)
    mp.osd_message("Window scale: " .. (scale_state * 100) .. "%")
end)
