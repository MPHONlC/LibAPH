-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")
local LibAPH = LibAPH

local BUG_REPORT_MAX_CHARS = 30000
local metadata_provider

function LibAPH.SetAddonMetadataProvider(provider)
	metadata_provider = provider
end

local function FormatEnvironmentLine(am, index, name, is_out_of_date)
	local meta = metadata_provider and metadata_provider(name) or nil
	local addon_version = am:GetAddOnVersion(index) or 0
	local api
	if meta and meta.apiVersion then
		api = meta.apiVersion
	else
		api = is_out_of_date and "not recorded (ESO flags it out of date)" or "not recorded (ESO reports it current)"
	end
	return string.format("- %s | Version %s | AddOnVersion %s | API %s",
		name,
		(meta and meta.displayVersion) or "not recorded",
		addon_version > 0 and tostring(addon_version) or "none",
		api)
end

function LibAPH.GetLiveApiLine()
	return "Live API: " .. tostring(GetAPIVersion())
end

function LibAPH.BuildEnabledAddonsReport()
	local am = GetAddOnManager()
	local addons, libraries = {}, {}
	for i = 1, am:GetNumAddOns() do
		local name, _, _, _, is_enabled, state, is_out_of_date, is_library = am:GetAddOnInfo(i)
		if is_enabled and state == ADDON_STATE_ENABLED then
			local target = is_library and libraries or addons
			target[#target + 1] = FormatEnvironmentLine(am, i, name, is_out_of_date)
		end
	end
	table.sort(addons)
	table.sort(libraries)
	return table.concat({
		"Enabled add-ons (" .. #addons .. "):",
		table.concat(addons, "\n"),
		"",
		"Enabled libraries (" .. #libraries .. "):",
		table.concat(libraries, "\n"),
	}, "\n")
end

function LibAPH.BuildEnvironmentReport()
	return LibAPH.GetLiveApiLine() .. "\n\n" .. LibAPH.BuildEnabledAddonsReport()
end

function LibAPH.FitBugReportText(text)
	if #text <= BUG_REPORT_MAX_CHARS then return text end
	local note = "\n\n[report cut at " .. BUG_REPORT_MAX_CHARS .. " characters]"
	return string.sub(text, 1, BUG_REPORT_MAX_CHARS - #note) .. note
end

LibAPH.BUG_REPORT_MAX_CHARS = BUG_REPORT_MAX_CHARS
LibAPH.BUG_REPORT_TITLE = "COPY & PASTE THIS BUG REPORT"
LibAPH.PASTEBIN_MESSAGE = "COPY PASTE THE CONTENT OF THIS WINDOW AND PASTE IT ON https://pastebin.com/ AND SUBMIT THE LINK."

function LibAPH.CreateAddonBugReporter(opts)
	local reporter = {}
	local box
	local session_bugs = {}
	if opts.getStore then opts.getStore().captured_bugs = nil end

	local function BuildText()
		local header = {
			opts.title .. " bug report",
			"Version: " .. tostring(opts.version or "unknown"),
			"LibAPH: " .. tostring(LibAPH.VERSION),
			"Platform: " .. tostring(LibAPH.GetPlatformString() or "unknown"),
			"Language: " .. tostring(GetCVar("Language.2")),
		}
		local error_section
		if #session_bugs > 0 then
			local lines = {}
			for _, bug in ipairs(session_bugs) do
				lines[#lines + 1] = bug.count > 1 and (bug.text .. " (seen " .. bug.count .. "x)") or bug.text
			end
			error_section = "Lua errors captured:\n\n" .. table.concat(lines, "\n\n")
		else
			error_section = "No Lua error from " .. opts.title .. " was captured.\n"
				.. "Describe the bug you saw here: what you were doing, what happened, and what you expected to happen.\n\n\n"
		end
		return LibAPH.FitBugReportText(table.concat({
			LibAPH.PASTEBIN_MESSAGE,
			error_section,
			table.concat(header, "\n"),
			LibAPH.GetLiveApiLine(),
			LibAPH.BuildEnabledAddonsReport(),
		}, "\n\n"))
	end

	function reporter.Show()
		if IsConsoleUI() then return end
		box = box or LibAPH.CreateCopyTextBox({
			name = opts.boxName,
			titleText = LibAPH.BUG_REPORT_TITLE,
			pastebin = true,
			closeText = "Close",
			maxInputChars = BUG_REPORT_MAX_CHARS,
			dismissBug = { text = "Dismiss Bug", onClick = function()
				ZO_ClearNumericallyIndexedTable(session_bugs)
				reporter.Show()
			end },
			wipeAllBugs = { text = "Wipe All Bugs", onClick = function()
				ZO_ClearNumericallyIndexedTable(session_bugs)
				box:Hide()
			end },
		})
		box:Show(BuildText())
	end

	if not IsConsoleUI() then
		LibAPH.HookErrorCapture(opts.addonName, function(text)
			local is_new = LibAPH.RecordCapturedBug(session_bugs, text)
			if is_new or (box and not box.window:IsHidden()) then reporter.Show() end
		end)
	end

	return reporter
end
