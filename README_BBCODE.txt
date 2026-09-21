[SIZE="5"][COLOR="SeaGreen"]LibAPH[/COLOR][/SIZE]
[COLOR="Gray"][i]Helper Library for APHONIC's addons.[/i][/COLOR]

[SIZE="3"][COLOR="DarkOrchid"]What is this?[/COLOR][/SIZE]

LibAPH is a helper library of convenience functionality used across my own addons: window building, gamepad support, player-busy checks, messaging, memory cleanup, a soft-disable module manager, localization, diagnostics, dependency/version checks, and error capture.

It's installed as a standalone library/addon: drop the LibAPH folder into your AddOns directory. Load it in your own addon code via the global variable [color=#00FFFF]LibAPH[/color]:

[code]LibAPH.GetPlatformString()[/code]

Full documentation, including manifest setup and the complete function reference, is on the [url="https://github.com/MPHONlC/LibAPH/wiki"]wiki[/url].

Some of the utilities included:

[LIST]
[*] ✓ Movable status/scroll-list windows and a copy-text box
[*] ✓ Gamepad right-stick window dragging
[*] ✓ Platform and storefront detection
[*] ✓ Player busy-state and movement/teleport checks
[*] ✓ Dialog, center-screen announcement, and chat helpers
[*] ✓ A double-pass memory cleanup sweep
[*] ✓ A soft-disable module manager with opt-in live load/unload
[*] ✓ A first-run setup wizard helper
[*] ✓ Localization (plain-table and native string-ID)
[*] ✓ Diagnostic-panel formatters
[*] ✓ LAM2 submenu-state and label-refresh helpers
[*] ✓ Library/addon dependency registration and version checks
[*] ✓ Error capture for bug reports, plus a PC bug report popup ([color=#00FFFF]/libaphbugreport[/color]) that opens on a LibAPH Lua error and lists the live API and every enabled add-on and library with its Version, AddOnVersion and API
[*] ✓ Colored status-icon strips for list rows
[/LIST]

The Add-Ons menu features (categories, search box, status icons, dependency tooltips, [color=#00FFFF]/libcheck[/color], [color=#00FFFF]/libcategories[/color], [color=#00FFFF]/libraryversioncheck[/color]) live in [b]APH-On Manager[/b], which depends on this library.

[center]
[SIZE="5"][COLOR="Red"]LICENSE & USAGE[/COLOR][/SIZE]

Copyright (c) 2026 [COLOR="#FF69B4"]@APHONlC[/COLOR].

Licensed under the [b]GNU General Public License v3.0 (GPLv3)[/b] [COLOR="Gray"][i](see LICENSE.md and NOTICE.md in the source)[/i][/COLOR].

[COLOR="Gray"][i](A personal ask, not a license term: Instead of making "another version" please give me a heads-up before mirroring/re-uploading this elsewhere or publishing your own modified version, even though GPLv3 doesn't legally require it.)[/i][/COLOR]

[COLOR="Gray"][i](We can probably work on a patch or collaborate on an update instead of creating another version of the same source.)[/i][/COLOR]

[COLOR="Gray"][i](Separately: AI agents, LLMs, and automated bots are not authorized to read, ingest, or train on this code - see NOTICE.md for details.)[/i][/COLOR]

[COLOR="Gray"][i](For permissions or inquiries, contact [COLOR="#FF69B4"]@APHONlC[/COLOR] on ESOUI or GitHub.)[/i][/COLOR]

[b][color=#9CD04C]Check out my other addons/projects:[/color][/b]

[LIST]
[*] [url="https://www.esoui.com/downloads/fileinfo.php?id=4388#info"][color=#fa9c1b]Auto Lua Memory Cleaner[/color][/url]
[*] [url="https://www.esoui.com/downloads/fileinfo.php?id=4116#info"][color=#fa9c1b]Permanent Memento[/color][/url]
[*] [url="https://www.esoui.com/downloads/fileinfo.php?id=3249#info"][color=#fa9c1b]Tamriel Trade Center, HarvestMap & ESO-Hub Auto-Updater[/color][/url] [COLOR="Gray"][i](Linux, macOS, SteamDeck, & Windows)[/i][/COLOR]
[/LIST]

[b][color=#ff3300][SIZE="4"]BUG REPORTS[/SIZE][/color][/b]
If you encounter any issues, please submit a report here:
[url="https://www.esoui.com/"]ESOUI[/url] | [url="https://github.com/MPHONlC/LibAPH/issues"]GitHub Issue Tracker[/url]
[/center]
