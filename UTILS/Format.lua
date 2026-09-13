-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")

function LibAPH.FormatVersionParen(version)
	if not version or version <= 0 then return "" end
	return " (v" .. version .. ")"
end

function LibAPH.FormatVersionBare(version)
	if not version or version <= 0 then return "" end
	return " v" .. version
end

function LibAPH.GetLibraryDriftColor(installedVer, tableVer)
	if not tableVer then return "|cFFFFFF", "", "" end
	if installedVer > tableVer then return "|c00FFFF", "+", " (Newer Version)" end
	if installedVer < tableVer then return "|cFF0000", "", " (Old Version)" end
	return "|c00FF00", "", ""
end

function LibAPH.CheckLibraryVersion(addonName)
	local am = GetAddOnManager()
	local ver, enabled = 0, false
	for i = 1, am:GetNumAddOns() do
		local name, _, _, _, _, state = am:GetAddOnInfo(i)
		if name == addonName then
			local v = am:GetAddOnVersion(i)
			if state == ADDON_STATE_ENABLED then
				ver = math.max(ver, v); enabled = true
			elseif not enabled then
				ver = math.max(ver, v)
			end
		end
	end
	return ver, enabled
end

function LibAPH.FormatLibraryVersion(ver, enabled, requiredVer, formatters)
	if ver <= 0 then return formatters.missing() end
	if not enabled then return formatters.disabled(ver) end
	if ver == requiredVer then return formatters.exact(ver) end
	if ver < requiredVer then return formatters.old(ver, requiredVer) end
	return formatters.newer(ver, requiredVer)
end

function LibAPH.BuildLibraryWarning(templates, fullName, shortName, ver, enabled, requiredVer, consequence)
	return LibAPH.FormatLibraryVersion(ver, enabled, requiredVer, {
		missing = function()
			return string.format(templates.missing, fullName, shortName, "|c00FF00v" .. requiredVer .. "+|r", consequence)
		end,
		disabled = function(v)
			return string.format(templates.disabled, fullName, consequence)
		end,
		exact = function(v) return nil end,
		old = function(v, r)
			return string.format(templates.old, fullName, "|cFF0000v" .. v .. "|r", "|c00FF00v" .. r .. "+|r", consequence)
		end,
		newer = function(v, r) return nil end,
	})
end

function LibAPH.BuildLibraryWarningFromData(templates, libData, ver, enabled, consequence)
	return LibAPH.BuildLibraryWarning(templates, libData.fullName, libData.shortName, ver, enabled, libData.requiredVersion, consequence)
end

function LibAPH.FormatVersionHistory(history, currentVersion, sep)
	local list = history or { currentVersion }
	local colored = {}
	for i, v in ipairs(list) do
		if i == #list then table.insert(colored, "|c00FF00" .. v .. "|r")
		elseif i == 1 then table.insert(colored, "|cFF0000" .. v .. "|r")
		else table.insert(colored, v) end
	end
	return table.concat(colored, sep or ", ")
end

function LibAPH.FormatSettingsSnapshot(settings, fields, onLabel, offLabel)
	local lines = {}
	for _, f in ipairs(fields) do
		local v = settings and settings[f.key]
		if type(v) == "boolean" then
			table.insert(lines, f.label .. ": " .. (v and onLabel or offLabel))
		end
	end
	return table.concat(lines, "\n")
end

function LibAPH.StripColors(text)
	if type(text) ~= "string" then return text end
	return (text:gsub("|c%x%x%x%x%x%x", ""):gsub("|r", ""))
end

function LibAPH.ResetToDefaults(settings, defaults, excludeKeys, postFn)
	excludeKeys = excludeKeys or {}
	for k, v in pairs(defaults) do
		if not excludeKeys[k] then
			if type(v) == "table" then
				settings[k] = ZO_ShallowTableCopy(v)
			else
				settings[k] = v
			end
		end
	end
	if postFn then postFn() end
	ReloadUI("ingame")
end

function LibAPH.FormatInstallDateLine(installedDate, todayStr)
	return "|c00FF00" .. installedDate .. "|r > |cFFFFFF" .. todayStr .. "|r"
end

function LibAPH.FormatModuleFileLine(filename, state, labels)
	if state == "loaded" then
		return "|cFFFFFF" .. filename .. "|r\n    |c00FF00" .. labels.loaded .. "|r"
	elseif state == "missing" then
		return "|c888888" .. filename .. "\n    " .. labels.missing .. "|r"
	else
		return "|c888888" .. filename .. "\n    " .. labels.unloaded .. "|r"
	end
end

function LibAPH.BuildModuleFileList(moduleOrder, moduleFiles, getState, labels, sep)
	local lines = {}
	for _, mod_key in ipairs(moduleOrder) do
		table.insert(lines, LibAPH.FormatModuleFileLine(moduleFiles[mod_key], getState(mod_key), labels))
	end
	return table.concat(lines, sep or "\n  ")
end

function LibAPH.BuildBugReportText(opts)
	local text = opts.statsText
	text = text .. "\n\n" .. opts.fieldSettingsLabel .. "\n  " .. opts.settingsLines:gsub("\n", "\n  ")
	text = text .. "\n\n" .. opts.errorSection
	return text
end
