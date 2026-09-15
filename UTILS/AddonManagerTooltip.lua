-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")
assert(LibAPH.KnownAddonDependencies, "KnownAddonDependencies.lua must be loaded before this file")

function LibAPH.GetOptionalLibsFor(addonName)
	local decl = LibAPH.registered_dependencies and LibAPH.registered_dependencies[addonName]
	local libs = {}
	if decl then
		for lib_name in pairs(decl.optional) do table.insert(libs, lib_name) end
	elseif LibAPH.KnownAddonDependencies[addonName] then
		for _, lib_name in ipairs(LibAPH.KnownAddonDependencies[addonName]) do table.insert(libs, lib_name) end
	end
	table.sort(libs)
	return libs
end

local function FormatLibraryStatus(am, lib_name, min_version, show_version)
	for i = 1, am:GetNumAddOns() do
		local name, _, _, _, enabled, state = am:GetAddOnInfo(i)
		if name == lib_name then
			local ver = am:GetAddOnVersion(i)
			local ver_suffix = show_version and LibAPH.FormatVersionBare(ver) or ""
			if enabled and state == ADDON_STATE_ENABLED then
				if min_version and min_version > 0 and ver < min_version then
					return "|cFFA500" .. lib_name .. ver_suffix .. "|r"
				end
				return "|c00FF00" .. lib_name .. ver_suffix .. "|r"
			end
			return "|cFF0000" .. lib_name .. ver_suffix .. "|r"
		end
	end
	return "|c888888" .. lib_name .. " (not installed)|r"
end

local function GetRequiredLibsInfo(am, addon_index)
	local list = {}
	for d = 1, am:GetAddOnNumDependencies(addon_index) do
		local dep_name, _, _, minVersion = am:GetAddOnDependencyInfo(addon_index, d)
		table.insert(list, { name = dep_name, minVersion = minVersion })
	end
	return list
end

local function AddTitleLine(tooltip, text)
	local r, g, b = ZO_SELECTED_TEXT:UnpackRGB()
	tooltip:AddLine(text, "ZoFontHeader3", r, g, b, CENTER, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER, true)
end
local function AddSubTitleLine(tooltip, text)
	local r, g, b = ZO_SELECTED_TEXT:UnpackRGB()
	tooltip:AddLine(text, "ZoFontWinH5", r, g, b, CENTER, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER, true)
end
local function AddCenterLine(tooltip, text)
	local r, g, b = ZO_TOOLTIP_DEFAULT_COLOR:UnpackRGB()
	tooltip:AddLine(text, "", r, g, b, CENTER, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER, true)
end

local function AddLibrarySections(am, data, optional_libs)
	if data.index then
		local required = GetRequiredLibsInfo(am, data.index)
		if #required > 0 then
			AddSubTitleLine(ItemTooltip, #required > 1 and "Required libraries:" or "Required library:")
			local parts = {}
			for _, r in ipairs(required) do
				table.insert(parts, FormatLibraryStatus(am, r.name, r.minVersion, true))
			end
			AddCenterLine(ItemTooltip, table.concat(parts, ", "))
		end
	end

	if #optional_libs > 0 then
		AddSubTitleLine(ItemTooltip, #optional_libs > 1 and "Optional libraries:" or "Optional library:")
		local parts = {}
		for _, lib_name in ipairs(optional_libs) do
			table.insert(parts, FormatLibraryStatus(am, lib_name, nil, false))
		end
		AddCenterLine(ItemTooltip, table.concat(parts, ", "))
	end
end

local hover_depth = 0

local function OnAddonManagerRowMouseEnter(control)
	hover_depth = hover_depth + 1

	local data = control.data
	if not data or not data.addOnFileName then return end

	local am = GetAddOnManager()
	local optional_libs = LibAPH.GetOptionalLibsFor(data.addOnFileName)

	local manager_window = ZO_AddOns or control:GetParent()
	local edge_offset = manager_window:GetRight() - control:GetRight()
	InitializeTooltip(ItemTooltip, control, TOPLEFT, edge_offset, 0, TOPRIGHT)
	AddTitleLine(ItemTooltip, data.addOnName)
	if data.index then
		local ver = am:GetAddOnVersion(data.index)
		if ver and ver > 0 then
			AddSubTitleLine(ItemTooltip, "Version " .. ver)
		end
	end
	if data.isOutOfDate ~= nil then
		if data.isOutOfDate then
			AddCenterLine(ItemTooltip, "|cFF0000Out of Date|r")
		else
			AddCenterLine(ItemTooltip, "|c00FF00API " .. GetAPIVersion() .. " (Up to Date)|r")
		end
	end
	ZO_Tooltip_AddDivider(ItemTooltip)
	if data.addOnAuthorByLine and data.addOnAuthorByLine ~= "" then
		AddSubTitleLine(ItemTooltip, data.addOnAuthorByLine)
	end
	if data.addOnDescription and data.addOnDescription ~= "" then
		AddCenterLine(ItemTooltip, data.addOnDescription)
	end
	if data.index then
		AddCenterLine(ItemTooltip, am:GetAddOnRootDirectoryPath(data.index))
	end
	AddLibrarySections(am, data, optional_libs)
end

local function OnAddonManagerNameMouseEnter(nameControl)
	OnAddonManagerRowMouseEnter(nameControl:GetParent())
end

local function OnAddonManagerMouseExit(control)
	hover_depth = hover_depth - 1
	if hover_depth < 0 then hover_depth = 0 end
	zo_callLater(function()
		if hover_depth <= 0 then
			ClearTooltip(ItemTooltip)
		end
	end, 0)
end

local orig_GetRowSetupFunction = ZO_AddOnManager.GetRowSetupFunction
function ZO_AddOnManager:GetRowSetupFunction()
	local orig_setup = orig_GetRowSetupFunction(self)
	return function(control, data)
		orig_setup(control, data)
		if not control.libaph_tooltip_hooked then
			control.libaph_tooltip_hooked = true
			ZO_PostHookHandler(control, "OnMouseEnter", OnAddonManagerRowMouseEnter)
			ZO_PostHookHandler(control, "OnMouseExit", OnAddonManagerMouseExit)
			local name = control:GetNamedChild("Name")
			if name then
				ZO_PostHookHandler(name, "OnMouseEnter", OnAddonManagerNameMouseEnter)
				ZO_PostHookHandler(name, "OnMouseExit", OnAddonManagerMouseExit)
			end
		end
	end
end
