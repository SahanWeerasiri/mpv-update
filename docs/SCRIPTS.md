# MPV Lua Scripts Reference

This document provides a technical overview of each custom Lua script in this repository, including event triggers, mpv API properties, operational behavior, and deployment paths.

---

## 📂 Target Scripts Directory

For mpv to recognize and execute these scripts, they **must be placed into mpv's scripts directory**:

- **Linux / macOS:** `~/.config/mpv/scripts/`
- **Windows:** `%APPDATA%\mpv\scripts\`

Any `.lua` file placed in this directory is automatically discovered and loaded by mpv on startup.

### Quick Deployment Commands

```bash
# Ensure the mpv scripts directory exists:
mkdir -p ~/.config/mpv/scripts/

# Deploy all scripts at once:
cp src/*.lua ~/.config/mpv/scripts/

# Or deploy individual scripts:
cp src/repeat-script.lua ~/.config/mpv/scripts/
cp src/playlist-script.lua ~/.config/mpv/scripts/
cp src/auto-load-playlist-script.lua ~/.config/mpv/scripts/
cp src/my-first-script.lua ~/.config/mpv/scripts/
```

---

## 1. Auto-Load Playlist Script (`src/auto-load-playlist-script.lua`)

- **Installation:**
  ```bash
  cp src/auto-load-playlist-script.lua ~/.config/mpv/scripts/
  ```

### Objective
Automatically populates the mpv playlist with sibling media files from the same directory when a single file is launched, matching on common filename prefixes (such as episode numbers, dates, or downloaded video groups).

### Mechanics & Event Flow
1. **Trigger:** Listens to the `start-file` event via `mp.register_event("start-file", ...)`.
2. **Sibling Check:** Reads `mp.get_property_native("playlist")`. If `#playlist > 1`, the script exits immediately to avoid redundant additions on track switches.
3. **Key Extraction:**
   - Evaluates the current file's basename.
   - Extracts the prefix up to the first space character (e.g. `SeriesName_S01E01 Title.mp4` -> `SeriesName_S01E01`).
   - If no space exists, uses the filename without extension.
4. **Directory Scan:**
   - Executes `find "<dir>" -maxdepth 1 -type f -printf "%f\n"` via `io.popen`.
   - Sorts detected filenames alphabetically.
5. **Playlist Insertion & Positioning:**
   - Appends matching siblings using `mp.commandv("loadfile", filepath, "append")`.
   - Tracks the original file's alphabetical position (`place_to_be_added`).
   - Uses `mp.commandv("playlist-move", 0, place_to_be_added)` to move the active playing track to its proper ordered location.
   - Displays an OSD confirmation: `"Added N similar file(s) to playlist"` for 2 seconds.

---

## 2. Playlist Display Script (`src/playlist-script.lua`)

- **Installation:**
  ```bash
  cp src/playlist-script.lua ~/.config/mpv/scripts/
  ```

### Objective
Provides an immediate on-screen display (OSD) overlay listing the contents of the active playlist, with an indicator for the track currently playing.

### Mechanics & Keybinding
- **Keybinding:** `Ctrl+p` (registered via `mp.add_key_binding("ctrl+p", "show-playlist", ...)`).
- **Behavior:**
  - Queries `mp.get_property_native("playlist")`.
  - If empty or nil, displays `"Playlist is empty"` for 2 seconds.
  - Iterates through the playlist array:
    - Prepends `▶ ` if `item.playing` is true, otherwise `  `.
    - Resolves item title from `item.title`, `item.filename`, or fallback `"Unknown"`.
    - Cleans file paths to isolate the basename.
  - Formats items into a numbered multiline list and presents it via `mp.osd_message(..., 5)`.

---

## 3. Repeat Toggle Script (`src/repeat-script.lua`)

- **Installation:**
  ```bash
  cp src/repeat-script.lua ~/.config/mpv/scripts/
  ```

### Objective
Quickly toggles the playlist looping mode without navigating the mpv menu or terminal.

### Mechanics & Keybinding
- **Keybinding:** `Ctrl+r` (registered via `mp.add_key_binding("ctrl+r", "toggle-repeat", ...)`).
- **Behavior:**
  - Executes `mp.commandv("cycle", "loop-playlist")`.
  - Toggles between `inf` (infinite loop) and `no` (standard sequential playback).

---

## 4. Test / Greeting Script (`src/my-first-script.lua`)

- **Installation:**
  ```bash
  cp src/my-first-script.lua ~/.config/mpv/scripts/
  ```

### Objective
A minimal test script verifying that mpv successfully registers and executes custom user scripts.

### Mechanics & Keybinding
- **Keybinding:** `Ctrl+h` (registered via `mp.add_key_binding("ctrl+h", "show-hello", ...)`).
- **Behavior:**
  - Triggers `mp.osd_message("Hello from my custom script!", 3)`.
