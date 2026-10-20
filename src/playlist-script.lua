-- ~/.config/mpv/scripts/playlist-script.lua

-- show playlist
mp.add_key_binding("ctrl+p", "show-playlist", function()
    local playlist = mp.get_property_native("playlist") -- get playlist
    if not playlist or #playlist == 0 then -- no playlist
        mp.osd_message("Playlist is empty", 2)
        return
    end

    local lines = {}
    for i, item in ipairs(playlist) do -- loop through playlist
        local mark = item.playing and "▶ " or "  " -- show playing video
        local title = item.title or item.filename or "Unknown" -- get title
        for item in string.gmatch(title, "([^/]+)") do -- get title
            title = item -- set title
        end
        table.insert(lines, mark .. i .. ". " .. title) -- insert title
    end

    mp.osd_message(table.concat(lines, "\n"), 5) -- show playlist
end)