# enemyFrames (Turtle WoW Clean by Kirsten)

**What is this?**  
A modular, beginner-friendly WoW addon that displays enemy unit frames, nameplates, target castbars, BG flags, and incoming spells.

---

## Folder Layout  
- **Core**
  - `enemyFramesCore.lua` ‑ data tracking & game events  
  - `enemyFrames.lua` ‑ main UI spawner & layout  
- **Globals**
  - `constants.lua` ‑ all magic numbers in one place  
  - `utils.lua` ‑ common helpers (round, timer left)  
  - `uiFactory.lua` ‑ creates checkboxes/sliders  
  - `eventDispatcher.lua` ‑ centralized event bus  
  - `commHandler.lua` ‑ BG sync (raid targets, EFC)  
  - `actionHandler.lua` ‑ (future) keybinding handlers  
- **Spells**
  - `casts.lua`, `buffs.lua`, `parser.lua` ‑ parse combat log  
- **Settings**
  - `settings.lua` ‑ saved-vars defaults & frame  
  - `general.lua`, `features.lua`, `optionals.lua`, `nameplates.lua`  
- **UIElements**
  - `playerFrame.lua`, `targetframe.lua`, `nameplatesHandler.lua`,  
    `incomingSpells.lua`, `customBorder.lua`, `wsgUI.lua`  

---

## Quick Edits  
1. **Change timings & sizes**  
   Edit `globals/constants.lua`.  
2. **Enable/disable features**  
   Open the in-game settings `/efs` or modify defaults in `settings.lua`.  
3. **Add/remove modules**  
   Each feature is a self-contained file.  
4. **Spells & buffs**  
   All tracked spells live in `globals/resources/spells.lua` (can be split by class).

---

## Coding Conventions  
- **Constants** in `EF_CONST`  
- **Callbacks** subscribe via `EventDispatcher:Subscribe(event, fn)`  
- **UI factories** in `UIFactory` for consistent look & feel  
- **Poller** dispatches all OnUpdate loops

---

## Help In-Game  
Type `/efd help` for addon commands.

---

Enjoy tweaking, and feel free to ask if anything’s unclear!  