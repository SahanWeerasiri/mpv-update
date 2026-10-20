-- ~/.config/mpv/scripts/repeat-script.lua

mp.add_key_binding("ctrl+r", "toggle-repeat", function()
    mp.commandv("cycle", "loop-playlist")
end)