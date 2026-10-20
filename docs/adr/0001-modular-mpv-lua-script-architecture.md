# 1. Modular MPV Lua Script Architecture

Date: 2026-10-20

## Status

Accepted

## Context

We require customized playback capabilities in mpv:
1. Dynamic sibling file discovery and playlist population for multi-part video series.
2. Fast OSD visualization of the active playlist.
3. Convenient keybinding for cycling playlist repeat/looping.
4. Extensibility for future playback automations without monolithic script bloat.

## Decision

We chose to implement individual, single-responsibility Lua scripts targeting mpv's native Lua API:
* **Decoupled Scripts:** Rather than bundling all behaviors into one monolithic script, each feature resides in an isolated `.lua` file (`auto-load-playlist-script.lua`, `playlist-script.lua`, `repeat-script.lua`).
* **Event-Driven Auto-Loading:** Use mpv's `start-file` event to conditionally scan directory contents and append sibling files matching prefix keys, updating track position via `playlist-move`.
* **Standard Keybindings:** Map keyboard shortcuts (`Ctrl+p`, `Ctrl+r`, `Ctrl+h`) cleanly through `mp.add_key_binding`.

## Consequences

* **Positive:** Users can enable, disable, or modify individual scripts independently without breaking other functionality. Lightweight footprint with zero external runtime dependencies beyond mpv itself.
* **Negative:** File discovery via `io.popen('find ...')` currently assumes POSIX/Linux filesystem conventions; cross-platform environments (Windows) require LuaFileSystem (LFS) or alternate path handling if ported.
