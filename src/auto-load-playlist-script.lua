-- ~/.config/mpv/scripts/auto-load-playlist-script.lua

local function dirname(path)
    -- strip trailing slash, then remove last segment
    path = path:gsub("/+$", "")
    return path:match("^(.*)/[^/]*$") or "."
end

local function basename(path)
    return path:match("([^/]+)$") or path
end

-- returns prefix up to first space; if no space, returns name without extension
local function key_of(name)
    local space = name:find(" ", 1, true)
    if space then
        return name:sub(1, space - 1)
    end
    -- no space: use filename without extension as key
    return name:match("^(.-)%.[^%.]+$") or name
end

local function list_files(dir)
    local files = {}
    -- NOTE: this is Linux-only. For portability use lfs; but for Telegram Desktop path this is fine.
    local p = io.popen('find "' .. dir .. '" -maxdepth 1 -type f -printf "%f\\n" 2>/dev/null')
    if not p then return files end
    for line in p:lines() do
        files[#files + 1] = line
    end
    p:close()

    -- Key: sort alphabetically
    table.sort(files, function(a, b)
        return a < b
    end)
    return files
end

mp.register_event("start-file", function()
    local path = mp.get_property("path")
    if not path then return end

    -- already has siblings? skip (avoid re-adding on every file switch)
    local playlist = mp.get_property_native("playlist") or {}
    if #playlist > 1 then return end

    local dir = dirname(path)
    local self_name = basename(path)
    local key = key_of(self_name)

    local added = 0
    local place_to_be_added = 0 -- keep track of the position where the current playing file should be at
    for _, name in ipairs(list_files(dir)) do
        if name ~= self_name and key_of(name) == key then
            mp.commandv("loadfile", dir .. "/" .. name, "append")
            added = added + 1
        end
        if name == self_name then
            place_to_be_added = added + 1
        end
    end

    if added > 0 then
        -- move the position
        mp.commandv("playlist-move", 0, place_to_be_added)
        mp.osd_message("Added " .. added .. " similar file(s) to playlist", 2)
    end
end)