# mpv-update

Custom Lua scripts for the [mpv](https://mpv.io) media player to streamline playlist management, automatically load related files, toggle playback looping, and provide on-screen display (OSD) feedback.

---

## ⌨️ Shortcuts

| Shortcut | Script | Action |
| :--- | :--- | :--- |
| `Ctrl+p` | [`playlist-script.lua`](file:///home/sahan-weerasiri/projects/mpv-update/src/playlist-script.lua) | Display current playlist on OSD with active track indicator (`▶`) |
| `Ctrl+r` | [`repeat-script.lua`](file:///home/sahan-weerasiri/projects/mpv-update/src/repeat-script.lua) | Toggle playlist repeat/looping on/off |
| `Ctrl+h` | [`my-first-script.lua`](file:///home/sahan-weerasiri/projects/mpv-update/src/my-first-script.lua) | Show test greeting message on OSD |
| *(auto)* | [`auto-load-playlist-script.lua`](file:///home/sahan-weerasiri/projects/mpv-update/src/auto-load-playlist-script.lua) | Automatically load sibling files into playlist on launch |

---

## 🚀 Installation

To use these scripts, place them in your mpv scripts directory:

- **Linux / macOS:** `~/.config/mpv/scripts/`
- **Windows:** `%APPDATA%\mpv\scripts\`

mpv automatically loads all `.lua` files in this directory on startup.

### Linux / macOS:

```bash
# 1. Ensure the directory exists
mkdir -p ~/.config/mpv/scripts/

# 2. Copy all scripts
cp src/*.lua ~/.config/mpv/scripts/

# Or copy individual scripts:
cp src/repeat-script.lua ~/.config/mpv/scripts/
cp src/playlist-script.lua ~/.config/mpv/scripts/
cp src/auto-load-playlist-script.lua ~/.config/mpv/scripts/
cp src/my-first-script.lua ~/.config/mpv/scripts/
```

> **Tip (Development):** To keep scripts in sync with this repository without copying each time, create symlinks:
> ```bash
> ln -sf $(pwd)/src/*.lua ~/.config/mpv/scripts/
> ```

### Windows:

```cmd
mkdir %APPDATA%\mpv\scripts
copy src\*.lua %APPDATA%\mpv\scripts\
```

---

## 📦 Scripts Overview

### 1. Auto-Load Playlist (`src/auto-load-playlist-script.lua`)
Automatically scans the directory of the currently playing file and appends sibling files sharing the same prefix (e.g. multi-part episodes or series) to the playlist in alphabetical order, keeping the active track in its correct position.

### 2. Playlist OSD Overlay (`src/playlist-script.lua`)
Press **`Ctrl+p`** to show the current playlist as an on-screen display overlay for 5 seconds. The active playing track is highlighted with `▶ `.

### 3. Repeat Toggle (`src/repeat-script.lua`)
Press **`Ctrl+r`** to cycle playlist looping (`cycle loop-playlist`) between enabled (`inf`) and disabled (`no`).

### 4. Greeting & Verification (`src/my-first-script.lua`)
Press **`Ctrl+h`** to display a 3-second OSD message (`"Hello from my custom script!"`) verifying that mpv is loading scripts correctly.

---

## 📁 Repository Structure

```
.
├── src/                               # Lua scripts for mpv
│   ├── auto-load-playlist-script.lua  # Auto-loads sibling files into playlist
│   ├── playlist-script.lua            # OSD playlist overlay (Ctrl+p)
│   ├── repeat-script.lua              # Toggle playlist looping (Ctrl+r)
│   └── my-first-script.lua            # Verification & test script (Ctrl+h)
├── docs/
│   ├── SCRIPTS.md                     # Technical reference (events, properties, APIs)
│   └── adr/                           # Architecture Decision Records
│       └── 0001-modular-mpv-lua-script-architecture.md
└── README.md
```

For technical API details and event handling specifications, see [`docs/SCRIPTS.md`](file:///home/sahan-weerasiri/projects/mpv-update/docs/SCRIPTS.md).
