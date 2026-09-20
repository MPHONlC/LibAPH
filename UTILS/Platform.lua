-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")

function LibAPH.GetPlatformString()
	local platform = GetUIPlatform()
	if platform == UI_PLATFORM_PC then return "PC"
	elseif platform == UI_PLATFORM_XBOX then return "Xbox"
	elseif platform == UI_PLATFORM_PS4 then return "PlayStation 4"
	elseif platform == UI_PLATFORM_PS5 then return "PlayStation 5"
	end
	return nil
end

function LibAPH.GetPlatformServiceName()
	if GetUIPlatform() ~= UI_PLATFORM_PC then return nil end
	local service = GetPlatformServiceType()
	if service == PLATFORM_SERVICE_TYPE_STEAM then return "Steam"
	elseif service == PLATFORM_SERVICE_TYPE_EPIC then return "Epic"
	elseif service == PLATFORM_SERVICE_TYPE_ZOS then return "ZOS"
	elseif service == PLATFORM_SERVICE_TYPE_DMM then return "DMM"
	end
	return nil
end

function LibAPH.IsAddonActiveAndRunning(addonName)
	local am = GetAddOnManager()
	for i = 1, am:GetNumAddOns() do
		local name, _, _, _, isEnabled, state = am:GetAddOnInfo(i)
		if name == addonName and isEnabled and state == ADDON_STATE_ENABLED then return true end
	end
	return false
end

function LibAPH.IsLibraryAddonByName(am, addonName)
	for i = 1, am:GetNumAddOns() do
		local name, _, _, _, _, _, _, isLibrary = am:GetAddOnInfo(i)
		if name == addonName then return isLibrary or string.sub(name, 1, 3) == "Lib" end
	end
	return false
end
