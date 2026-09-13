-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")

function LibAPH.CheckSelfVersion(store, currentVersion, opts)
	opts = opts or {}
	local historyField = opts.historyField or "version_history"
	local versionField = opts.versionField or "last_version"
	local maxHistory = opts.maxHistory or 3

	store[historyField] = store[historyField] or {}
	local history = store[historyField]
	local previousVersion = store[versionField]

	if #history == 0 and previousVersion and previousVersion ~= currentVersion then
		table.insert(history, previousVersion)
	end

	local wasUpdated = false
	local hist_len = #history
	if hist_len == 0 or history[hist_len] ~= currentVersion then
		table.insert(history, currentVersion)
		if #history > maxHistory then
			table.remove(history, 1)
		end
		wasUpdated = (previousVersion ~= nil and previousVersion ~= currentVersion)
	end

	store[versionField] = currentVersion
	return wasUpdated, previousVersion
end
