-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")
assert(LibAPH.KnownLibraries, "KnownLibraries.lua must be loaded before this file")

SLASH_COMMANDS["/libraryversioncheck"] = function()
	local names = {}
	for key in pairs(LibAPH.KnownLibraries) do
		table.insert(names, key)
	end
	table.sort(names)

	local found_any = false
	for _, key in ipairs(names) do
		local libData = LibAPH.KnownLibraries[key]
		local ver = LibAPH.CheckLibraryVersion(key)
		if ver > 0 then
			if not found_any then
				d("|c9CD04C[LibAPH]|r Installed library versions (compared to this table's own recorded version):")
				found_any = true
			end
			local color, plus, label = LibAPH.GetLibraryDriftColor(ver, libData.requiredVersion)
			d(string.format("  %s: %sv%d%s%s|r", libData.fullName, color, ver, plus, label))
		end
	end

	if not found_any then
		d("|c9CD04C[LibAPH]|r None of the libraries in this table are currently installed.")
	end
end
