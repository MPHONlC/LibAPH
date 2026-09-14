<div align="center">

# LibAPH

*Helper library for APHONIC's addons.*

![Version](https://img.shields.io/badge/version-0.0.1-9CD04C?style=flat-square)
![ESO API](https://img.shields.io/badge/ESO%20API-101050%20%7C%20101051-00FFFF?style=flat-square)
![License](https://img.shields.io/badge/license-GPLv3-fa9c1b?style=flat-square)
![Platform](https://img.shields.io/badge/platform-PC%20%7C%20Xbox%20%7C%20PlayStation-FF69B4?style=flat-square)

</div>

## What is this?

LibAPH is a helper library of convenience functionality used across my own addons: window building, gamepad support, player-busy checks, messaging, memory cleanup, a soft-disable module manager, localization, diagnostics, dependency/version checks, and error capture.

It's installed as a standalone library/addon: drop the `LibAPH` folder into your `AddOns` directory. Load it in your own addon code via the global variable `LibAPH`:

```lua
LibAPH.GetPlatformString()
```

Full documentation, including manifest setup and the complete function reference, is on the [wiki](https://github.com/MPHONlC/LibAPH/wiki).

Some of the utilities included:

- ✓ Movable status/scroll-list windows and a copy-text box
- ✓ Gamepad right-stick window dragging
- ✓ Platform and storefront detection
- ✓ Player busy-state and movement/teleport checks
- ✓ Dialog, center-screen announcement, and chat helpers
- ✓ A double-pass memory cleanup sweep
- ✓ A soft-disable module manager with opt-in live load/unload
- ✓ A first-run setup wizard helper
- ✓ Localization (plain-table and native string-ID)
- ✓ Diagnostic-panel formatters
- ✓ LAM2 submenu-state and label-refresh helpers
- ✓ Library/addon dependency and version checks
- ✓ Error capture for bug reports

## Slash Commands

- `/libraryversioncheck`: prints every installed library's version next to the library's own recorded version: green for a match, cyan for newer, red for older.
- `/libcheck`: scans every enabled addon's declared library dependencies, offers to enable optional libraries an addon can use but currently has switched off, or to disable any enabled library nothing currently references, then reloads and reports the result via chat.

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
