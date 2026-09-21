-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

LibAPH = LibAPH or {}
local LibAPH = LibAPH
LibAPH.VERSION = "0.0.1"

EVENT_MANAGER:RegisterForEvent("LibAPH_Init", EVENT_ADD_ON_LOADED, function(eventCode, addonName)
	if addonName ~= "LibAPH" then return end
	EVENT_MANAGER:UnregisterForEvent("LibAPH_Init", EVENT_ADD_ON_LOADED)
	LibAPH.saved = ZO_SavedVars:NewAccountWide("LibAPH_SV", 1, GetWorldName() or "Default", {})
	LibAPH.bug_reporter = LibAPH.CreateAddonBugReporter({
		addonName = "LibAPH",
		title = "LibAPH",
		version = LibAPH.VERSION,
		boxName = "LibAPHBugReportBox",
		getStore = function() return LibAPH.saved end,
	})
	if not IsConsoleUI() then
		SLASH_COMMANDS["/libaphbugreport"] = LibAPH.bug_reporter.Show
	end
end)
