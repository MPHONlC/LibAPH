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
