# LibAPH

*Helper library for my addons.*

Everyday helper code my add-ons share, kept in one place so none of them has to carry its own copy. Any functions are subject to change.

## Features

- Window & Theme: resizable status/scroll-list windows with a shared flat theme
- Console Support: right-stick window drag/resize, console text-entry and picker dialogs
- Context Menu & Search Bar: multi-level context menu, movable expanding search bar, key-hint icons
- Module Manager: soft-disables individual add-on files and rebuilds the Client Info file list
- Wizard Helper: schedules a first-run setup wizard, auto-unloads once completed
- Messaging & Dialogs: chained/window-hiding dialogs, safe CSAs, a chat logger
- Player State: crafting/interacting/menu busy checks, movement and teleport trackers
- SavedVariables: disk-usage reporting, throttled priority saves, unused-SV cleanup
- Library & Version Checks: checks an optional library's version and builds a shared warning message
- Bug Reporting: a shared /xxxbugreport popup format used by every add-on
- Activity Triggers: a shared table of "is the player doing X" checks
- Scheduler: spreads work across frames within a time budget, staged add-on init
- Memory Cleanup: the Auto Lua Memory Cleaner cleanup methods for any add-on, shown in Auto Lua Memory Cleaner when it is installed

## Installation

Extract LibAPH into your AddOns directory, then declare it as a dependency in your add-on manifest:

## DependsOn: LibAPH>=<version>

It loads as a global table; no require or manual initialization needed:

```
LibAPH.GetPlatformString()
```

## Usage

LibAPH's functions hang off the single global LibAPH table, organized internally by folder (UI/, UTILS/, MODULES/, MENU/, HELPERS/, DATA/). Call whatever you need directly:

```
local status = LibAPH.CreateStatusWindow({ name = "MyAddonUI", title = "My Addon" })
LibAPH.RegisterAddonDependencies("MyAddon", { "LibAPH" }, { "LibAddonMenu-2.0" })
LibAPH.Schedule("MyAddon_Cleanup", function() --[[ heavy work, one chunk per frame ]] end)
```

## API Reference

The full API reference, with an example for every part, is on the ESOUI page: https://www.esoui.com/downloads/info4917-LibAPH.html

## License

Copyright © 2026 @APHONlC. All rights reserved. See LICENSE.md

This add-on is not created by, affiliated with, or sponsored by ZeniMax Media Inc. or its affiliates. The Elder Scrolls® and related logos are registered trademarks or trademarks of ZeniMax Media Inc. in the United States and/or other countries. All rights reserved.

For permissions or inquiries, contact @APHONlC on ESOUI.

## Credits

I would like to thank the following, for providing resources and their awesome projects:

- ESOUI Wiki
- ESO Forums
- @sirinsidiator
- @Flat-Badger-1971
- @sirinsidiator & @Seerah (LibAddonMenu-2.0)
- @Harven & @votan (LibHarvensAddonSettings)
- @SinusPi, @merlight, @Rhyono, @Dolgubon (Zgoo High Isle)
- @Baertram (Mer Torchbug - Fixed and Improved "Variable inspector/Scripts/Events/and more")
- @Baertram, @IceHeart, @Masteroshi430 (Circonians TextureIt)

Testers & Suggestions:
- @phlupp89
- @Drakius192

Check out my other addons/projects:
- Auto Lua Memory Cleaner
- Permanent Memento
- Tamriel Trade Center, HarvestMap, ESO-Hub, ESOUI Auto-Updater (Linux, macOS, SteamDeck, & Windows)

## Bug Reports

If you encounter any issues, please submit a report on ESOUI
