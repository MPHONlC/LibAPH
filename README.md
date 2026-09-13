<div align="center">

# LibAPH

*Helper library for APHONIC's addons.*

![Version](https://img.shields.io/badge/version-0.0.1-9CD04C?style=flat-square)
![ESO API](https://img.shields.io/badge/ESO%20API-101050%20%7C%20101051-00FFFF?style=flat-square)
![License](https://img.shields.io/badge/license-GPLv3-fa9c1b?style=flat-square)
![Platform](https://img.shields.io/badge/platform-PC%20%7C%20Xbox%20%7C%20PlayStation-FF69B4?style=flat-square)

</div>

LibAPH bundles the UI and lifecycle boilerplate that [Permanent Memento](https://www.esoui.com/downloads/info4116) and [Auto Lua Memory Cleaner](https://www.esoui.com/downloads/info4388) kept rewriting by hand: movable status windows, a scrollable list window, gamepad drag-to-move, platform detection, player-busy checks, dialog/CSA/chat helpers, a double-pass GC cleanup engine, a soft-disable module manager with real live load/unload, localization, diagnostic formatters, error capture, and self-version-change tracking.

It's built for those two addons first. If it's useful to yours, you're welcome to depend on it.

> [!NOTE]
> LibAPH is a library, not a standalone addon (see below).

## Install / depend on it

LibAPH is a library addon: players install it once (drop the `LibAPH` folder into `AddOns`), and your addon declares it in its manifest, either as a required or an optional dependency:

```
## DependsOn: LibAPH>=260911001
```
```
## OptionalDependsOn: LibAPH>=260911001
```

`260911001` is LibAPH's current `## AddOnVersion`. Call it via the bare global, `LibAPH.CreateStatusWindow(...)`.

With `DependsOn`, ESO won't load your addon at all if LibAPH is missing or too old, so `LibAPH` is guaranteed to exist by the time your Lua runs. With `OptionalDependsOn`, your addon still loads without it, so guard every call: `if LibAPH then ... end`.

## Quick reference

| Function | Does |
|---|---|
| `CreateStatusWindow(opts)` | Movable status window with a centered label |
| `CreateRowList(parent, opts)` | Auto-sizing multi-row text list inside a container |
| `CreateScrollListWindow(opts)` | Movable window with a scrollbar, checkable/header rows |
| `CreateCopyTextBox(opts)` | Movable window with a select-all copy box |
| `AddButtonHoverEffects(control, baseColor)` | Hover/press/click-sound feedback for a colored-text button |
| `SetWindowActive(window, label, isActive, opts)` | Shows/hides a status window by alpha and mouse state |
| `AddFragmentToScenes` / `RemoveFragmentFromScenes` | Attaches/detaches a scene fragment across named scenes |
| `CreateGamepadMover(target)` | Right-stick window drag for gamepad/console |
| `GetPlatformString()` | `"PC"` / `"Xbox"` / `"PlayStation 4"` / `"PlayStation 5"` |
| `GetPlatformServiceName()` | `"Steam"` / `"Epic"` / `"ZOS"` / `"DMM"` (PC only) |
| `IsPlayerCrafting()` / `IsPlayerInteracting()` / `IsPlayerInMenu()` | Individual busy-state checks |
| `CheckBusyReason(checks)` | Runs a list of busy checks, returns the first true one |
| `CreateMovementTracker(opts)` | Tracks whether the player is currently moving |
| `CreateTeleportTracker(opts)` | Tracks whether the player recently teleported |
| `ShowDialogChained(dialogId, title, body, buttons, delayMs)` | Shows an `ESO_Dialogs` dialog safely from another dialog's callback |
| `SafeCSA(enabled, title, body, lifespanMs)` | One center-screen announcement, no-ops if disabled |
| `CreateChatLogger(shortTag, colorHex)` | Tagged chat logger for console |
| `SendRawChatLine(msg)` | Raw console/PC chat print, untagged |
| `RunDoubleGCPass(opts)` | Double garbage-collection sweep with a before/after diff |
| `CallOptional(warnedTable, tag, note, fn, label, ...)` | Calls `fn` if it exists, warns once if it doesn't |
| `ToggleModuleDisabled(...)` | Flips a module's disabled flag |
| `ApplyModuleDisableOverrides(...)` | Nils out a disabled module's functions at load |
| `RegisterModuleLifecycle(modKey, hooks)` | Opts a module into live load/unload (`onLoad`/`onUnload`) |
| `HasModuleLifecycle(modKey)` | Whether a module registered a lifecycle |
| `StashFunc` / `GetStashedFunc` | Saves/retrieves a module's real function before nil-ing it |
| `SyncModuleLifecycle(modulesTable, modKey, isDisabled)` | Runs a registered lifecycle's onLoad/onUnload |
| `BuildModuleLoadButton(opts)` | Ready-made LAM2 checkbox control for a module toggle |
| `ScheduleWizardIfNeeded(isCompleted, runFn, delayMs)` | Runs the first-run wizard once, delayed |
| `AutoUnloadWizardModule(settings, toggleFn)` | Unloads the wizard module once it's done |
| `Localize(langTable, langCode, key, ...)` | Plain-table fallback string lookup |
| `LoadLocalization(addonPrefix, langTable, defaultLang, overrideLang)` | Registers strings into ESO's native `GetString()` system |
| `BuildLanguagePickerControls(opts)` | Ready-made LAM2 language dropdown and apply button |
| `FormatVersionParen(version)` / `FormatVersionBare(version)` | `" (v12)"` / `" v12"`, empty if 0 or nil |
| `GetLibraryDriftColor(installedVer, tableVer)` | Color plus label for installed-vs-known-table version drift |
| `CheckLibraryVersion(addonName)` | Returns `version, enabled` for any installed addon |
| `FormatLibraryVersion(ver, enabled, requiredVer, formatters)` | Picks the missing/disabled/exact/old/newer branch |
| `BuildLibraryWarning` / `BuildLibraryWarningFromData` | Ready-made missing/disabled/outdated warning text |
| `FormatVersionHistory(history, currentVersion, sep)` | Colors a version list, oldest red to newest green |
| `FormatSettingsSnapshot(settings, fields, onLabel, offLabel)` | Settings table to readable On/Off lines |
| `StripColors(text)` | Removes `\|cRRGGBB...\|r` markup |
| `ResetToDefaults(settings, defaults, excludeKeys, postFn)` | Restores defaults except excluded keys, reloads the UI |
| `FormatInstallDateLine(installedDate, todayStr)` | Colored `"install date > today"` line |
| `FormatModuleFileLine` / `BuildModuleFileList` | Per-module loaded/unloaded status line(s) |
| `BuildBugReportText(opts)` | Assembles stats, settings, and error sections into one report |
| `PersistSubmenuOpenState(savedTable, reference)` | Remembers a LAM2 submenu's open/closed state (PC only) |
| `CreateMenuLabelRefresher(addonPrefix, panelGetter)` | Re-labels LAM2 controls whose name is a live function |
| `RegisterAddonDependencies(addonName, requiredLibs, optionalLibs)` | Makes your optional deps visible to `/libcheck` |
| `HookErrorCapture(addonName, onCaptured)` | Captures your addon's own Lua errors for a bug-report box |
| `CheckSelfVersion(store, currentVersion, opts)` | Detects your addon's own version change since last session |

## Library organization

Split into one file per concern, all loaded automatically by the manifest:

| File | Covers |
|---|---|
| `LibAPH.lua` | Namespace + `LibAPH.VERSION` (loaded first) |
| `Window.lua` | `CreateStatusWindow`, `CreateRowList`, `CreateScrollListWindow`, `CreateCopyTextBox`, `AddButtonHoverEffects`, `SetWindowActive`, `AddFragmentToScenes`, `RemoveFragmentFromScenes` |
| `Gamepad.lua` | `CreateGamepadMover` |
| `Platform.lua` | `GetPlatformString`, `GetPlatformServiceName` |
| `PlayerState.lua` | `IsPlayerCrafting`, `IsPlayerInteracting`, `IsPlayerInMenu`, `CheckBusyReason`, `CreateMovementTracker`, `CreateTeleportTracker` |
| `Messaging.lua` | `ShowDialogChained`, `SafeCSA`, `CreateChatLogger`, `SendRawChatLine` |
| `Cleanup.lua` | `RunDoubleGCPass` |
| `ModuleManager.lua` | `CallOptional`, `ToggleModuleDisabled`, `ApplyModuleDisableOverrides`, `RegisterModuleLifecycle`, `HasModuleLifecycle`, `StashFunc`, `GetStashedFunc`, `SyncModuleLifecycle`, `BuildModuleLoadButton` |
| `Wizard.lua` | `ScheduleWizardIfNeeded`, `AutoUnloadWizardModule` |
| `Localization.lua` | `Localize`, `LoadLocalization`, `BuildLanguagePickerControls` |
| `Format.lua` | `FormatVersionParen`, `FormatVersionBare`, `GetLibraryDriftColor`, `CheckLibraryVersion`, `FormatLibraryVersion`, `BuildLibraryWarning`, `BuildLibraryWarningFromData`, `FormatVersionHistory`, `FormatSettingsSnapshot`, `StripColors`, `ResetToDefaults`, `FormatInstallDateLine`, `FormatModuleFileLine`, `BuildModuleFileList`, `BuildBugReportText` |
| `ErrorCapture.lua` | `HookErrorCapture` |
| `SelfVersion.lua` | `CheckSelfVersion` |
| `MenuState.lua` | `PersistSubmenuOpenState`, `TrackSubmenuOpenState`, `RestoreSubmenuOpenState` |
| `MenuRefresh.lua` | `CreateMenuLabelRefresher` |
| `LibraryVersionCheck.lua` | The `/libraryversioncheck` slash command |
| `LibraryManager.lua` | The `/libcheck` slash command, `RegisterAddonDependencies`, plus its own internal `ScanOptionalLibraries`/`ApplyOptionalLibraryChoice`/`RunOptionalLibraryWizard`/`ReportPendingOptionalLibraryChanges` (not meant to be called from outside this file) |
| `KnownLibraries.lua` | Reference table of popular ESO library names/versions, not runtime-required |
| `KnownAddonDependencies.lua` | Curated snapshot of other addons' real `OptionalDependsOn` entries, used by `/libcheck` for any addon that never calls `RegisterAddonDependencies` itself |
| `AutoEnableRequiredDeps.lua` | Auto-enables an addon's real required dependencies when it's manually enabled, PC and console alike |
| `AddonManagerTooltip.lua` | Adds a Required/Optional library section to the native Add-On Manager's tooltip (PC), or builds one from scratch if nothing else does; `GetOptionalLibsFor` is its own internal helper, not meant to be called from outside this file |
| `AddonManagerCheckbox.lua` | Re-shows the Add-On Manager's enable checkbox once a problem dependency is merely disabled, not missing or too old |

## Quick start

```lua
-- MyAddon.lua
MyAddon = {}
MyAddon.name = "MyAddon"

function MyAddon.OnAddOnLoaded(_, name)
    if name ~= MyAddon.name then return end
    EVENT_MANAGER:UnregisterForEvent(MyAddon.name, EVENT_ADD_ON_LOADED)

    MyAddon.window, MyAddon.label = LibAPH.CreateStatusWindow({
        name = "MyAddonWindow",
        initialText = "Ready",
        onMoveStop = function(left, top)
            MyAddon.settings.window_left = left
            MyAddon.settings.window_top = top
        end,
    })
    MyAddon.window:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT,
        MyAddon.settings.window_left or 100, MyAddon.settings.window_top or 100)
    MyAddon.window:SetHidden(false)

    MyAddon.mover = LibAPH.CreateGamepadMover(MyAddon.window)
    MyAddon.mover:RegisterCallback("", 0, function(pos)
        MyAddon.settings.window_left = pos.left
        MyAddon.settings.window_top = pos.top
    end)

    MyAddon.label:SetText("Running on " .. (LibAPH.GetPlatformString() or "unknown platform"))
end

EVENT_MANAGER:RegisterForEvent(MyAddon.name, EVENT_ADD_ON_LOADED, MyAddon.OnAddOnLoaded)
```

## Window

### `CreateStatusWindow(opts)`

Movable top-level control: flat-fill backdrop, 4-strip border, centered auto-sized label. Returns `window, label`.

`opts` (all optional): `name`, `parent` (default `GuiRoot`), `width`/`height` (default `150`/`40`), `movable` (default `true`), `bgColor` (`{r,g,b,a}`, default `{0,0,0,0.6}`), `borderColor`/`borderThickness` (default `{0.6,0.6,0.6,0.8}`/`2`), `isGamepad`/`fontPC`/`fontGamepad`, `initialText` (default `"Loading..."`), `centerAlign` (default `true`), `onMoveStop`: `function(left, top)`.

See [Quick start](#quick-start) above for a full example.

### `CreateRowList(parent, opts)`

Auto-sizing row list inside an already-built container, vertical or horizontal. Measures each row's real text via `label:GetTextDimensions()` and resizes `parent` to fit, so a row longer than expected never clips. Returns `:SetRows(texts)` (full replace, an ordered array of strings) and `:Clear()`.

`opts`: `orientation` (`"vertical"`/`"horizontal"`, default `"vertical"`), `spacing` (default `4`), `maxRows` (default `20`), `padding` (default `6`), `minWidth`/`minHeight` (default `40`/`20`), `isGamepad`/`fontPC`/`fontGamepad`, `color` (`{r,g,b,a}`, default `{1,1,1,1}`).

```lua
DBT.rowlist = LibAPH.CreateRowList(DBT.window, { orientation = "vertical", padding = 6, spacing = 2 })
-- every refresh:
DBT.rowlist:SetRows({ "Sundered  3.2s  (Daedroth)", "Chilled  5.9s  (Bandit)" })
```

### `CreateScrollListWindow(opts)`

Movable window with a scrollbar, for a list too long to auto-size to. Built entirely from ESO's own native templates (`ZO_ScrollList`, `ZO_SelectableLabel`, `ZO_DefaultBackdrop`, `ZO_CheckButton`, `ZO_CloseButton`) - no third-party library. Returns `:SetTitle(text)`, `:SetRows(rows)` (full replace, `rows` = `{ {text=, color={r,g,b,a}}, ... }`), `:SetAllChecked(bool)`, `:Show()`, `:Hide()`, plus the raw `window`, `list`, `footer` controls for anchoring your own buttons into the footer.

`opts`: `name`, `titleText`, `footerHeight` (default `44`), `rowHeight` (default `26`), `isGamepad`/`fontPC`/`fontGamepad`, `onClose`. Sized responsively by default: `widthPct`/`heightPct` (default `0.34`/`0.55` of screen resolution) clamped to `minWidth`/`maxWidth`/`minHeight`/`maxHeight` (default `480`/`900`/`420`/`820`) - pass explicit `width`/`height` to opt out.

A row's `data` table also takes:
- `tooltip` (string) - hovering shows it via `ItemTooltip`, so a row's own text can stay short instead of cramming in detail.
- `is_header` (bool) - a permanent dim-blue background band instead of the hover highlight, for section headers.
- `checkable` (`{checked=bool, onToggle=function(isChecked) end}`) - renders a real `ZO_CheckButton`; clicking the checkbox or anywhere else on the row toggles it and mutates the same row-data table in place, so read `rows[i].checked` afterward rather than re-fetching.

`:Show()`/`:Hide()` also call `SCENE_MANAGER:SetInUIMode(...)` for you, unlocking/relocking the mouse cursor automatically.

```lua
optional_library_window = LibAPH.CreateScrollListWindow({
    name = "LibAPH_OptionalLibraryWindow",
    widthPct = 0.36, heightPct = 0.6,
    minWidth = 520, maxWidth = 950,
    minHeight = 460, maxHeight = 860,
    footerHeight = 58,
    titleText = "|c9CD04CLibAPH|r Library Manager",
})
optional_library_window:SetTitle("Optional Libraries")
optional_library_window:SetRows({
    { text = "LibAddonMenu-2.0 (v41)", color = { 0.4, 1, 0.4, 1 }, checkable = { checked = true, onToggle = function(checked) d(checked) end } },
})
optional_library_window:Show()
```

### `CreateCopyTextBox(opts)`

Movable window with a select-all, focused multi-line edit box - for a "copy last error" style button. `opts`: `name`, `titleText`, `closeText` (default `"Close"`), `maxInputChars` (default `4000`), `stripColors` (default `LibAPH.StripColors`). Returns `box:Show(plain_text)`.

```lua
local error_box = LibAPH.CreateCopyTextBox({ name = "MyAddonErrorBox", titleText = "Last Error" })
error_box:Show(MyAddon.last_own_error or "No error captured yet.")
```

### `AddButtonHoverEffects(control, baseColor)`

Hover (brightens)/press (darkens)/click-sound feedback for a plain clickable text label. Wires `OnMouseEnter`/`OnMouseExit`/`OnMouseDown`. Assign `control.libaph_click_action = function() ... end` for the click action instead of wiring `OnMouseUp` yourself.

```lua
local btn = WINDOW_MANAGER:CreateControl(nil, parent, CT_LABEL)
btn:SetText("Apply Changes")
btn:SetColor(0.4, 1, 0.4, 1)
btn:SetMouseEnabled(true)
LibAPH.AddButtonHoverEffects(btn, { 0.4, 1, 0.4, 1 })
btn.libaph_click_action = function() d("Applied.") end
```

### `SetWindowActive(window, label, isActive, opts)`

Shows or hides a status window by fading `SetAlpha` and toggling `SetMouseEnabled`, rather than `SetHidden` - keeps the window's own move/anchor state intact while it's inactive. Returns `true`/`false` for the new active state. `opts.emptyText` sets the label when inactive; `opts.onResize` runs after going inactive.

```lua
local is_active = LibAPH.SetWindowActive(MyAddon.window, MyAddon.label, has_target, { emptyText = "" })
```

### `AddFragmentToScenes(fragment, sceneNames)` / `RemoveFragmentFromScenes(fragment, sceneNames)`

Attaches or detaches a `ZO_HUDFadeSceneFragment` (or any scene fragment) across a list of named scenes in one call.

```lua
LibAPH.AddFragmentToScenes(MyAddon.fragment, { "hud", "hudui" })
```

## Gamepad

### `CreateGamepadMover(target)`

Polls the right analog stick, claims it via `SetGamepadRightStickConsumedByUI` so it doesn't also spin the camera, and moves `target` by tilt times elapsed time. Auto-stops after 3 seconds of no stick input. Returns a mover object:

```lua
local mover = LibAPH.CreateGamepadMover(target)
mover:ToggleGamepadMove(true)   -- start dragging
mover:ToggleGamepadMove(false)  -- stop early
mover:RegisterCallback("", 0, function(pos) ... end)  -- pos = {left=, top=}, fires on stop (including auto-timeout)
```

Build one mover per target control and hold onto it - don't call `CreateGamepadMover` again for the same window.

## Platform

### `GetPlatformString()`

Returns `"PC"` / `"Xbox"` / `"PlayStation 4"` / `"PlayStation 5"` / `nil`.

### `GetPlatformServiceName()`

PC only; returns `"Steam"` / `"Epic"` / `"ZOS"` / `"DMM"` (`nil` on console).

```lua
MyAddon.label:SetText("Running on " .. (LibAPH.GetPlatformString() or "unknown platform"))
```

## Player state

### `IsPlayerCrafting()` / `IsPlayerInteracting()` / `IsPlayerInMenu()`

Individual busy-state checks: crafting interaction active, interacting with an object/NPC, or the HUD/HUD-UI scene isn't showing (i.e. a menu is open).

### `CheckBusyReason(checks)`

Runs a list of `{ enabled, check, reasonKey, delayMs }` entries in order and returns the first one whose `enabled` isn't false and whose `check()` returns true: `isBusy, reasonKey, delayMs`. Lets an addon combine its own checks (combat, dead, resurrecting) with LibAPH's shared ones in one call.

```lua
function PM.is_busy()
    return LibAPH.CheckBusyReason({
        { enabled = PM.settings.busy_check_crafting, check = LibAPH.IsPlayerCrafting,
          reasonKey = PM.L("LABEL_CRAFTING"), delayMs = (PM.settings.delay_crafting or 2) * 1000 },
        { enabled = PM.settings.busy_check_interacting, check = LibAPH.IsPlayerInteracting,
          reasonKey = PM.L("LABEL_INTERACTING"), delayMs = (PM.settings.delay_in_menu or 5) * 1000 },
        { enabled = PM.settings.busy_check_menu, check = LibAPH.IsPlayerInMenu,
          reasonKey = PM.L("LABEL_MENU"), delayMs = (PM.settings.delay_in_menu or 5) * 1000 },
    })
end
```

### `CreateMovementTracker(opts)`

Returns a tracker with `:Update()` (call every frame/tick) and `:IsMoving()`. Compares the player's world position against the last sample, throttled by `opts.throttleMs` (default `100`), moved-threshold `opts.threshold` (default `0.5`).

```lua
PM.movement_tracker = LibAPH.CreateMovementTracker()
-- on your update tick:
PM.movement_tracker:Update()
local is_moving = PM.movement_tracker:IsMoving()
```

### `CreateTeleportTracker(opts)`

Returns a tracker with `:IsTeleporting()` - true for `opts.staleMs` (default `3000`) after any wayshrine travel, keep recall/travel, housing jump, friend jump, or accepted LFG ready-check. Hooks the relevant game functions once, globally, the first time any tracker is created.

```lua
PM.teleport_tracker = LibAPH.CreateTeleportTracker()
if PM.teleport_tracker:IsTeleporting() then return end
```

## Messaging

### `ShowDialogChained(dialogId, title, body, buttons, delayMs)`

Registers `ESO_Dialogs[dialogId]` on first use and shows it, routed through `zo_callLater` (default `50`ms). Use this whenever you're opening a dialog from inside another dialog's own button callback: calling `ZO_Dialogs_ShowDialog` synchronously there races the first dialog's still-in-flight cleanup and crashes with `"attempt to index a nil value"` in `ZO_Dialog.lua`. Picks the gamepad or keyboard variant automatically.

```lua
local function wizard_show_dialog(dialog_id, title, body, buttons)
    LibAPH.ShowDialogChained(dialog_id, title, body, buttons)
end
```

### `SafeCSA(enabled, title, body, lifespanMs)`

One center-screen banner, title plus body together, or title-only via `SafeCSA(enabled, body, nil, lifespanMs)`. No-ops if `enabled` is false or nil, or `CENTER_SCREEN_ANNOUNCE` doesn't exist.

```lua
function ALC.safe_csa(title, body, lifespan_ms)
    LibAPH.SafeCSA(ALC.settings.is_csa_enabled, title, body, lifespan_ms or 4000)
end
```

### `CreateChatLogger(shortTag, colorHex)`

Returns a logger with `:Print(message, colorOverride)`. Routes through `SendRawChatLine` below, so it works on console automatically.

```lua
ALC.chat = LibAPH.CreateChatLogger("ALC", "00FFFF")
ALC.chat_error = LibAPH.CreateChatLogger("ALC Error", "FF0000")
ALC.chat:Print("Cleanup complete.")
```

### `SendRawChatLine(msg)`

Raw `CHAT_SYSTEM:AddMessage()` doesn't reliably show up on console, so this prints via `d(...)` on console and `CHAT_SYSTEM:AddMessage(...)` everywhere else, same text either way, untagged. `CreateChatLogger` calls this internally; use it directly for a multi-line listing that intentionally mixes tagged and untagged lines, since `:Print()` always prepends its own tag.

## Cleanup

### `RunDoubleGCPass(opts)`

Double garbage-collection sweep with a before/after diff, on a settle-before/settle-after timer so the numbers reflect a stable state rather than a mid-frame snapshot. `opts.onDone(before_lua, after_lua, freed_lua, before_pool, after_pool, freed_pool)` is required; `opts.getPoolMB` supplies the console memory-pool reading (optional, defaults to `0`); `opts.settleBeforeMs`/`opts.settleAfterMs` default to `500`/`200`; `opts.extraPass` runs a third `collectgarbage("collect")`.

```lua
function ALC.run_manual_cleanup(force_feedback)
    ALC.mem_state = 1
    LibAPH.RunDoubleGCPass({
        getPoolMB = ALC.get_console_pool_mb,
        onDone = function(before_lua, after_lua, freed, before_pool, after_pool, freed_pool)
            ALC.mem_state = 0
            if freed > 0.001 or freed_pool > 0.001 then
                ALC.session_mb_freed = ALC.session_mb_freed + freed
            end
        end,
    })
end
```

## Module manager

A framework for addons shipping optional feature files a player can unload to save cpu usage.

```lua
-- once, in init():
LibAPH.ApplyModuleDisableOverrides(store, moduleFileFuncs, modulesTable, nilOutFn, getFn)

-- when the player toggles a module:
local now_disabled = LibAPH.ToggleModuleDisabled(store, moduleFileFuncs, modKey, notifyFn, silent)
LibAPH.SyncModuleLifecycle(modulesTable, modKey, now_disabled)  -- true if it went live, false = tell the player to /reloadui

-- anywhere you'd call an optional module's function directly:
LibAPH.CallOptional(warnedTable, "[MyAddon]", "is unloaded, skipping.", MyAddon.SomeOptionalFn, "Some feature (SomeOptionalFn)", arg1, arg2)
```

`store` is passed fresh every call, never cached - if your addon swaps settings tables at runtime (a profile switch), a cached reference goes stale. `moduleFileFuncs` is `{ modKey = {"FuncName1", ...} }`. `modulesTable` is your own `MyAddon._modules` table.

**Live load/unload** is opt-in, for a module that owns real running state (an `EVENT_MANAGER` registration, a poller):

```lua
LibAPH.RegisterModuleLifecycle("sync", {
    onLoad = function() MyAddon.sync_engine.initialize() end,
    onUnload = function() EVENT_MANAGER:UnregisterForEvent("MyAddon_Sync", EVENT_CHAT_MESSAGE_CHANNEL) end,
})
```

A module with no registered lifecycle falls through `SyncModuleLifecycle` untouched - toggling still works, it just needs `/reloadui`. Only register a lifecycle you've verified is actually safe to tear down and rebuild live.

`HasModuleLifecycle(modKey)` checks whether one's registered. `StashFunc(modKey, fname, fn)` / `GetStashedFunc(modKey, fname)` save and retrieve a module's real function before `ApplyModuleDisableOverrides` nils it out, so a lifecycle's `onLoad` can restore it.

### `BuildModuleLoadButton(opts)`

Returns a ready-made LAM2 checkbox control definition for a module toggle: `opts.displayName`, `opts.moduleLabel`, `opts.modKey`, `opts.settings`, `opts.toggleFn`, `opts.isMissing` (optional, disables the checkbox and appends `opts.missingText` to the label when true).

```lua
build_data[#build_data + 1] = LibAPH.BuildModuleLoadButton({
    displayName = "Sync",
    moduleLabel = "Module",
    modKey = "sync",
    settings = PM.settings,
    toggleFn = PM.toggle_module_disabled,
})
```

## Wizard

### `ScheduleWizardIfNeeded(isCompleted, runFn, delayMs)`

Runs `runFn` after `delayMs` (default `3000`) if `isCompleted` is false or nil.

### `AutoUnloadWizardModule(settings, toggleFn)`

Unloads the wizard module (via `toggleFn("wizard", true)`) once it's finished, unless the player already unloaded it manually.

```lua
local function wizard_finish()
    ALC.settings.wizard_completed = true
    LibAPH.AutoUnloadWizardModule(ALC.settings, ALC.toggle_module_disabled)
end

-- and separately, wherever your addon initializes:
LibAPH.ScheduleWizardIfNeeded(ALC.settings.wizard_completed, ALC.run_wizard)
```

## Localization

### `Localize(langTable, langCode, key, ...)`

Override language to client language to English to raw key, in that order, over your own `{code -> {key -> string}}` table.

```lua
local text = LibAPH.Localize(MyAddon.Lang, GetCVar("Language.2"), "WELCOME_MSG")
```

### `LoadLocalization(addonPrefix, langTable, defaultLang, overrideLang)`

Registers that same table into ESO's native `GetString()`/`SafeAddString()` string-ID system instead. `addonPrefix` (e.g. `"SI_PM_"`) is mandatory: `ZO_CreateStringId` names a *global* shared by every addon in the session, so an unprefixed key risks one addon's string silently overwriting another's. Prefers the separately-installed `LibLanguage` if present (`OptionalDependsOn`, not required), falls back to registering directly otherwise. `overrideLang` is a third pass for a player-chosen language independent of the client's own - wins over both default and client-detected text.

```lua
function MyAddon.L(key, ...)
    local id = _G["SI_MYADDON_" .. key]
    local str = id and GetString(id) or key
    if select("#", ...) > 0 then return string.format(str, ...) end
    return str
end
-- in init():
LibAPH.LoadLocalization("SI_MYADDON_", MyAddon.Lang, "en")
```

### `BuildLanguagePickerControls(opts)`

Returns a ready-made LAM2 control list: a "current language" description, plus a dropdown and (gamepad only) an Apply button to override the client-detected language. `opts`: `L` (your localize function), `settings`, `addonPrefix`, `langTable`, `getAvailableLanguages`, `getLanguageDisplayName`, `formatCurrentLanguageText`, `isPad`, `reference`, `getPending`/`setPending` (gamepad's pending-choice state).

```lua
local controls = LibAPH.BuildLanguagePickerControls({
    L = MyAddon.L,
    settings = MyAddon.settings,
    addonPrefix = "SI_MYADDON_",
    langTable = MyAddon.Lang,
    getAvailableLanguages = MyAddon.get_available_languages,
    getLanguageDisplayName = MyAddon.get_language_display_name,
    formatCurrentLanguageText = MyAddon.format_current_language_text,
    isPad = IsInGamepadPreferredMode(),
})
for _, c in ipairs(controls) do build_data[#build_data + 1] = c end
```

## Format

### `FormatVersionParen(version)` / `FormatVersionBare(version)`

`" (v12)"` / `" v12"` - both return `""` for a nil or zero version. `GetAddOnVersion()` returns `0` for any addon whose manifest carries no real `## AddOnVersion` field at all.

### `GetLibraryDriftColor(installedVer, tableVer)`

Returns `color, plus, label` for comparing an installed library's version against a recorded/known version: green with no suffix if equal, cyan with `"+"` and `" (Newer Version)"` if installed is higher, red with `" (Old Version)"` if lower, white if `tableVer` is nil.

```lua
local color, plus, label = LibAPH.GetLibraryDriftColor(ver, libData.requiredVersion)
d(string.format("  %s: %sv%d%s%s|r", libData.fullName, color, ver, plus, label))
```

### `CheckLibraryVersion(addonName)`

Returns `version, enabled` for any installed addon or library by exact manifest name.

```lua
local lam_v, lam_e = LibAPH.CheckLibraryVersion("LibAddonMenu-2.0")
```

### `FormatLibraryVersion(ver, enabled, requiredVer, formatters)`

Picks which of `formatters.missing()` / `.disabled(ver)` / `.exact(ver)` / `.old(ver, requiredVer)` / `.newer(ver, requiredVer)` to call and returns its result.

```lua
local function format_lib(ver, en, name, req)
    return LibAPH.FormatLibraryVersion(ver, en, req, {
        missing = function() return "|cFF0000" .. ALC.L("NOT_FOUND") .. "|r" end,
        disabled = function(v) return string.format("|cFF0000%s (v%d) %s|r", name, v, ALC.L("STATE_DISABLED")) end,
        exact = function(v) return string.format("|c00FF00%s (v%d)|r", name, v) end,
        old = function(v, r) return string.format("%s |cFF0000%s|r |c00FFFF%s|r", name, ALC.L("STATE_OLD", v), ALC.L("STATE_EXPECTED", r)) end,
        newer = function(v, r) return string.format("|c00FFFF%s %s %s|r", name, ALC.L("STATE_NEWER", v), ALC.L("STATE_EXPECTED", r)) end,
    })
end
```

### `BuildLibraryWarning(templates, fullName, shortName, ver, enabled, requiredVer, consequence)` / `BuildLibraryWarningFromData(templates, libData, ver, enabled, consequence)`

Ready-made missing/disabled/outdated warning text for an optional library dependency: your own `%s`-format templates, colored version numbers (red for old, green for the required/target version) filled in for you. Returns `nil` when nothing's wrong (exact match or newer). `BuildLibraryWarningFromData` is the same thing reading `fullName`/`shortName`/`requiredVersion` off a `libData` table instead of separate arguments.

```lua
local lam_alert = LibAPH.BuildLibraryWarning(libwarn_templates, "LibAddonMenu", "LAM", lam_ver, lam_en, ALC.REQUIRED_LAM_VERSION, "the settings menu won't open")
```

### `FormatVersionHistory(history, currentVersion, sep)`

Colors a list of version strings: oldest red, newest green, everything between plain, joined with `sep` (default `", "`). `history` defaults to `{currentVersion}`.

```lua
local v_hist_str = LibAPH.FormatVersionHistory(ALC.settings.version_history, ALC.version)
```

### `FormatSettingsSnapshot(settings, fields, onLabel, offLabel)`

Turns a flat settings table plus a curated field list into readable On/Off lines, for a bug-report box. `fields` is `{{key=, label=}, ...}`; anything missing or non-boolean is skipped.

```lua
local settings_lines = LibAPH.FormatSettingsSnapshot(ALC.settings, ALC.get_bug_report_settings_fields(), "On", "Off")
```

### `StripColors(text)`

Strips `|cRRGGBB...|r` color markup, for text headed to a plain-text destination like a copy box, not an in-game label.

### `ResetToDefaults(settings, defaults, excludeKeys, postFn)`

Copies every key from `defaults` into `settings` (deep-copying tables via `ZO_ShallowTableCopy`) except keys listed in `excludeKeys`, runs `postFn` if given, then reloads the UI.

```lua
function ALC.reset_to_defaults()
    LibAPH.ResetToDefaults(ALC.settings, ALC.defaults, {
        wizard_completed = true, has_shown_lib_warning_008 = true,
    })
end
```

### `FormatInstallDateLine(installedDate, todayStr)`

Colored `"install date > today"` line for a diagnostic panel.

### `FormatModuleFileLine(filename, state, labels)` / `BuildModuleFileList(moduleOrder, moduleFiles, getState, labels, sep)`

One colored loaded/missing/unloaded line per module file, or the whole ordered list joined with `sep` (default `"\n  "`).

```lua
local file_lines_str = LibAPH.BuildModuleFileList(
    { "migration", "wizard", "menu", "ui" },
    { migration = "MODULE/ALC_Migration.lua", wizard = "MODULE/ALC_Wizard.lua", menu = "MODULE/ALC_Menu.lua", ui = "MODULE/ALC_UI.lua" },
    function(mod_key) return (ALC._modules[mod_key] == false) and "unloaded" or "loaded" end,
    { loaded = "Loaded", unloaded = "Unloaded by user" }
)
```

### `BuildBugReportText(opts)`

Joins a stats section, a settings section, and an error section into one report body. `opts`: `statsText`, `fieldSettingsLabel`, `settingsLines`, `errorSection`.

```lua
local text = LibAPH.BuildBugReportText({
    statsText = ALC.build_client_info_text(),
    settingsLines = settings_lines,
    fieldSettingsLabel = ALC.L("FIELD_SETTINGS"),
    errorSection = error_section,
})
```

## Menu state

### `PersistSubmenuOpenState(savedTable, reference)`

Remembers whether a LAM2 settings-menu submenu was left open or closed across a reload (PC only). Restores on the call, then tracks future toggles. `TrackSubmenuOpenState`/`RestoreSubmenuOpenState` are the two halves, if you want them separately.

```lua
LibAPH.PersistSubmenuOpenState(ALC.settings.submenu_state, "ALC_Submenu_UIConfig")
```

## Menu refresh

### `CreateMenuLabelRefresher(addonPrefix, panelGetter)`

LAM2 controls whose `name` is a function only re-evaluate that function when LAM2 itself redraws the panel - not when your own code changes the underlying value (e.g. a live language switch). Returns `{ CollectFrom, Refresh }`: `CollectFrom(build_data)` scans your control list once at menu-build time for any checkbox/slider/button/dropdown with a function `name` (recursing into submenus) and assigns each one a `reference`; `Refresh(control)` re-reads and re-applies each one's current label text on demand.

```lua
local menu_refresher = LibAPH.CreateMenuLabelRefresher("ALC_MRC_", function() return ALC.lam_panel end)
menu_refresher.CollectFrom(build_data)
ALC.refresh_control_labels = menu_refresher.Refresh
-- call ALC.refresh_control_labels(control) whenever a live value backing a label changes
```

## Dependency management

### `RegisterAddonDependencies(addonName, requiredLibs, optionalLibs)`

The only way `/libcheck` can see your addon's *optional* dependencies at all. ESO's own `GetAddOnDependencyInfo`/`GetAddOnNumDependencies` never report `OptionalDependsOn` entries, only the real `(PC/Console)DependsOn` chain, so without this call an optional library you use is invisible to `/libcheck`'s scan.

```lua
LibAPH.RegisterAddonDependencies("MyAddonFolderName", { "SomeRequiredLib" }, { "SomeOptionalLib", "AnotherOptionalLib" })
```

`addonName` must match your manifest's real internal folder name (what `GetAddOnInfo` reports, not your display `## Title:`). No version numbers needed - `/libcheck` reads those live via `GetAddOnDependencyInfo`/`GetAddOnVersion` for whichever it can see. Call it once, from your own `EVENT_ADD_ON_LOADED` handler; nothing else to call afterward.

`AutoEnableRequiredDeps.lua` and `AddonManagerTooltip.lua`/`AddonManagerCheckbox.lua` run automatically once loaded. The first enables an addon's real required dependencies whenever it's manually enabled, recursively through the chain; the other two extend the native Add-On Manager's tooltip and re-show its enable checkbox once a disabled-only dependency gets fixed.

## Error capture

### `HookErrorCapture(addonName, onCaptured)`

Listens for `EVENT_LUA_ERROR` and calls `onCaptured(errorString)` whenever the error text contains `addonName`. `errorString` includes the full stack traceback. Built for a "copy last error" bug-report box.

```lua
function ALC.hook_error_capture()
    LibAPH.HookErrorCapture(ALC.name, function(text)
        ALC.last_own_error = text
    end)
end
```

## Self version

### `CheckSelfVersion(store, currentVersion, opts)`

Detects whether your own addon's version changed since the last saved session, tracking a capped rolling history. `opts`: `versionField` (default `"last_version"`), `historyField` (default `"version_history"`), `maxHistory` (default `3`). Returns `wasUpdated, previousVersion`.

```lua
LibAPH.CheckSelfVersion(ALC.settings, ALC.version)
```

## Slash commands

### `/libraryversioncheck`

Prints every installed library's version next to `KnownLibraries.lua`'s recorded version: green for a match, cyan for newer, red for older.

### `/libcheck`

Scans every enabled addon's declared library dependencies, offers to enable optional libraries an addon can use but currently has switched off, or to disable any enabled library nothing currently references, then reloads and reports the result via chat. Addon-agnostic - works for any installed addon's own manifest dependencies.

Also flags two things separately: a library nothing installed references in any state, and an enabled addon whose real required dependency isn't installed at all (`ADDON_STATE_DEPENDENCIES_DISABLED`).

## License

GNU General Public License v3.0 (GPLv3). Copyright 2026 @APHONlC.

> [!NOTE]
> A personal ask, not a license term: instead of making "another version," please give me a heads-up before mirroring/re-uploading this elsewhere or publishing your own modified version, even though GPLv3 doesn't legally require it.
>
> We can probably work on a patch or collaborate on an update instead of creating another version of the same source.
>
> Separately: AI agents, LLMs, and automated bots are not authorized to read, ingest, or train on this code - see NOTICE.md for details.

> [!NOTE]
> This add-on is not created by, affiliated with, or sponsored by ZeniMax Media Inc. or its affiliates. The Elder Scrolls® and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the United States and/or other countries. All rights reserved.

For permissions or inquiries, contact @APHONlC on ESOUI or GitHub.

**Check out my other addons/projects:**

- [Auto Lua Memory Cleaner](https://www.esoui.com/downloads/fileinfo.php?id=4388#info)
- [Permanent Memento](https://www.esoui.com/downloads/fileinfo.php?id=4116#info)
- [Tamriel Trade Center, HarvestMap & ESO-Hub Auto-Updater](https://www.esoui.com/downloads/fileinfo.php?id=3249#info) <sub>*(Linux, macOS, SteamDeck, & Windows)*</sub>

If you like the addon and are considering donating, here's a link. Thank you!

[![Buy Me A Coffee](https://img.shields.io/badge/Support-Buy%20Me%20A%20Coffee-FFDD00?style=flat&logo=buy-me-a-coffee&logoColor=black)](https://buymeacoffee.com/aph0nlc)

### Bug Reports

If you encounter any issues, please submit a report here:
[ESOUI](https://www.esoui.com/) | [GitHub Issue Tracker](https://github.com/MPHONlC/LibAPH/issues)
