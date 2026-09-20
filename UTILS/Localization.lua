-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")

function LibAPH.Localize(langTable, langCode, key, ...)
	local for_lang = langTable and langTable[langCode]
	local en = langTable and langTable.en
	local str = (for_lang and for_lang[key]) or (en and en[key]) or key
	if select("#", ...) > 0 then
		return string.format(str, ...)
	end
	return str
end

function LibAPH.LoadLocalization(addonPrefix, langTable, defaultLang, overrideLang)
	local prefixed = {}
	for code, strings in pairs(langTable) do
		local pt = {}
		for key, text in pairs(strings) do
			pt[addonPrefix .. key] = text
		end
		prefixed[code] = pt
	end

	local function safe_add(name, text, version)
		if LibLanguage then
			LibLanguage.SafeAddString(name, text, version)
			return
		end
		local id = _G[name]
		if not id then
			ZO_CreateStringId(name, text)
		else
			SafeAddString(id, text, version)
		end
	end

	if LibLanguage then
		LibLanguage.LoadLanguage(prefixed, defaultLang)
	else
		local dtbl = prefixed[defaultLang]
		if dtbl then
			for name, text in pairs(dtbl) do safe_add(name, text, 1) end
		end
		local lang = GetCVar("Language.2")
		if lang ~= defaultLang and prefixed[lang] then
			for name, text in pairs(prefixed[lang]) do safe_add(name, text, 2) end
		end
	end

	if overrideLang and prefixed[overrideLang] then
		for name, text in pairs(prefixed[overrideLang]) do safe_add(name, text, 3) end
	end
end

function LibAPH.BuildLanguagePickerControls(opts)
	local L = opts.L
	local controls = {
		{
			type = "description",
			text = function()
				return L("CURRENT_LANGUAGE_LABEL") .. " |c00FF00" .. opts.formatCurrentLanguageText(opts.settings.override_language) .. "|r"
			end
		}
	}

	if opts.isPad then
		local names, values = { L("LANGUAGE_AUTO") }, { "auto" }
		for _, code in ipairs(opts.getAvailableLanguages()) do
			table.insert(names, string.format("%s (%s)", opts.getLanguageDisplayName(code), code))
			table.insert(values, code)
		end
		table.insert(controls, {
			type = "dropdown",
			name = function() return L("LANGUAGE_SELECTOR_NAME") end,
			reference = opts.reference,
			choices = names, choicesValues = values,
			getFunc = function()
				local pending = opts.getPending()
				if pending == nil then return opts.settings.override_language or "auto" end
				return pending
			end,
			setFunc = function(v) opts.setPending(v) end
		})
		table.insert(controls, {
			type = "button",
			name = function() return "|c00FF00" .. L("BTN_APPLY_LANGUAGE") .. "|r" end,
			func = function()
				local pending = opts.getPending()
				if pending == nil then return end
				opts.settings.override_language = (pending ~= "auto") and pending or nil
				LibAPH.LoadLocalization(opts.addonPrefix, opts.langTable, "en", opts.settings.override_language or GetCVar("Language.2"))
				opts.setPending(nil)
			end
		})
	else
		local active = opts.settings.override_language or GetCVar("Language.2")
		local choices, values = {}, {}
		local auto_color = (not opts.settings.override_language) and "|c00FF00" or "|cFFFFFF"
		table.insert(choices, auto_color .. L("LANGUAGE_AUTO") .. "|r")
		table.insert(values, "auto")
		for _, code in ipairs(opts.getAvailableLanguages()) do
			local color = (code == active) and "|c00FF00" or "|cFFFFFF"
			table.insert(choices, color .. string.format("%s (%s)", opts.getLanguageDisplayName(code), code) .. "|r")
			table.insert(values, code)
		end
		table.insert(controls, {
			type = "dropdown",
			name = function() return L("LANGUAGE_SELECTOR_NAME") end,
			choices = choices, choicesValues = values,
			getFunc = function() return opts.settings.override_language or "auto" end,
			setFunc = function(v)
				opts.settings.override_language = (v ~= "auto") and v or nil
				LibAPH.LoadLocalization(opts.addonPrefix, opts.langTable, "en", opts.settings.override_language or GetCVar("Language.2"))
			end,
			requiresReload = false,
			width = "full"
		})
	end

	return controls
end
