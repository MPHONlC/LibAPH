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

function LibAPH.BuildEnvironmentReport()
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
		"Live API: " .. tostring(GetAPIVersion()),
		"",
		"Enabled add-ons (" .. #addons .. "):",
		table.concat(addons, "\n"),
		"",
		"Enabled libraries (" .. #libraries .. "):",
		table.concat(libraries, "\n"),
	}, "\n")
end

function LibAPH.FitBugReportText(text)
	if #text <= BUG_REPORT_MAX_CHARS then return text end
	local note = "\n\n[report cut at " .. BUG_REPORT_MAX_CHARS .. " characters]"
	return string.sub(text, 1, BUG_REPORT_MAX_CHARS - #note) .. note
end

LibAPH.BUG_REPORT_MAX_CHARS = BUG_REPORT_MAX_CHARS

function LibAPH.CreateAddonBugReporter(opts)
	local reporter = {}
	local box

	local function Store()
		local store = opts.getStore()
		store.captured_bugs = store.captured_bugs or {}
		return store
	end

	local function BuildText()
		local store = Store()
		local header = {
			opts.title .. " bug report",
			"Version: " .. tostring(opts.version or "unknown"),
			"LibAPH: " .. tostring(LibAPH.VERSION),
			"Platform: " .. tostring(LibAPH.GetPlatformString() or "unknown"),
			"Language: " .. tostring(GetCVar("Language.2")),
		}
		local error_section
		if #store.captured_bugs > 0 then
			local lines = {}
			for _, bug in ipairs(store.captured_bugs) do
				lines[#lines + 1] = bug.count > 1 and (bug.text .. " (seen " .. bug.count .. "x)") or bug.text
			end
			error_section = "Lua errors captured:\n\n" .. table.concat(lines, "\n\n")
		else
			error_section = "No Lua error from " .. opts.title .. " was captured.\n"
				.. "Describe the bug you saw here: what you were doing, what happened, and what you expected to happen.\n\n\n"
		end
		return LibAPH.FitBugReportText(table.concat(header, "\n") .. "\n\n" .. error_section .. "\n\n" .. LibAPH.BuildEnvironmentReport())
	end

	function reporter.Show()
		if IsConsoleUI() then return end
		box = box or LibAPH.CreateCopyTextBox({
			name = opts.boxName,
			titleText = "COPY & PASTE THIS TO YOUR BUG REPORT",
			closeText = "Close",
			maxInputChars = BUG_REPORT_MAX_CHARS,
			dismissBug = { text = "Dismiss Bug", onClick = function()
				Store().captured_bugs = {}
				reporter.Show()
			end },
			wipeAllBugs = { text = "Wipe All Bugs", onClick = function()
				Store().captured_bugs = {}
				box:Hide()
			end },
		})
		box:Show(BuildText())
	end

	if not IsConsoleUI() then
		LibAPH.HookErrorCapture(opts.addonName, function(text)
			local is_new = LibAPH.RecordCapturedBug(Store().captured_bugs, text)
			if is_new or (box and not box.window:IsHidden()) then reporter.Show() end
		end)
	end

	return reporter
end
