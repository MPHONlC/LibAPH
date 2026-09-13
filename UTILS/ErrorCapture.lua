-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")

function LibAPH.HookErrorCapture(addonName, onCaptured)
	EVENT_MANAGER:RegisterForEvent(addonName .. "_LibAPH_ErrorCapture", EVENT_LUA_ERROR, function(_, errorString, errorCode)
		if type(errorString) ~= "string" then return end
		if errorCode == 0x32BBA739 then return end
		if string.find(errorString, addonName, 1, true) then
			onCaptured(errorString)
		end
	end)
end
