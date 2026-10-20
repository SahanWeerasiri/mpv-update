-- ~/.config/mpv/scripts/my_first_script.lua

-- Bind the key "Ctrl+h" to a function
mp.add_key_binding("ctrl+h", "show-hello", function()
    -- This function runs when the key is pressed
    mp.osd_message("Hello from my custom script!", 3) -- 3 seconds
end)