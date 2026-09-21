-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")
local LibAPH = LibAPH

LibAPH.registered_dependencies = LibAPH.registered_dependencies or {}

function LibAPH.RegisterAddonDependencies(addonName, requiredLibs, optionalLibs)
	local required, optional = {}, {}
	for _, name in ipairs(requiredLibs or {}) do required[name] = true end
	for _, name in ipairs(optionalLibs or {}) do optional[name] = true end
	LibAPH.registered_dependencies[addonName] = { required = required, optional = optional }
end
