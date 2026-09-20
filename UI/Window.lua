-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")


function LibAPH.MakeWindowResizable(control, opts)
	opts = opts or {}
	control:SetResizeHandleSize(opts.handleSize or 8)
	control:SetDimensionConstraints(opts.minWidth or 0, opts.minHeight or 0, opts.maxWidth or 0, opts.maxHeight or 0)
	if opts.onResizing or opts.onResizeStop then
		control:SetHandler("OnResizeStart", function(self)
			if opts.onResizing then self:SetHandler("OnUpdate", opts.onResizing) end
		end)
		control:SetHandler("OnResizeStop", function(self)
			self:SetHandler("OnUpdate", nil)
			if opts.onResizeStop then opts.onResizeStop() end
		end)
	end
end

function LibAPH.CreateStatusWindow(opts)
	opts = opts or {}
	local parent = opts.parent or GuiRoot
	local win = WINDOW_MANAGER:CreateControl(opts.name, parent, CT_TOPLEVELCONTROL)
	win:SetClampedToScreen(true)
	win:SetMouseEnabled(true)
	win:SetMovable(opts.movable ~= false)
	win:SetHidden(true)
	win:SetAutoRectClipChildren(true)

	win:SetDrawTier(DT_HIGH)
	win:SetDrawLayer(DL_OVERLAY)
	win:SetDrawLevel(9000)

	win:SetDimensions(opts.width or 150, opts.height or 40)

	if opts.onMoveStop then
		win:SetHandler("OnMoveStop", function(ctrl)
			opts.onMoveStop(ctrl:GetLeft(), ctrl:GetTop())
		end)
	end

	local bg_name = opts.name and (opts.name .. "BG") or nil
	local bg_tex = WINDOW_MANAGER:CreateControl(bg_name, win, CT_BACKDROP)
	bg_tex:SetAnchor(TOPLEFT, win, TOPLEFT, 0, 0)
	bg_tex:SetAnchor(BOTTOMRIGHT, win, BOTTOMRIGHT, 0, 0)
	local bg = opts.bgColor or { 0, 0, 0, 0.6 }
	bg_tex:SetCenterColor(unpack(bg))
	bg_tex:SetEdgeColor(0, 0, 0, 0)
	bg_tex:SetDrawTier(DT_HIGH); bg_tex:SetDrawLayer(DL_OVERLAY); bg_tex:SetDrawLevel(0)

	local border_color = opts.borderColor or { 0.6, 0.6, 0.6, 0.8 }
	local border_thickness = opts.borderThickness or 2

	local border_top = WINDOW_MANAGER:CreateControl(nil, win, CT_BACKDROP)
	border_top:SetCenterColor(unpack(border_color)); border_top:SetEdgeColor(0, 0, 0, 0)
	border_top:SetDrawTier(DT_HIGH); border_top:SetDrawLayer(DL_OVERLAY); border_top:SetDrawLevel(1)
	border_top:SetAnchor(TOPLEFT, win, TOPLEFT, 0, 0)
	border_top:SetAnchor(TOPRIGHT, win, TOPRIGHT, 0, 0)
	border_top:SetHeight(border_thickness)

	local border_bottom = WINDOW_MANAGER:CreateControl(nil, win, CT_BACKDROP)
	border_bottom:SetCenterColor(unpack(border_color)); border_bottom:SetEdgeColor(0, 0, 0, 0)
	border_bottom:SetDrawTier(DT_HIGH); border_bottom:SetDrawLayer(DL_OVERLAY); border_bottom:SetDrawLevel(1)
	border_bottom:SetAnchor(BOTTOMLEFT, win, BOTTOMLEFT, 0, 0)
	border_bottom:SetAnchor(BOTTOMRIGHT, win, BOTTOMRIGHT, 0, 0)
	border_bottom:SetHeight(border_thickness)

	local border_left = WINDOW_MANAGER:CreateControl(nil, win, CT_BACKDROP)
	border_left:SetCenterColor(unpack(border_color)); border_left:SetEdgeColor(0, 0, 0, 0)
	border_left:SetDrawTier(DT_HIGH); border_left:SetDrawLayer(DL_OVERLAY); border_left:SetDrawLevel(1)
	border_left:SetAnchor(TOPLEFT, win, TOPLEFT, 0, 0)
	border_left:SetAnchor(BOTTOMLEFT, win, BOTTOMLEFT, 0, 0)
	border_left:SetWidth(border_thickness)

	local border_right = WINDOW_MANAGER:CreateControl(nil, win, CT_BACKDROP)
	border_right:SetCenterColor(unpack(border_color)); border_right:SetEdgeColor(0, 0, 0, 0)
	border_right:SetDrawTier(DT_HIGH); border_right:SetDrawLayer(DL_OVERLAY); border_right:SetDrawLevel(1)
	border_right:SetAnchor(TOPRIGHT, win, TOPRIGHT, 0, 0)
	border_right:SetAnchor(BOTTOMRIGHT, win, BOTTOMRIGHT, 0, 0)
	border_right:SetWidth(border_thickness)

	local font = opts.isGamepad and (opts.fontGamepad or "ZoFontGamepad22") or (opts.fontPC or "ZoFontGameSmall")
	local label_name = opts.name and (opts.name .. "Label") or nil
	local label = WINDOW_MANAGER:CreateControl(label_name, win, CT_LABEL)
	label:SetFont(font)
	label:SetColor(1, 1, 1, 1)
	label:SetText(opts.initialText or "Loading...")
	label:SetAnchor(CENTER, win, CENTER, 0, 0)
	if opts.centerAlign ~= false then
		label:SetHorizontalAlignment(TEXT_ALIGN_CENTER)
		label:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	end
	label:SetDrawTier(DT_HIGH)
	label:SetDrawLayer(DL_OVERLAY)
	label:SetDrawLevel(2)

	if opts.resizable ~= false then
		local font_face = opts.isGamepad and "EsoUI/Common/Fonts/FTN57.slug" or "EsoUI/Common/Fonts/Univers67.slug"
		local font_style = opts.isGamepad and "soft-shadow-thick" or "soft-shadow-thin"
		local base_size = opts.baseFontSize or (opts.isGamepad and 22 or 13)
		local min_size = opts.minFontSize or (opts.isGamepad and 16 or 10)
		local max_size = opts.maxFontSize or (opts.isGamepad and 40 or 32)
		local base_width = opts.width or 150
		local base_height = opts.height or 40

		local function apply_font_scale()
			local scale = math.min(win:GetWidth() / base_width, win:GetHeight() / base_height)
			local size = zo_clamp(zo_round(base_size * scale), min_size, max_size)
			label:SetFont(font_face .. "|" .. size .. "|" .. font_style)
		end
		win.libaph_apply_font_scale = apply_font_scale

		LibAPH.MakeWindowResizable(win, {
			minWidth = opts.minWidth or 100,
			minHeight = opts.minHeight or 30,
			maxWidth = opts.maxWidth or 600,
			maxHeight = opts.maxHeight or 90,
			onResizing = apply_font_scale,
			onResizeStop = function()
				apply_font_scale()
				if opts.onResizeStop then opts.onResizeStop(win:GetWidth(), win:GetHeight()) end
			end,
		})
	end

	return win, label
end

function LibAPH.CreateRowList(parent, opts)
	opts = opts or {}
	local orientation = (opts.orientation == "horizontal") and "horizontal" or "vertical"
	local spacing = opts.spacing or 4
	local maxRows = opts.maxRows or 20
	local padding = opts.padding or 6
	local minWidth = opts.minWidth or 40
	local minHeight = opts.minHeight or 20
	local font = opts.isGamepad and (opts.fontGamepad or "ZoFontGamepad22") or (opts.fontPC or "ZoFontGameSmall")
	local color = opts.color or { 1, 1, 1, 1 }
	local pname = parent.GetName and parent:GetName()

	local pool = {}
	local list = {}

	local function get_label(i)
		local label = pool[i]
		if label then return label end
		label = WINDOW_MANAGER:CreateControl(pname and (pname .. "Row" .. i) or nil, parent, CT_LABEL)
		label:SetFont(font)
		label:SetColor(unpack(color))
		label:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
		label:SetDrawTier(DT_HIGH); label:SetDrawLayer(DL_OVERLAY); label:SetDrawLevel(2)
		pool[i] = label
		return label
	end

	function list:SetRows(texts)
		local n = zo_min(#texts, maxRows)
		local offset, cross = 0, 0
		for i = 1, n do
			local label = get_label(i)
			label:SetText(texts[i])
			local w, h = label:GetTextDimensions()
			w = zo_max(w, 1); h = zo_max(h, 1)
			label:ClearAnchors()
			if orientation == "vertical" then
				label:SetAnchor(TOPLEFT, parent, TOPLEFT, padding, padding + offset)
				offset = offset + h + spacing
				cross = zo_max(cross, w)
			else
				label:SetAnchor(TOPLEFT, parent, TOPLEFT, padding + offset, padding)
				offset = offset + w + spacing
				cross = zo_max(cross, h)
			end
			label:SetHidden(false)
		end
		for i = n + 1, #pool do
			pool[i]:SetHidden(true)
		end

		local extent = zo_max(offset - spacing, 0)
		if orientation == "vertical" then
			parent:SetDimensions(zo_max(minWidth, cross + padding * 2), zo_max(minHeight, extent + padding * 2))
		else
			parent:SetDimensions(zo_max(minWidth, extent + padding * 2), zo_max(minHeight, cross + padding * 2))
		end
	end

	function list:Clear()
		self:SetRows({})
	end

	return list
end

function LibAPH.CreateCopyTextBox(opts)
	opts = opts or {}
	local footer_h = (opts.dismissBug or opts.wipeAllBugs) and 34 or 0
	local screen_w, screen_h = GuiRoot:GetWidth(), GuiRoot:GetHeight()
	local width = opts.width or zo_clamp(screen_w * (opts.widthPct or 0.31), opts.startMinWidth or 500, opts.startMaxWidth or 800)
	local height = opts.height or zo_clamp(screen_h * (opts.heightPct or 0.35), opts.startMinHeight or 320, opts.startMaxHeight or 600) + footer_h
	local win = WINDOW_MANAGER:CreateControl(opts.name, GuiRoot, CT_TOPLEVELCONTROL)
	win:SetDimensions(width, height)
	win:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
	win:SetDrawTier(DT_HIGH)
	win:SetDrawLayer(DL_OVERLAY)
	win:SetDrawLevel(9500)
	win:SetMouseEnabled(true)
	win:SetMovable(true)
	win:SetClampedToScreen(true)
	win:SetHidden(true)

	local bg = WINDOW_MANAGER:CreateControlFromVirtual(opts.name .. "BG", win, "ZO_DefaultBackdrop")
	bg:SetAnchorFill(win)

	local close_btn = WINDOW_MANAGER:CreateControlFromVirtual(nil, win, "ZO_CloseButton")
	close_btn:SetAnchor(TOPRIGHT, win, TOPRIGHT, -8, 8)
	close_btn:SetHandler("OnClicked", function()
		win:SetHidden(true)
		if opts.onClose then opts.onClose() end
	end)

	local title_lbl = WINDOW_MANAGER:CreateControl(nil, win, CT_LABEL)
	title_lbl:SetFont("ZoFontGameBold")
	title_lbl:SetColor(1, 1, 1, 1)
	title_lbl:SetText(opts.titleText or "")
	title_lbl:SetAnchor(TOPLEFT, win, TOPLEFT, 15, 12)
	title_lbl:SetAnchor(TOPRIGHT, close_btn, TOPLEFT, -10, 0)
	title_lbl:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)

	local copy_lbl = WINDOW_MANAGER:CreateControl(nil, win, CT_LABEL)
	copy_lbl:SetFont("ZoFontWinH5")
	copy_lbl:SetColor(0.4, 1, 0.4, 1)
	copy_lbl:SetText(opts.copyText or "Select All")
	copy_lbl:SetAnchor(TOPRIGHT, close_btn, BOTTOMRIGHT, 0, 10)
	copy_lbl:SetMouseEnabled(true)

	local dev_lbl
	if opts.devButton then
		dev_lbl = WINDOW_MANAGER:CreateControl(nil, win, CT_LABEL)
		dev_lbl:SetFont("ZoFontWinH5")
		dev_lbl:SetColor(1, 0.65, 0, 1)
		dev_lbl:SetText(opts.devButton.text or "Simulate Error")
		dev_lbl:SetAnchor(TOPRIGHT, copy_lbl, TOPLEFT, -20, 0)
		dev_lbl:SetMouseEnabled(true)
		LibAPH.AddButtonHoverEffects(dev_lbl, { 1, 0.65, 0, 1 })
		dev_lbl.libaph_click_action = opts.devButton.onClick
	end

	local reserved_width = 8 + copy_lbl:GetTextWidth()
	if dev_lbl then
		reserved_width = reserved_width + 20 + dev_lbl:GetTextWidth()
	end
	reserved_width = reserved_width + 15

	local search_bg = WINDOW_MANAGER:CreateControlFromVirtual(nil, win, "ZO_EditBackdrop")
	search_bg:SetAnchor(TOPLEFT, win, TOPLEFT, 15, 48)
	search_bg:SetAnchor(TOPRIGHT, win, TOPRIGHT, -reserved_width, 43)
	search_bg:SetHeight(24)

	local search_box = WINDOW_MANAGER:CreateControlFromVirtual(nil, search_bg, "ZO_DefaultEdit")
	search_box:SetAnchor(TOPLEFT, search_bg, TOPLEFT, 6, 2)
	search_box:SetAnchor(BOTTOMRIGHT, search_bg, BOTTOMRIGHT, -6, -2)
	search_box:SetFont("ZoFontGameSmall")
	LibAPH.AddGhostText(search_box, opts.searchLabel or "Search")

	local status_lbl = WINDOW_MANAGER:CreateControl(nil, win, CT_LABEL)
	status_lbl:SetFont("ZoFontGameSmall")
	status_lbl:SetColor(0.7, 0.7, 0.7, 1)
	status_lbl:SetAnchor(TOPLEFT, search_bg, TOPRIGHT, 10, 5)
	status_lbl:SetText("")

	local edit_bg = WINDOW_MANAGER:CreateControlFromVirtual(nil, win, "ZO_MultiLineEditBackdrop_Keyboard")
	edit_bg:SetAnchor(TOPLEFT, win, TOPLEFT, 15, 80)
	edit_bg:SetAnchor(BOTTOMRIGHT, win, BOTTOMRIGHT, -15, -(15 + footer_h))

	local eb = WINDOW_MANAGER:CreateControlFromVirtual(nil, edit_bg, "ZO_DefaultEditMultiLineForBackdrop")
	eb:SetAnchor(TOPLEFT, edit_bg, TOPLEFT, 8, 8)
	eb:SetAnchor(BOTTOMRIGHT, edit_bg, BOTTOMRIGHT, -20, -8)
	eb:SetMaxInputChars(opts.maxInputChars or 4000)

	local scroll_track = WINDOW_MANAGER:CreateControl(nil, edit_bg, CT_BACKDROP)
	scroll_track:SetDimensions(6, 1)
	scroll_track:SetAnchor(TOPRIGHT, edit_bg, TOPRIGHT, -10, 12)
	scroll_track:SetAnchor(BOTTOMRIGHT, edit_bg, BOTTOMRIGHT, -10, -12)
	scroll_track:SetCenterColor(0, 0, 0, 0.5)
	scroll_track:SetEdgeColor(0, 0, 0, 0)

	local scroll_thumb = WINDOW_MANAGER:CreateControl(nil, scroll_track, CT_BACKDROP)
	scroll_thumb:SetWidth(6)
	scroll_thumb:SetCenterColor(0.55, 0.55, 0.55, 0.9)
	scroll_thumb:SetEdgeColor(0, 0, 0, 0)

	local function update_scrollbar()
		local extents = eb:GetScrollExtents()
		if extents <= 0 then
			scroll_thumb:SetHidden(true)
			return
		end
		scroll_thumb:SetHidden(false)
		local track_height = scroll_track:GetHeight()
		local thumb_height = zo_clamp(track_height / (extents + 1), 16, track_height)
		local travel = zo_max(0, track_height - thumb_height)
		local frac = (eb:GetTopLineIndex() - 1) / zo_max(1, extents)
		scroll_thumb:SetHeight(thumb_height)
		scroll_thumb:ClearAnchors()
		scroll_thumb:SetAnchor(TOPLEFT, scroll_track, TOPLEFT, 0, travel * frac)
	end
	ZO_PostHookHandler(eb, "OnMouseWheel", update_scrollbar)

	LibAPH.MakeWindowResizable(win, {
		minWidth = 400, minHeight = 300, maxWidth = 1200, maxHeight = 900,
		onResizing = update_scrollbar,
		onResizeStop = update_scrollbar,
	})

	local strip = opts.stripColors or LibAPH.StripColors
	local box = { window = win, editbox = eb }
	local plain_text, lower_text = "", ""
	local search_pos = 1

	local function count_matches(needle_lower)
		if needle_lower == "" then return 0 end
		local count, pos = 0, 1
		while true do
			local s = string.find(lower_text, needle_lower, pos, true)
			if not s then break end
			count = count + 1
			pos = s + 1
		end
		return count
	end

	local function match_index(needle_lower, match_start)
		local count, pos = 0, 1
		while true do
			local s = string.find(lower_text, needle_lower, pos, true)
			if not s then break end
			count = count + 1
			if s == match_start then return count end
			pos = s + 1
		end
		return count
	end

	local function jump_to(match_start, match_end)
		eb:SetCursorPosition(match_start - 1)
		eb:SetSelection(match_start - 1, match_end)
		local line = 1
		for _ in string.gmatch(string.sub(plain_text, 1, match_start), "\n") do
			line = line + 1
		end
		local target_line = zo_clamp(zo_max(1, line - 2), 1, eb:GetScrollExtents() + 1)
		eb:SetTopLineIndex(target_line)
		update_scrollbar()
	end

	local function do_search(forward)
		local needle = search_box:GetText()
		if needle == "" then
			status_lbl:SetText("")
			return
		end
		local needle_lower = string.lower(needle)
		local total = count_matches(needle_lower)
		if total == 0 then
			status_lbl:SetColor(1, 0.4, 0.4, 1)
			status_lbl:SetText(opts.noMatchesText or "No matches")
			return
		end

		local match_start, match_end
		if forward then
			match_start, match_end = string.find(lower_text, needle_lower, search_pos, true)
			if not match_start then
				match_start, match_end = string.find(lower_text, needle_lower, 1, true)
			end
		else
			local pos, last_s, last_e = 1, nil, nil
			while true do
				local s, e = string.find(lower_text, needle_lower, pos, true)
				if not s or s >= search_pos then break end
				last_s, last_e = s, e
				pos = s + 1
			end
			if not last_s then
				pos = 1
				while true do
					local s, e = string.find(lower_text, needle_lower, pos, true)
					if not s then break end
					last_s, last_e = s, e
					pos = s + 1
				end
			end
			match_start, match_end = last_s, last_e
		end

		if match_start then
			jump_to(match_start, match_end)
			search_pos = forward and (match_end + 1) or match_start
			status_lbl:SetColor(0.6, 1, 0.6, 1)
			status_lbl:SetText(string.format("%d/%d", match_index(needle_lower, match_start), total))
		end
	end

	ZO_PostHookHandler(search_box, "OnTextChanged", function()
		search_pos = 1
	end)
	search_box:SetHandler("OnEnter", function()
		do_search(not IsShiftKeyDown())
	end)

	LibAPH.AddButtonHoverEffects(copy_lbl, { 0.4, 1, 0.4, 1 })
	copy_lbl.libaph_click_action = function()
		eb:SelectAll()
		eb:TakeFocus()
	end

	if opts.dismissBug then
		local dismiss_lbl = WINDOW_MANAGER:CreateControl(nil, win, CT_LABEL)
		dismiss_lbl:SetFont("ZoFontWinH5")
		dismiss_lbl:SetColor(1, 0.55, 0.55, 1)
		dismiss_lbl:SetText(opts.dismissBug.text or "Dismiss Bug")
		dismiss_lbl:SetAnchor(BOTTOMLEFT, win, BOTTOMLEFT, 15, -14)
		dismiss_lbl:SetMouseEnabled(true)
		LibAPH.AddButtonHoverEffects(dismiss_lbl, { 1, 0.55, 0.55, 1 })
		dismiss_lbl.libaph_click_action = opts.dismissBug.onClick
		box.dismiss_lbl = dismiss_lbl
	end

	if opts.wipeAllBugs then
		local wipe_lbl = WINDOW_MANAGER:CreateControl(nil, win, CT_LABEL)
		wipe_lbl:SetFont("ZoFontWinH5")
		wipe_lbl:SetColor(1, 0.55, 0.55, 1)
		wipe_lbl:SetText(opts.wipeAllBugs.text or "Wipe All Bugs")
		wipe_lbl:SetAnchor(BOTTOMRIGHT, win, BOTTOMRIGHT, -15, -14)
		wipe_lbl:SetMouseEnabled(true)
		LibAPH.AddButtonHoverEffects(wipe_lbl, { 1, 0.55, 0.55, 1 })
		wipe_lbl.libaph_click_action = opts.wipeAllBugs.onClick
		box.wipe_lbl = wipe_lbl
	end

	function box:Hide()
		win:SetHidden(true)
		local scene_name = SCENE_MANAGER.currentScene and SCENE_MANAGER.currentScene:GetName()
		if (scene_name == "hud" or scene_name == "hudui") and SCENE_MANAGER:IsInUIMode() then
			SCENE_MANAGER:SetInUIMode(false)
		end
	end

	function box:Show(text)
		plain_text = strip(text)
		lower_text = string.lower(plain_text)
		search_pos = 1
		search_box:SetText("")
		status_lbl:SetText("")
		eb:SetText(plain_text)
		win:SetHidden(false)
		if not SCENE_MANAGER:IsInUIMode() then
			SCENE_MANAGER:SetInUIMode(true)
		end
		eb:SetCursorPosition(0)
		eb:SetTopLineIndex(1)
		eb:SelectAll()
		eb:TakeFocus()
		update_scrollbar()
	end
	return box
end

local function LightenColor(color, amount)
	return {
		color[1] + (1 - color[1]) * amount,
		color[2] + (1 - color[2]) * amount,
		color[3] + (1 - color[3]) * amount,
		color[4] or 1,
	}
end

local function DarkenColor(color, amount)
	return { color[1] * (1 - amount), color[2] * (1 - amount), color[3] * (1 - amount), color[4] or 1 }
end

function LibAPH.AddButtonHoverEffects(control, baseColor)
	local hoverColor = LightenColor(baseColor, 0.4)
	local pressedColor = DarkenColor(baseColor, 0.35)
	control:SetHandler("OnMouseEnter", function(self) self:SetColor(unpack(hoverColor)) end)
	control:SetHandler("OnMouseExit", function(self) self:SetColor(unpack(baseColor)) end)
	control:SetHandler("OnMouseDown", function(self) self:SetColor(unpack(pressedColor)) end)
	control:SetHandler("OnMouseUp", function(self, button, upInside)
		self:SetColor(unpack(upInside and hoverColor or baseColor))
		if upInside then
			PlaySound(SOUNDS.DEFAULT_CLICK)
			if self.libaph_click_action then self.libaph_click_action() end
		end
	end)
end

local keybind_btn_counter = 0

function LibAPH.AddGhostText(editBox, ghostText)
	local ghost = WINDOW_MANAGER:CreateControl(nil, editBox, CT_LABEL)
	ghost:SetFont("ZoFontGameSmall")
	ghost:SetColor(0.5, 0.5, 0.5, 1)
	ghost:SetText(ghostText)
	ghost:SetAnchor(LEFT, editBox, LEFT, 2, 0)
	ghost:SetMouseEnabled(false)

	local function UpdateGhost()
		ghost:SetHidden(editBox:GetText() ~= "")
	end
	ZO_PostHookHandler(editBox, "OnTextChanged", UpdateGhost)
	UpdateGhost()
	return ghost
end

function LibAPH.CreateKeybindLabelButton(parent, opts)
	opts = opts or {}
	keybind_btn_counter = keybind_btn_counter + 1
	local btn = WINDOW_MANAGER:CreateControlFromVirtual("LibAPH_KeybindBtn" .. keybind_btn_counter, parent, "ZO_KeybindButton")
	btn:SetKeybindButtonDescriptor({
		keybind = opts.keybind,
		gamepadPreferredKeybind = opts.gamepadPreferredKeybind,
		name = opts.name or "",
		callback = function(...)
			if btn.libaph_click_action then btn.libaph_click_action(...) end
		end,
	})
	btn.libaph_click_action = opts.callback

	local name_label = btn:GetNamedChild("NameLabel")
	if name_label then name_label:SetFont("ZoFontDialogKeybindDescription") end

	return btn
end

function LibAPH.CreateScrollListWindow(opts)
	opts = opts or {}
	local screen_w, screen_h = GuiRoot:GetWidth(), GuiRoot:GetHeight()
	local width = opts.width or zo_clamp(screen_w * (opts.widthPct or 0.34), opts.minWidth or 480, opts.maxWidth or 900)
	local height = opts.height or zo_clamp(screen_h * (opts.heightPct or 0.55), opts.minHeight or 420, opts.maxHeight or 820)

	local win = WINDOW_MANAGER:CreateControl(opts.name, GuiRoot, CT_TOPLEVELCONTROL)
	win:SetDimensions(width, height)
	win:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0)
	win:SetDrawTier(DT_MEDIUM)
	win:SetDrawLayer(DL_OVERLAY)
	win:SetDrawLevel(10)
	win:SetMouseEnabled(true)
	win:SetMovable(true)
	win:SetClampedToScreen(true)
	win:SetHidden(true)

	local bg = WINDOW_MANAGER:CreateControlFromVirtual(opts.name and (opts.name .. "BG") or nil, win, "ZO_DefaultBackdrop")
	bg:SetAnchorFill(win)

	local close_btn = WINDOW_MANAGER:CreateControlFromVirtual(nil, win, "ZO_CloseButton")
	close_btn:SetAnchor(TOPRIGHT, win, TOPRIGHT, -8, 8)

	local title_lbl = WINDOW_MANAGER:CreateControl(nil, win, CT_LABEL)
	title_lbl:SetFont("ZoFontWinH4")
	title_lbl:SetColor(1, 1, 1, 1)
	title_lbl:SetText(opts.titleText or "")
	title_lbl:SetAnchor(TOPLEFT, win, TOPLEFT, 15, 12)

	local subtitle_lbl = WINDOW_MANAGER:CreateControl(nil, win, CT_LABEL)
	subtitle_lbl:SetFont("ZoFontGameSmall")
	subtitle_lbl:SetColor(0.75, 0.75, 0.75, 1)
	subtitle_lbl:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
	subtitle_lbl:SetAnchor(TOPLEFT, title_lbl, TOPRIGHT, 12, 3)
	subtitle_lbl:SetAnchor(TOPRIGHT, close_btn, TOPLEFT, -10, 7)

	local footer_height = opts.footerHeight or 44
	local content_top = 45
	local search_box

	if opts.enableSearch then
		content_top = 78
		local search_bg = WINDOW_MANAGER:CreateControlFromVirtual(opts.name and (opts.name .. "SearchBG") or nil, win, "ZO_EditBackdrop")
		search_bg:SetDimensions(200, 26)
		search_bg:SetAnchor(TOPLEFT, win, TOPLEFT, 15, 48)

		search_box = WINDOW_MANAGER:CreateControlFromVirtual(nil, search_bg, "ZO_DefaultEdit")
		search_box:SetAnchor(TOPLEFT, search_bg, TOPLEFT, 6, 2)
		search_box:SetAnchor(BOTTOMRIGHT, search_bg, BOTTOMRIGHT, -6, -2)
		search_box:SetFont("ZoFontGameSmall")
		LibAPH.AddGhostText(search_box, "Search")
	end

	local list = WINDOW_MANAGER:CreateControlFromVirtual(opts.name and (opts.name .. "List") or nil, win, "ZO_ScrollList")
	list:SetAnchor(TOPLEFT, win, TOPLEFT, 15, content_top)
	list:SetAnchor(BOTTOMRIGHT, win, BOTTOMRIGHT, -30, -footer_height)

	local ROW_TYPE = 1
	local row_height = opts.rowHeight or 26
	local row_font = opts.isGamepad and (opts.fontGamepad or "ZoFontGamepad22") or (opts.fontPC or "ZoFontGame")

	local highlight = WINDOW_MANAGER:CreateControl(nil, list.contents, CT_BACKDROP)
	highlight:SetCenterColor(0.2, 1, 0.2, 0.16)
	highlight:SetEdgeColor(0, 0, 0, 0)
	highlight:SetDrawLevel(0)
	highlight:SetHidden(true)
	local highlighted_control

	local search_highlight = WINDOW_MANAGER:CreateControl(nil, list.contents, CT_BACKDROP)
	search_highlight:SetCenterColor(0.2, 1, 0.2, 0.3)
	search_highlight:SetEdgeColor(0, 0, 0, 0)
	search_highlight:SetDrawLevel(0)
	search_highlight:SetHidden(true)
	local search_highlight_control
	local current_search_match_data

	local function OnRowMouseEnter(control)
		highlighted_control = control
		highlight:ClearAnchors()
		highlight:SetAnchor(TOPLEFT, control, TOPLEFT, -4, 0)
		highlight:SetAnchor(BOTTOMRIGHT, control, BOTTOMRIGHT, 4, 0)
		highlight:SetHidden(false)

		local data = ZO_ScrollList_GetData(control)
		if not data then return end
		local edge_offset = win:GetRight() - control:GetRight()
		if data.populateTooltip then
			InitializeTooltip(ItemTooltip, control, LEFT, edge_offset, 0, RIGHT)
			data.populateTooltip(ItemTooltip)
		elseif data.tooltip then
			InitializeTooltip(ItemTooltip, control, LEFT, edge_offset, 0, RIGHT)
			SetTooltipText(ItemTooltip, data.tooltip)
		end
	end
	local function OnRowMouseExit(control)
		if highlighted_control == control then
			highlighted_control = nil
			highlight:SetHidden(true)
		end
		ClearTooltip(ItemTooltip)
	end
	local CHECKBOX_TEXT_INDENT = 26

	local function ApplyRowToggle(control, data, checked)
		data.checked = checked
		ZO_CheckButton_SetCheckState(control.checkbox, checked)
		if data.onToggle then data.onToggle(checked) end

		control.text_lbl:SetColor(1, 1, 1, 1)
		zo_callLater(function()
			if ZO_ScrollList_GetData(control) == data then
				control.text_lbl:SetColor(unpack(data.color or { 1, 1, 1, 1 }))
			end
		end, 150)
	end

	local function OnRowMouseUp(control, button, upInside)
		if not upInside then return end
		local data = ZO_ScrollList_GetData(control)
		if not data then return end
		if data.checkable then
			PlaySound(SOUNDS.DEFAULT_CLICK)
			ApplyRowToggle(control, data, not data.checked)
		elseif data.onClick then
			PlaySound(SOUNDS.DEFAULT_CLICK)
			data.onClick(control)
		end
	end

	local function SetupRow(control, data)
		if not control.libaph_row_initialized then
			control.libaph_row_initialized = true
			control:SetHeight(row_height)
			control:SetHandler("OnMouseEnter", OnRowMouseEnter)
			control:SetHandler("OnMouseExit", OnRowMouseExit)
			control:SetHandler("OnMouseUp", OnRowMouseUp)

			control.header_bg = WINDOW_MANAGER:CreateControl(nil, control, CT_BACKDROP)
			control.header_bg:SetCenterColor(0.3, 0.6, 1, 0.28)
			control.header_bg:SetEdgeColor(0, 0, 0, 0)
			control.header_bg:SetDrawLevel(0)
			control.header_bg:SetAnchor(TOPLEFT, control, TOPLEFT, -4, 0)
			control.header_bg:SetAnchor(BOTTOMRIGHT, control, BOTTOMRIGHT, 4, 0)

			control.text_lbl = WINDOW_MANAGER:CreateControl(nil, control, CT_LABEL)
			control.text_lbl:SetHorizontalAlignment(TEXT_ALIGN_LEFT)
			control.text_lbl:SetWrapMode(TEXT_WRAP_MODE_ELLIPSIS)
			control.text_lbl:SetMouseEnabled(false)

			control.checkbox = WINDOW_MANAGER:CreateControlFromVirtual(nil, control, "ZO_CheckButton")
			control.checkbox:SetAnchor(LEFT, control, LEFT, 4, 0)
			control.checkbox:SetDrawLayer(DL_OVERLAY)
			control.checkbox:SetDrawLevel(5)
			ZO_CheckButton_SetToggleFunction(control.checkbox, function(_, checked)
				local row_data = ZO_ScrollList_GetData(control)
				if row_data then ApplyRowToggle(control, row_data, checked) end
			end)

			control.close_btn = WINDOW_MANAGER:CreateControlFromVirtual(nil, control, "SavingEditBoxCancelButton")
			control.close_btn:SetDimensions(18, 18)
			control.close_btn:SetDrawLayer(DL_OVERLAY)
			control.close_btn:SetDrawLevel(5)
			control.close_btn:SetHandler("OnMouseEnter", function(self)
				InitializeTooltip(InformationTooltip, self, BOTTOM, 0, -2)
				SetTooltipText(InformationTooltip, "Delete")
			end)
			control.close_btn:SetHandler("OnMouseExit", function()
				ClearTooltip(InformationTooltip)
			end)
			control.close_btn:SetHandler("OnClicked", function()
				local row_data = ZO_ScrollList_GetData(control)
				if row_data and row_data.closeButton and row_data.closeButton.onClick then
					row_data.closeButton.onClick(control)
				end
			end)

			control.rename_btn = WINDOW_MANAGER:CreateControlFromVirtual(nil, control, "SavingEditBoxModifyButton")
			control.rename_btn:SetDimensions(18, 18)
			control.rename_btn:SetDrawLayer(DL_OVERLAY)
			control.rename_btn:SetDrawLevel(5)
			control.rename_btn:SetHandler("OnClicked", function()
				local row_data = ZO_ScrollList_GetData(control)
				if row_data and row_data.renameButton and row_data.renameButton.onClick then
					row_data.renameButton.onClick(control)
				end
			end)

			control.status_icons = LibAPH.CreateStatusIconStrip(control, true)
			for _, icon in ipairs(control.status_icons) do
				icon:SetDrawLayer(DL_OVERLAY)
			end
		end

		control:SetText("")
		control.header_bg:SetHidden(not data.is_header)
		control.text_lbl:SetFont(row_font)
		control.text_lbl:SetColor(unpack(data.color or { 1, 1, 1, 1 }))
		control.text_lbl:SetText(data.text)
		control.text_lbl:ClearAnchors()
		control.checkbox:SetHidden(not data.checkable)
		control.close_btn:SetHidden(not data.closeButton)
		control.rename_btn:SetHidden(not data.renameButton)
		control.close_btn:ClearAnchors()
		control.rename_btn:ClearAnchors()
		if data.closeButton then
			control.close_btn:SetAnchor(RIGHT, control, RIGHT, -4, 0)
			if data.renameButton then
				control.rename_btn:SetAnchor(RIGHT, control.close_btn, LEFT, -2, 0)
			end
		elseif data.renameButton then
			control.rename_btn:SetAnchor(RIGHT, control, RIGHT, -4, 0)
		end
		if data.checkable then
			ZO_CheckButton_SetCheckState(control.checkbox, data.checked)
			control.text_lbl:SetAnchor(TOPLEFT, control, TOPLEFT, CHECKBOX_TEXT_INDENT, 0)
		else
			control.text_lbl:SetAnchor(TOPLEFT, control, TOPLEFT, 0, 0)
		end
		local status_icons = data.statusIcons or {}
		LibAPH.UpdateStatusIconStrip(control.status_icons, control, status_icons, true)
		local status_icon_count = #status_icons

		local right_margin = 4
		if data.closeButton then right_margin = right_margin + 22 end
		if data.renameButton then right_margin = right_margin + 22 end
		if status_icon_count > 0 then right_margin = right_margin + status_icon_count * 20 end
		control.text_lbl:SetAnchor(BOTTOMRIGHT, control, BOTTOMRIGHT, -right_margin, 0)

		if data == current_search_match_data then
			search_highlight_control = control
			search_highlight:ClearAnchors()
			search_highlight:SetAnchor(TOPLEFT, control, TOPLEFT, -4, 0)
			search_highlight:SetAnchor(BOTTOMRIGHT, control, BOTTOMRIGHT, 4, 0)
			search_highlight:SetHidden(false)
		elseif search_highlight_control == control then
			search_highlight_control = nil
			search_highlight:SetHidden(true)
		end
	end
	ZO_ScrollList_AddDataType(list, ROW_TYPE, "ZO_SelectableLabel", row_height, SetupRow)

	local footer = WINDOW_MANAGER:CreateControl(nil, win, CT_CONTROL)
	footer:SetAnchor(BOTTOMLEFT, win, BOTTOMLEFT, 15, -10)
	footer:SetAnchor(BOTTOMRIGHT, win, BOTTOMRIGHT, -15, -10)
	footer:SetHeight(footer_height - 10)

	local api = { window = win, list = list, footer = footer, subtitle_lbl = subtitle_lbl }

	function api:SetTitle(text)
		title_lbl:SetText(text)
	end

	function api:SetSubtitle(text)
		subtitle_lbl:SetText(text or "")
	end

	function api:SetAllChecked(checked)
		local scrollData = ZO_ScrollList_GetDataList(list)
		for _, entry in ipairs(scrollData) do
			if entry.data.checkable then
				entry.data.checked = checked
				if entry.data.onToggle then entry.data.onToggle(checked) end
			end
		end
		ZO_ScrollList_RefreshVisible(list)
	end

	function api:SetRows(rows)
		ZO_ScrollList_Clear(list)
		local scrollData = ZO_ScrollList_GetDataList(list)
		for _, row in ipairs(rows) do
			scrollData[#scrollData + 1] = ZO_ScrollList_CreateDataEntry(ROW_TYPE, row)
		end
		ZO_ScrollList_Commit(list)
	end

	local search_matches = {}
	local search_match_pos = 0

	function api:JumpToSearchMatch(pos)
		if #search_matches == 0 then
			current_search_match_data = nil
			ZO_ScrollList_RefreshVisible(list)
			return
		end
		pos = ((pos - 1) % #search_matches) + 1
		search_match_pos = pos
		local scrollData = ZO_ScrollList_GetDataList(list)
		local i = search_matches[pos]
		current_search_match_data = scrollData[i].data
		ZO_ScrollList_ScrollDataIntoView(list, i)
		ZO_ScrollList_RefreshVisible(list)
	end

	function api:JumpToText(needle)
		needle = string.lower(needle or "")
		search_matches = {}
		if needle ~= "" then
			local scrollData = ZO_ScrollList_GetDataList(list)
			for i, entry in ipairs(scrollData) do
				local data = entry.data
				if data.text and string.find(string.lower(data.text), needle, 1, true) then
					table.insert(search_matches, i)
				end
			end
		end
		search_match_pos = 0
		self:JumpToSearchMatch(1)
	end

	if search_box then
		ZO_PostHookHandler(search_box, "OnTextChanged", function()
			api:JumpToText(search_box:GetText())
		end)
		search_box:SetHandler("OnUpArrow", function() api:JumpToSearchMatch(search_match_pos - 1) end)
		search_box:SetHandler("OnDownArrow", function() api:JumpToSearchMatch(search_match_pos + 1) end)
		search_box:SetHandler("OnEnter", function() api:JumpToSearchMatch(search_match_pos + 1) end)
	end

	LibAPH.MakeWindowResizable(win, {
		minWidth = opts.minWidth or 480, minHeight = opts.minHeight or 420,
		maxWidth = opts.maxWidth or 900, maxHeight = opts.maxHeight or 820,
		onResizing = function() ZO_ScrollList_Commit(list) end,
		onResizeStop = function() ZO_ScrollList_Commit(list) end,
	})

	function api:Show()
		win:SetHidden(false)
		if not SCENE_MANAGER:IsInUIMode() then
			SCENE_MANAGER:SetInUIMode(true)
		end
	end

	function api:Hide()
		win:SetHidden(true)
		local scene_name = SCENE_MANAGER.currentScene and SCENE_MANAGER.currentScene:GetName()
		if (scene_name == "hud" or scene_name == "hudui") and SCENE_MANAGER:IsInUIMode() then
			SCENE_MANAGER:SetInUIMode(false)
		end
	end

	close_btn:SetHandler("OnClicked", function()
		api:Hide()
		if opts.onClose then opts.onClose() end
	end)

	return api
end

function LibAPH.SetWindowActive(window, label, isActive, opts)
	opts = opts or {}
	if not isActive then
		window:SetAlpha(0)
		window:SetMouseEnabled(false)
		label:SetText(opts.emptyText or "")
		if opts.onResize then opts.onResize() end
		return false
	end
	window:SetAlpha(1)
	window:SetMouseEnabled(true)
	return true
end

function LibAPH.RemoveFragmentFromScenes(fragment, sceneNames)
	for _, name in ipairs(sceneNames) do
		local scene = SCENE_MANAGER:GetScene(name)
		if scene and scene:HasFragment(fragment) then
			scene:RemoveFragment(fragment)
		end
	end
end

function LibAPH.AddFragmentToScenes(fragment, sceneNames)
	for _, name in ipairs(sceneNames) do
		local scene = SCENE_MANAGER:GetScene(name)
		if scene then scene:AddFragment(fragment) end
	end
end
