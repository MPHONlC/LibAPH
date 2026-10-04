[SIZE="5"][COLOR="SeaGreen"]LibAPH[/COLOR][/SIZE]
[COLOR="Gray"][i]Helper library for my addons.[/i][/COLOR]

Everyday helper code my add-ons share, kept in one place so none of them has to carry its own copy. Any functions are subject to change.

[SIZE="3"][COLOR="DarkOrchid"]Features[/COLOR][/SIZE]

[LIST]
[*] [b]Window & Theme[/b] - resizable status/scroll-list windows with a shared flat theme
[*] [b]Console Support[/b] - right-stick window drag/resize, console text-entry and picker dialogs
[*] [b]Context Menu & Search Bar[/b] - multi-level context menu, movable expanding search bar, key-hint icons
[*] [b]Module Manager[/b] - soft-disables individual add-on files and rebuilds the Client Info file list
[*] [b]Wizard Helper[/b] - schedules a first-run setup wizard, auto-unloads once completed
[*] [b]Messaging & Dialogs[/b] - chained/window-hiding dialogs, safe CSAs, a chat logger
[*] [b]Player State[/b] - crafting/interacting/menu busy checks, movement and teleport trackers
[*] [b]SavedVariables[/b] - disk-usage reporting, throttled priority saves, unused-SV cleanup
[*] [b]Library & Version Checks[/b] - checks an optional library's version and builds a shared warning message
[*] [b]Bug Reporting[/b] - a shared [color=#00FFFF]/xxxbugreport[/color] popup format used by every add-on
[*] [b]Activity Triggers[/b] - a shared table of "is the player doing X" checks
[*] [b]Scheduler[/b] - spreads work across frames within a time budget, staged add-on init
[/LIST]

[SIZE="3"][COLOR="DarkOrchid"]Installation[/COLOR][/SIZE]

Extract [b]LibAPH[/b] into your AddOns directory, then declare it as a dependency in your add-on manifest:

[code]## DependsOn: LibAPH>=<version>[/code]

It loads as a global table; no require or manual initialization needed:

[code]LibAPH.GetPlatformString()[/code]

[SIZE="3"][COLOR="DarkOrchid"]Usage[/COLOR][/SIZE]

LibAPH's functions hang off the single global [color=#00FFFF]LibAPH[/color] table, organized internally by folder (UI/, UTILS/, MODULES/, MENU/, HELPERS/, DATA/). Call whatever you need directly:

[code]local status = LibAPH.CreateStatusWindow({ name = "MyAddonUI", title = "My Addon" })
LibAPH.RegisterAddonDependencies("MyAddon", { "LibAPH" }, { "LibAddonMenu-2.0" })
LibAPH.Schedule("MyAddon_Cleanup", function() --[[ heavy work, one chunk per frame ]] end)[/code]

[SIZE="3"][COLOR="DarkOrchid"]API Reference[/COLOR][/SIZE]

[b]Window & Theme[/b] [COLOR="Gray"][i](UI/Window.lua, UI/Theme.lua, UI/Position.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]MakeWindowResizable(control, opts)[/color]: adds corner-drag resizing to a window
[*] [color=#00FFFF]CreateStatusWindow(opts)[/color]: builds a movable, resizable status window with the shared theme
[*] [color=#00FFFF]CreateRowList(parent, opts)[/color]: builds a themed scroll list of rows
[*] [color=#00FFFF]CreateScrollListWindow(opts)[/color]: builds a full window wrapping a themed scroll list
[*] [color=#00FFFF]CreateCopyTextBox(opts)[/color]: builds a read-only, selectable copy-text box (used by every bug report popup)
[*] [color=#00FFFF]OpenPastebin()[/color] / [color=#00FFFF]ConfirmOpenPastebin(win)[/color]: opens (or confirms opening) an external pastebin link
[*] [color=#00FFFF]StepActiveSearch(direction)[/color]: cycles a search box's matches forward/backward
[*] [color=#00FFFF]AddButtonHoverEffects(control, baseColor)[/color]: adds the shared hover/press color states to a button
[*] [color=#00FFFF]AddGhostText(editBox, ghostText)[/color]: shows greyed-out placeholder text in an empty edit box
[*] [color=#00FFFF]HandleKeybindButtonKey(keybind)[/color] / [color=#00FFFF]RegisterKeybindDefaults(namespace, store, defaults, modifiers)[/color] / [color=#00FFFF]CreateKeybindLabelButton(parent, opts)[/color]: shared keybind-button handling and default-binding registration
[*] [color=#00FFFF]SetWindowActive(window, label, isActive, opts)[/color]: shows/hides a window based on whether it has anything to display
[*] [color=#00FFFF]AddFragmentToScenes(fragment, sceneNames)[/color] / [color=#00FFFF]RemoveFragmentFromScenes(fragment, sceneNames)[/color]: batch scene-fragment registration
[*] [color=#00FFFF]CreateCogwheelButton(parent, name, onClicked, tooltipText)[/color]: builds the shared settings-cogwheel button
[*] [color=#00FFFF]IsScrollableMenuAvailable()[/color] / [color=#00FFFF]ShowScrollableMenu(control, entries, opts)[/color] / [color=#00FFFF]CloseScrollableMenu()[/color] / [color=#00FFFF]RefreshScrollableMenu()[/color]: LibScrollableMenu integration with a safe fallback when it's missing
[*] [color=#00FFFF]CreateToggleArrowButton(parent, name, onToggle, tooltipText)[/color] / [color=#00FFFF]SetToggleArrowOpen(button, open)[/color]: an expand/collapse arrow control
[*] [color=#00FFFF]DockWindowBeside(win, other, gap, prefer)[/color]: anchors one window beside another
[*] [color=#00FFFF]PixelSize()[/color]: returns the current UI pixel scale
[*] [color=#00FFFF]AddPixelBorder(control, name, color)[/color]: adds the shared one-pixel border
[*] [color=#00FFFF]ApplyPanelBackdrop(win, name, fill)[/color]: applies the shared flat panel background
[*] [color=#00FFFF]CreateHeaderStrip(win, name, height)[/color]: builds the shared header strip
[*] [color=#00FFFF]CreateThemedCloseButton(win, name, onClick, right, top)[/color]: builds the themed X close button
[*] [color=#00FFFF]StyleRowBackground(texture, index, is_section)[/color] / [color=#00FFFF]StyleScrollList(list, name)[/color]: shared row striping and scrollbar styling
[*] [color=#00FFFF]UseGreenSelection(combo)[/color]: colors a dropdown's selected entry green
[*] [color=#00FFFF]CreateStickyFragment(control, scenes)[/color]: keeps a window's own close state sticky across scene changes
[*] [color=#00FFFF]CreateWindowPosition(win, opts)[/color]: saves and restores a movable window's spot, resets it to a default, and runs the console right-stick move
[*] [color=#00FFFF]opts.onMoving(win)[/color] / [color=#00FFFF]opts.watchMs[/color]: optional; runs every watchMs (default 50 ms) while the window is dragged with the mouse or moved with the right stick
[*] [color=#00FFFF]opts.onMoveStop(win)[/color] / [color=#00FFFF]opts.onMoveEnd(win)[/color]: optional; onMoveStop runs after the new spot is saved, onMoveEnd runs whenever a right-stick move ends, moved or not
[*] [color=#00FFFF]pos:WatchMove()[/color] / [color=#00FFFF]pos:StopWatch()[/color]: start or stop the onMoving loop by hand (WatchMove returns false without onMoving)
[*] [color=#00FFFF]GetScreenThirdAlign(control)[/color] / [color=#00FFFF]GetScreenThirdAlignAt(centerX, screenWidth)[/color]: returns TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER or TEXT_ALIGN_RIGHT for whichever third of the screen a control's center sits in, so text can hug the nearest edge
[*] [color=#00FFFF]EnableUndoRedo(edit, opts)[/color]: keeps an undo and redo history for an edit box, with typing grouped into steps; call :Undo() and :Redo() from your own buttons
[/LIST]

Full Window & Theme example:
[spoiler]
[code]
local DemoWindow = { saved = {} }
local PAD = 12

local function Font(size)
	return string.format("$(MEDIUM_FONT)|%d|soft-shadow-thin", size)
end

local function MakeLabel(parent, text, size, color)
	local label = WINDOW_MANAGER:CreateControl(nil, parent, CT_LABEL)
	label:SetFont(Font(size or 14))
	label:SetColor(unpack(color or LibAPH.THEME.TEXT))
	label:SetText(text)
	return label
end

local function MakeButton(name, parent, text, width, onClick)
	local button = WINDOW_MANAGER:CreateControlFromVirtual(name, parent, "ZO_DefaultButton")
	button:SetDimensions(width, 26)
	button:SetText(text)
	button:SetHandler("OnClicked", onClick)
	return button
end

local function MakeTipLabel(parent, text, onEnter, onExit)
	local label = MakeLabel(parent, text, 14, LibAPH.THEME.ACCENT)
	label:SetMouseEnabled(true)
	label:SetHandler("OnMouseEnter", onEnter)
	label:SetHandler("OnMouseExit", onExit)
	return label
end

local function BuildDemoWindow()
	local win = WINDOW_MANAGER:CreateTopLevelWindow("LibAPHDemoWindow")
	win:SetDimensions(460, 520)
	win:SetClampedToScreen(true)
	win:SetMouseEnabled(true)
	win:SetMovable(true)
	win:SetDrawTier(DT_MEDIUM)
	win:SetDrawLayer(DL_OVERLAY)
	win:SetDrawLevel(9100)
	DemoWindow.window = win

	LibAPH.ApplyPanelBackdrop(win, "LibAPHDemoWindowBG", LibAPH.THEME.BG)
	LibAPH.CreateHeaderStrip(win, "LibAPHDemoWindowHeader", 30)
	LibAPH.CreateThemedCloseButton(win, "LibAPHDemoWindowClose", function() win:SetHidden(true) end, 12, 10)
	LibAPH.MakeWindowResizable(win, { minWidth = 440, minHeight = 500 })

	DemoWindow.position = LibAPH.CreateWindowPosition(win, {
		get = function() return DemoWindow.saved.left, DemoWindow.saved.top end,
		set = function(x, y) DemoWindow.saved.left, DemoWindow.saved.top = x, y end,
		placeDefault = function(control) control:SetAnchor(CENTER, GuiRoot, CENTER, 0, 0) end,
		mover = LibAPH.CreateGamepadMover(win),
	})
	DemoWindow.position:Apply()

	local title = MakeLabel(win, "LibAPH Demo", 16)
	title:SetAnchor(TOPLEFT, win, TOPLEFT, PAD, 7)

	local gear = LibAPH.CreateCogwheelButton(win, "LibAPHDemoGear", function()
		d("LibAPH Demo: gear clicked")
	end, "Cogwheel tooltip, built into the button")
	gear:SetAnchor(TOPRIGHT, win, TOPRIGHT, -40, 1)

	local y = 42
	local function Place(control, height)
		control:SetAnchor(TOPLEFT, win, TOPLEFT, PAD, y)
		y = y + height + 8
	end
	local function Section(text)
		Place(MakeLabel(win, text, 13, LibAPH.THEME.MUTED), 16)
	end

	Section("Buttons")
	local hover = MakeLabel(win, "Hover Me", 14, LibAPH.THEME.ACCENT)
	hover:SetDimensions(90, 26)
	hover:SetVerticalAlignment(TEXT_ALIGN_CENTER)
	hover:SetMouseEnabled(true)
	hover.libaph_click_action = function() d("LibAPH Demo: hover label clicked") end
	LibAPH.AddButtonHoverEffects(hover, LibAPH.THEME.ACCENT)
	Place(hover, 26)

	local copy_box = LibAPH.CreateCopyTextBox({ name = "LibAPHDemoCopyBox", titleText = "Demo Copy Box" })
	local copy_button = MakeButton("LibAPHDemoCopyButton", win, "Copy Box", 100, function()
		copy_box:Show("Select-and-copy text lives here.")
	end)
	copy_button:SetAnchor(LEFT, hover, RIGHT, 8, 0)
	local pastebin_button = MakeButton("LibAPHDemoPastebinButton", win, "Pastebin", 100, function()
		LibAPH.ConfirmOpenPastebin(win) -- LibAPH.OpenPastebin() skips the confirm dialog
	end)
	pastebin_button:SetAnchor(LEFT, copy_button, RIGHT, 8, 0)

	Section("Checkbox")
	local check = WINDOW_MANAGER:CreateControlFromVirtual("LibAPHDemoCheck", win, "ZO_CheckButton")
	ZO_CheckButton_SetLabelText(check, "Show the row list")
	ZO_CheckButton_SetCheckState(check, true)
	Place(check, 20)

	Section("Dropdowns")
	local combo_container = WINDOW_MANAGER:CreateControlFromVirtual("LibAPHDemoCombo", win, "ZO_ComboBox")
	combo_container:SetDimensions(180, 26)
	Place(combo_container, 26)
	local combo = ZO_ComboBox_ObjectFromContainer(combo_container)
	combo:SetSortsItems(false)
	for _, size_name in ipairs({ "Small", "Medium", "Large" }) do
		combo:AddItem(combo:CreateItemEntry(size_name, function(_, choice)
			d("LibAPH Demo: picked " .. choice)
		end))
	end
	combo:SelectFirstItem(true)
	LibAPH.UseGreenSelection(combo)

	local menu_combo_container = WINDOW_MANAGER:CreateControlFromVirtual("LibAPHDemoMenuCombo", win, "ZO_ComboBox")
	menu_combo_container:SetDimensions(180, 26)
	menu_combo_container:SetAnchor(LEFT, combo_container, RIGHT, 12, 0)
	local menu_combo = ZO_ComboBox_ObjectFromContainer(menu_combo_container)
	menu_combo:SetSelectedItemText("Opens a context menu")
	LibAPH.UseContextMenuForCombo(menu_combo_container, function()
		return {
			{ text = "Option A", onClick = function() menu_combo:SetSelectedItemText("Option A") end },
			{ text = "Option B", onClick = function() menu_combo:SetSelectedItemText("Option B") end },
		}
	end)

	Section("Context menu: right-click anywhere in this window")
	local show_hints = true
	win:SetHandler("OnMouseUp", function(control, button, upInside)
		if not upInside or button ~= MOUSE_BUTTON_INDEX_RIGHT then return end
		LibAPH.ShowContextMenu(control, {
			{ header = true, text = "LibAPH Demo" },
			{ text = "Say hello", hint = show_hints and "d()" or nil, onClick = function() d("LibAPH Demo: hello") end },
			{ text = "Show hints", checkbox = true, checked = show_hints, onToggle = function(on) show_hints = on end },
			{ divider = true },
			{ text = "More", submenu = function()
				return {
					{ text = "Sub item", onClick = function() d("LibAPH Demo: sub item") end },
					{ text = "Disabled item", enabled = false },
				}
			end },
		})
	end)
	y = y + 4

	Section("Tooltips: hover each word")
	local text_tip = MakeTipLabel(win, "Text", function(self)
		InitializeTooltip(InformationTooltip, self, BOTTOM, 0, -4)
		SetTooltipText(InformationTooltip, "InformationTooltip with plain text")
	end, function() ClearTooltip(InformationTooltip) end)
	Place(text_tip, 20)

	local side_tip = MakeTipLabel(win, "Side", function(self)
		ZO_Tooltips_ShowTextTooltip(self, RIGHT, "ZO_Tooltips_ShowTextTooltip, anchored to one side")
	end, function() ZO_Tooltips_HideTextTooltip() end)
	side_tip:SetAnchor(LEFT, text_tip, RIGHT, 24, 0)

	local item_tip = MakeTipLabel(win, "Item", function(self)
		local link = GetItemLink(BAG_WORN, EQUIP_SLOT_CHEST)
		InitializeTooltip(ItemTooltip, self, BOTTOM, 0, -4)
		if link ~= "" then
			ItemTooltip:SetLink(link)
		else
			SetTooltipText(ItemTooltip, "No chest piece equipped")
		end
	end, function() ClearTooltip(ItemTooltip) end)
	item_tip:SetAnchor(LEFT, side_tip, RIGHT, 24, 0)

	local ability_tip = MakeTipLabel(win, "Ability", function(self)
		local ability_id = GetSlotBoundId(ACTION_BAR_FIRST_NORMAL_SLOT_INDEX + 1, HOTBAR_CATEGORY_PRIMARY)
		InitializeTooltip(AbilityTooltip, self, BOTTOM, 0, -4)
		if ability_id ~= 0 then
			AbilityTooltip:SetAbilityId(ability_id)
		else
			SetTooltipText(AbilityTooltip, "First front-bar slot is empty")
		end
	end, function() ClearTooltip(AbilityTooltip) end)
	ability_tip:SetAnchor(LEFT, item_tip, RIGHT, 24, 0)

	Section("Search box")
	local search_bg = WINDOW_MANAGER:CreateControlFromVirtual("LibAPHDemoSearchBG", win, "ZO_EditBackdrop")
	search_bg:SetDimensions(220, 26)
	Place(search_bg, 26)
	local search_box = WINDOW_MANAGER:CreateControlFromVirtual("LibAPHDemoSearch", search_bg, "ZO_DefaultEditForBackdrop")
	LibAPH.AddGhostText(search_box, "Search rows...")
	search_box:SetHandler("OnEnter", function()
		LibAPH.StepActiveSearch(1) -- -1 steps to the previous match instead
	end)

	Section("Row list")
	local row_area = WINDOW_MANAGER:CreateControl("LibAPHDemoRowArea", win, CT_CONTROL)
	row_area:SetDimensions(200, 66)
	Place(row_area, 66)
	LibAPH.CreateRowList(row_area, { spacing = 2 }):SetRows({ "Row one", "Row two", "Row three" })
	ZO_CheckButton_SetToggleFunction(check, function(_, checked)
		row_area:SetHidden(not checked)
	end)

	LibAPH.RegisterKeybindDefaults("LibAPHDemo", DemoWindow.saved, { LibAPHDemo_Toggle = KEY_F5 })
	local keybind_button = LibAPH.CreateKeybindLabelButton(win, {
		action = "LibAPHDemo_Toggle",
		name = "Toggle Demo",
		callback = function() win:SetHidden(not win:IsHidden()) end,
	})
	keybind_button:SetAnchor(BOTTOMLEFT, win, BOTTOMLEFT, PAD, -PAD)

	local arrow, list_sticky
	local list_api = LibAPH.CreateScrollListWindow({
		name = "LibAPHDemoListWindow",
		titleText = "Demo List Window",
		rowHeight = 20,
		onClose = function()
			list_sticky:Close()
			LibAPH.SetToggleArrowOpen(arrow, false)
		end,
	})
	list_api:SetRows({ { text = "Row one", tooltip = "Rows can carry their own tooltip" }, { text = "Row two" } })
	list_api:Hide()
	LibAPH.MakeWindowResizable(list_api.window, { minWidth = 150, minHeight = 100 })

	list_sticky = LibAPH.CreateStickyFragment(list_api.window, { "hud", "hudui" })
	arrow = LibAPH.CreateToggleArrowButton(win, "LibAPHDemoArrow", function(wants_open)
		if wants_open then
			LibAPH.DockWindowBeside(list_api.window, win, 6)
			list_sticky:Open()
		else
			list_sticky:Close()
		end
		return wants_open
	end, "Show/hide the list window")
	arrow:SetAnchor(BOTTOMRIGHT, win, BOTTOMRIGHT, -8, -8)
	LibAPH.SetToggleArrowOpen(arrow, false)

	local demo_fragment = ZO_SimpleSceneFragment:New(win)
	LibAPH.AddFragmentToScenes(demo_fragment, { "hud", "hudui" })

	d(string.format("LibAPH Demo: UI pixel scale is %.3f", LibAPH.PixelSize()))
end

SLASH_COMMANDS["/demowindow"] = function()
	if not DemoWindow.window then
		BuildDemoWindow()
	else
		DemoWindow.window:SetHidden(not DemoWindow.window:IsHidden())
	end
end
[/code]
[/spoiler]
[/spoiler]

[b]Console[/b] [COLOR="Gray"][i](UI/Gamepad.lua, UI/GamepadDialogs.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]CreateGamepadMover(target)[/color]: right-analog-stick window dragging
[*] [color=#00FFFF]CreateGamepadResizer(target, opts)[/color]: right-analog-stick window resizing
[*] [color=#00FFFF]ForceControllerKeybindIcons()[/color]: forces controller-button icons instead of keyboard keys
[*] [color=#00FFFF]ShowGamepadTextEntry(opts)[/color] / [color=#00FFFF]ShowGamepadPicker(opts)[/color]: console text entry and picker dialogs
[/LIST]
[/spoiler]

[b]Context Menu[/b] [COLOR="Gray"][i](UI/ContextMenu.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]ShowContextMenu(control, entries, opts)[/color] / [color=#00FFFF]CloseContextMenu()[/color] / [color=#00FFFF]CloseContextMenuLevel()[/color]: opens/closes the multi-level menu
[*] [color=#00FFFF]IsContextMenuOpen()[/color] / [color=#00FFFF]GetContextMenuDepth()[/color] / [color=#00FFFF]GetContextMenuRowCount(level)[/color] / [color=#00FFFF]GetContextMenuPlacement(level)[/color]: menu-state queries
[*] [color=#00FFFF]RefreshContextMenu()[/color]: rebuilds the currently open menu in place
[*] [color=#00FFFF]ContextMenuRowClicked(row)[/color] / [color=#00FFFF]ContextMenuRowEntered(row)[/color] / [color=#00FFFF]MoveContextMenuFocus(direction)[/color] / [color=#00FFFF]ActivateContextMenuFocus()[/color]: row interaction and console focus movement
[*] [color=#00FFFF]UseContextMenuForCombo(container, build, opts)[/color]: adapts a combo box to open through this context menu
[/LIST]
[/spoiler]

[b]Search Bar & Key Hints[/b] [COLOR="Gray"][i](UI/SearchBar.lua, UI/KeyHints.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]CreateSearchBar(opts)[/color]: a movable search bar that expands into a match palette, with a console route
[*] [color=#00FFFF]CreateKeyHints(parent, name, hints)[/color]: shows the game's key icons, drawn key caps, or controller button hints
[/LIST]
[/spoiler]

[b]Status Icons[/b] [COLOR="Gray"][i](UI/StatusIcons.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]CreateStatusIconStrip(parentControl, selfHandled, slots, size)[/color]: builds a colored status-icon strip for a row
[*] [color=#00FFFF]UpdateStatusIconStrip(icons, anchorControl, statusIcons, growLeftward, offsetX, relativePoint)[/color]: repositions/refreshes an icon strip
[*] [color=#00FFFF]SetStatusIconFocused(icon, focused, focusScale)[/color]: highlights an icon on console focus
[/LIST]
[/spoiler]

[b]Module Manager[/b] [COLOR="Gray"][i](MODULES/ModuleManager.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]ToggleModuleDisabled(store, moduleFileFuncs, modKey, notifyFn, silent)[/color]: soft-disables/re-enables one module
[*] [color=#00FFFF]ApplyModuleDisableOverrides(store, moduleFileFuncs, modulesTable, nilOutFn, getFn)[/color]: nils out a disabled module's functions at load
[*] [color=#00FFFF]RegisterModuleLifecycle(modKey, hooks)[/color] / [color=#00FFFF]HasModuleLifecycle(modKey)[/color] / [color=#00FFFF]SyncModuleLifecycle(modulesTable, modKey, isDisabled)[/color]: onLoad/onUnload hooks for modules that can apply live
[*] [color=#00FFFF]StashFunc(modKey, fname, fn)[/color] / [color=#00FFFF]GetStashedFunc(modKey, fname)[/color]: keeps a disabled module's function retrievable without re-enabling it
[*] [color=#00FFFF]CallOptional(warnedTable, tag, unavailableNote, fn, label, ...)[/color]: calls a possibly-nil (module-disabled) function, warning once if it's missing
[*] [color=#00FFFF]BuildModuleFileList(moduleOrder, moduleFiles, getState, labels, sep)[/color] / [color=#00FFFF]FormatModuleFileLine(filename, state, labels)[/color]: builds the Client Info "Files" list
[*] [color=#00FFFF]BuildModuleLoadButton(opts)[/color]: builds the settings-menu unload/reload button for one module
[/LIST]
[/spoiler]

[b]Wizard[/b] [COLOR="Gray"][i](MODULES/Wizard.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]ScheduleWizardIfNeeded(isCompleted, runFn, delayMs)[/color]: runs the first-time setup wizard once, after a short delay
[*] [color=#00FFFF]AutoUnloadWizardModule(settings, toggleFn)[/color]: soft-disables the wizard module once it's been completed
[/LIST]
[/spoiler]

[b]Menu State[/b] [COLOR="Gray"][i](MENU/MenuState.lua, MENU/MenuRefresh.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]TrackSubmenuOpenState(savedTable, reference)[/color] / [color=#00FFFF]RestoreSubmenuOpenState(savedTable, reference)[/color] / [color=#00FFFF]PersistSubmenuOpenState(savedTable, reference)[/color]: remembers a LAM2 submenu's open/closed state, PC only
[*] [color=#00FFFF]CreateMenuLabelRefresher(addonPrefix, panelGetter)[/color]: forces a settings panel's labels to redraw on language change
[/LIST]
[/spoiler]

[b]Messaging & Dialogs[/b] [COLOR="Gray"][i](HELPERS/Messaging.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]ShowDialogChained(dialogId, title, body, buttons, delayMs, onClosed)[/color]: shows one dialog after another in sequence
[*] [color=#00FFFF]ShowDialogHidingWindows(windows, dialogId, title, body, buttons, delayMs, onClosed)[/color]: hides given windows while a dialog is up, restores them after, ref-counted across chained steps
[*] [color=#00FFFF]SafeCSA(enabled, title, body, lifespanMs)[/color]: shows a center-screen announcement only if the setting allows it
[*] [color=#00FFFF]CreateChatLogger(shortTag, colorHex)[/color]: builds a tagged, colored chat print function
[*] [color=#00FFFF]SendRawChatLine(msg)[/color]: prints a raw line to chat, working on console where CHAT_SYSTEM:AddMessage doesn't
[*] [color=#00FFFF]IsSafeToReloadUI()[/color] / [color=#00FFFF]ReloadUIWhenSafe(namespace, opts)[/color]: defers a ReloadUI() until it's safe to do (not mid-combat, etc.)
[/LIST]
[/spoiler]

[b]Player State[/b] [COLOR="Gray"][i](HELPERS/PlayerState.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]IsPlayerCrafting()[/color] / [color=#00FFFF]IsPlayerInteracting()[/color] / [color=#00FFFF]IsPlayerInMenu()[/color]: quick busy-state checks
[*] [color=#00FFFF]CheckBusyReason(checks)[/color]: runs a list of busy checks and returns which one (if any) is true
[*] [color=#00FFFF]CreateMovementTracker(opts)[/color] / [color=#00FFFF]CreateTeleportTracker(opts)[/color]: tracks player movement/teleport state over time
[*] [color=#00FFFF]RunWhenPlayerActivated(namespace, fn)[/color]: defers a function until EVENT_PLAYER_ACTIVATED
[*] [color=#00FFFF]GetClientStartTime()[/color] / [color=#00FFFF]IsSameClientSession(recordedStart, toleranceSec)[/color]: detects whether the client has restarted since a saved timestamp
[/LIST]
[/spoiler]

[b]SavedVariables[/b] [COLOR="Gray"][i](HELPERS/SavedVariables.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]IsPrioritySaveSupported()[/color] / [color=#00FFFF]RequestPrioritySave(addonName)[/color] / [color=#00FFFF]RequestPrioritySaveForRunningAddons(onSaved)[/color]: forces an early SavedVariables write
[*] [color=#00FFFF]RequestThrottledPrioritySave(namespace, addonName, throttleMs, force)[/color] / [color=#00FFFF]RequestThrottledPrioritySaveSweep(namespace, throttleMs, force, onSaved)[/color]: same, rate-limited
[*] [color=#00FFFF]GetSavedVariablesDiskCapacityMB()[/color] / [color=#00FFFF]GetSavedVariablesDiskUsageMB(addonIndex)[/color] / [color=#00FFFF]GetTotalSavedVariablesDiskUsageMB()[/color] / [color=#00FFFF]GetUnusedSavedVariablesDiskUsageMB()[/color]: disk-usage reporting
[*] [color=#00FFFF]ClearUnusedSavedVariables()[/color] / [color=#00FFFF]DeleteSavedVariablesForAddon(addonIndex)[/color]: frees disk space from disabled/removed add-ons
[/LIST]
[/spoiler]

[b]Library & Self Version Checks[/b] [COLOR="Gray"][i](UTILS/LibraryVersion.lua, UTILS/SelfVersion.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]CheckLibraryVersion(addonName)[/color]: returns an optional library's installed version and whether it's enabled
[*] [color=#00FFFF]GetLibraryDriftColor(installedVer, tableVer)[/color] / [color=#00FFFF]FormatLibraryVersion(ver, enabled, requiredVer, formatters)[/color]: colors/formats a version for display
[*] [color=#00FFFF]BuildLibraryWarning(templates, fullName, shortName, ver, enabled, requiredVer, consequence)[/color] / [color=#00FFFF]BuildLibraryWarningFromData(...)[/color]: builds the shared missing/disabled/outdated-library warning text (dialog + CSA + chat)
[*] [color=#00FFFF]CheckSelfVersion(store, currentVersion, opts)[/color]: detects if this add-on's own AddOnVersion changed since last load
[*] [color=#00FFFF]CheckAddonVersions(knownVersions, warnedTable, onMismatch)[/color]: compares known dependent add-ons' versions against a reference table
[/LIST]
[/spoiler]

[b]Bug Reporting[/b] [COLOR="Gray"][i](UTILS/BugReport.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]SetAddonMetadataProvider(provider)[/color]: registers how to fetch an add-on's own metadata for reports
[*] [color=#00FFFF]CreateAddonBugReporter(opts)[/color]: builds a ready-to-use /xxxbugreport popup for one add-on
[*] [color=#00FFFF]/libaphbugreport[/color]: opens LibAPH's own bug report popup (PC)
[*] [color=#00FFFF]GetLiveApiLine()[/color]: the current live API version, formatted
[*] [color=#00FFFF]BuildEnabledAddonsReport()[/color] / [color=#00FFFF]BuildEnvironmentReport()[/color]: lists every enabled add-on/library with Version, AddOnVersion, API
[*] [color=#00FFFF]DefaultBugReportSections(hasErrors)[/color] / [color=#00FFFF]BuildBugReportSections(opts)[/color] / [color=#00FFFF]BuildBugReportText(opts)[/color] / [color=#00FFFF]RenderBugReport(sections, enabled)[/color]: assembles the final report text
[*] [color=#00FFFF]FitBugReportText(text)[/color]: trims a report to fit the SavedVariables character limit
[/LIST]
[/spoiler]

[b]Dependency Registration[/b] [COLOR="Gray"][i](UTILS/DependencyRegistry.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]RegisterAddonDependencies(addonName, requiredLibs, optionalLibs)[/color]: declares an add-on's real dependencies for the Client Info panel
[/LIST]
[/spoiler]

[b]Activity Triggers[/b] [COLOR="Gray"][i](HELPERS/ActivityTriggers.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]GetActivityTriggers()[/color] / [color=#00FFFF]GetActivityTriggerGroups()[/color] / [color=#00FFFF]GetActivityTriggersInGroup(group_id)[/color] / [color=#00FFFF]GetActivityTrigger(id)[/color]: reads the shared trigger table
[*] [color=#00FFFF]RegisterActivityTrigger(definition)[/color]: adds a new "is the player doing X" trigger
[*] [color=#00FFFF]IsActivityTriggerActive(id, context)[/color] / [color=#00FFFF]CountActiveActivityTriggers(ids, context)[/color]: evaluates triggers
[*] [color=#00FFFF]RegisterActivityTriggerWatcher(namespace, callback, delayMs)[/color] / [color=#00FFFF]UnregisterActivityTriggerWatcher(namespace)[/color]: watches for trigger state changes
[*] [color=#00FFFF]GetPlayerStatusIcon(playerStatus)[/color] / [color=#00FFFF]GetFriendList()[/color] / [color=#00FFFF]GetIgnoredList()[/color] / [color=#00FFFF]GetGroupDisplayNames()[/color] / [color=#00FFFF]GetLootWindowSeconds()[/color]: related player/social lookups
[/LIST]
[/spoiler]

[b]Add-on Manager Helpers[/b] [COLOR="Gray"][i](HELPERS/AddonManager.lua, UTILS/Platform.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]EnableRequiredDependencies(index, setEnabled, onEnabled)[/color] / [color=#00FFFF]EnableAddonWithDependencies(index, setEnabled, onEnabled)[/color]: enables an add-on along with its dependencies
[*] [color=#00FFFF]GetPlatformString()[/color] / [color=#00FFFF]GetPlatformServiceName()[/color]: platform and storefront detection
[*] [color=#00FFFF]GetKeybindMarkup(action)[/color]: the bound key for an action as inline icon markup, or an empty string when nothing is bound
[*] [color=#00FFFF]IsGameScreenShown()[/color]: true only while the base game scene is fully shown (no menu, no transition)
[*] [color=#00FFFF]ShowMenuScene(scene)[/color]: opens a main-menu scene through the keyboard main menu when it knows the scene, otherwise through SCENE_MANAGER
[*] [color=#00FFFF]AfterSceneShown(scene, fn)[/color]: runs fn once scene is shown, checking every 100 ms for up to a second
[*] [color=#00FFFF]IsAddonActiveAndRunning(addonName)[/color] / [color=#00FFFF]IsLibraryAddonByName(am, addonName)[/color]: add-on state queries
[/LIST]
[/spoiler]

[b]Error Capture[/b] [COLOR="Gray"][i](HELPERS/ErrorCapture.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]HookErrorCapture(addonName, onCaptured)[/color]: hooks Lua errors for one add-on
[*] [color=#00FFFF]RecordCapturedBug(bugList, text, maxTracked)[/color]: records a captured error, capped
[*] [color=#00FFFF]FormatCapturedBugBlocks(title, bugs)[/color] / [color=#00FFFF]FormatCapturedBugsSection(bugLines, promptText, noneCapturedText, describeInsteadText)[/color]: formats captured errors for a bug report
[/LIST]
[/spoiler]

[b]Format Helpers[/b] [COLOR="Gray"][i](UTILS/Format.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]FormatVersionParen(version)[/color] / [color=#00FFFF]FormatVersionBare(version)[/color] / [color=#00FFFF]FormatVersionHistory(history, currentVersion, sep)[/color]: version-string formatting
[*] [color=#00FFFF]StripColors(text, fallback)[/color]: strips ESO color markup from a string
[*] [color=#00FFFF]PickDiskUnit(usageMB)[/color] / [color=#00FFFF]FormatSizeMB(sizeMB, decimals, subMegabyteUnit)[/color] / [color=#00FFFF]FormatDiskUsageMB(usageMB, short)[/color] / [color=#00FFFF]FormatDiskUsageRangeMB(usedMB, capacityMB)[/color] / [color=#00FFFF]FormatMemoryMB(sizeMB)[/color]: disk/memory-size formatting
[*] [color=#00FFFF]FormatInstallDateLine(installedDate, todayStr)[/color] / [color=#00FFFF]GetTodayDateString()[/color]: install-date formatting
[/LIST]
[/spoiler]

[b]Profile Store[/b] [COLOR="Gray"][i](UTILS/ProfileStore.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]CreateProfileStore(opts)[/color]: a saved-profile manager (create/switch/delete named settings profiles)
[*] [color=#00FFFF]CopyMap(source)[/color] / [color=#00FFFF]CopyList(source)[/color]: shallow-copy helpers for saved tables
[*] [color=#00FFFF]CaptureAddonEnabledState()[/color]: snapshots which add-ons are currently enabled
[/LIST]
[/spoiler]

[b]Packed Tables[/b] [COLOR="Gray"][i](DATA/PackedTable.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]CreatePackedTable(rows, parseRow)[/color] / [color=#00FFFF]CreatePackedConsoleTable(rows)[/color] / [color=#00FFFF]CreatePackedListTable(rows)[/color] / [color=#00FFFF]CreatePackedValueTable(rows)[/color]: unpacks a compact static data table into a lookup table
[*] [color=#00FFFF]GetPackedTableNames(packed)[/color]: lists the keys of a packed table
[/LIST]
[/spoiler]

[b]Scheduler[/b] [COLOR="Gray"][i](UTILS/Scheduler.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]Schedule(name, step, opts)[/color] / [color=#00FFFF]RunOrSchedule(name, step, opts)[/color]: spreads a function's work across frames within a time budget
[*] [color=#00FFFF]ScheduleLoop(name, items, body, opts)[/color]: schedules a per-item loop across frames
[*] [color=#00FFFF]ScheduleWait(name, condition, onDone, opts)[/color]: waits for a condition across frames before continuing
[*] [color=#00FFFF]RunInitStages(name, stages)[/color]: runs a list of init functions one per frame (staged add-on load)
[*] [color=#00FFFF]InitOnFirstShow(sceneObject, fn)[/color]: defers init until a scene is first shown
[*] [color=#00FFFF]GetScheduledJob(name)[/color] / [color=#00FFFF]IsScheduled(name)[/color] / [color=#00FFFF]GetScheduledCount()[/color]: scheduler-state queries
[*] [color=#00FFFF]GetSchedulerBudgetMs()[/color] / [color=#00FFFF]SetSchedulerBudgetMs(ms)[/color]: reads/sets the per-frame time budget
[*] [color=#00FFFF]StepCleanup(passes, onDone)[/color] / [color=#00FFFF]IsStepCleanupRunning()[/color]: the shared stepped garbage-collection job every add-on's cleanup routes through
[/LIST]
[/spoiler]

[b]Settings Helpers[/b] [COLOR="Gray"][i](HELPERS/Settings.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]FormatSettingsSnapshot(settings, fields, onLabel, offLabel)[/color]: formats a settings table for display (Client Info, etc.)
[*] [color=#00FFFF]ResetToDefaults(settings, defaults, excludeKeys, postFn)[/color]: the shared reset-to-defaults loop every add-on's Reset button calls
[/LIST]
[/spoiler]

[center]

[b][COLOR="Orange"]&#9888;&#65039; CONSOLE TESTING NOTES &#9888;&#65039;[/COLOR][/b]
This addon was developed and tested on [b][COLOR="#FF69B4"]PC / Steam Deck[/COLOR][/b] [COLOR="Gray"][i](using Force Console Flow for console testing)[/i][/COLOR].

[SIZE="5"][COLOR="Red"]LICENSE & USAGE[/COLOR][/SIZE]

Copyright &#169; 2026 [COLOR="#FF69B4"]@APHONlC[/COLOR]. All rights reserved. See LICENSE.md

[COLOR="Gray"][i](For permissions or inquiries, contact [COLOR="#FF69B4"]@APHONlC[/COLOR] on ESOUI.)[/i][/COLOR]

[SIZE="5"][COLOR="Red"]Credits[/COLOR][/SIZE]
[b][COLOR="Orange"]I would like to thank the following:[/COLOR][/b]
[COLOR="Gray"][i](For providing resources and their awesome projects)[/i][/COLOR]
[LIST]
[*] [url="https://wiki.esoui.com/Main_Page"][color=#fa9c1b]ESOUI Wiki[/color][/url]
[*] [url="https://forums.elderscrollsonline.com/en/discussion/689370/libharvensaddonsettings-to-libvotan-change-guide"][color=#fa9c1b]ESO Forums[/color][/url]
[*] [url="https://github.com/esoui/esoui"][color=#fa9c1b]@sirinsidiator[/color][/url]
[*] [url="https://github.com/Flat-Badger-1971/eso-api"][color=#fa9c1b]@Flat-Badger-1971[/color][/url]
[*] [url="https://www.esoui.com/downloads/info7.html"][color=#fa9c1b]@sirinsidiator & @Seerah[/color][/url][COLOR="Gray"][i](LibAddonMenu-2.0)[/i][/COLOR]
[*] [url="https://www.esoui.com/downloads/info584.html"][color=#fa9c1b]@Harven & @votan[/color][/url][COLOR="Gray"][i](LibHarvensAddonSettings)[/i][/COLOR]
[*] [url="https://www.esoui.com/downloads/info1624.html"][color=#fa9c1b]@SinusPi, @merlight, @Rhyono, @Dolgubon[/color][/url][COLOR="Gray"][i](Zgoo High Isle)[/i][/COLOR]
[*] [url="https://www.esoui.com/downloads/info2601.html"][color=#fa9c1b]@Baertram[/color][/url][COLOR="Gray"][i](Mer Torchbug - Fixed and Improved "Variable inspector/Scripts/Events/and more")[/i][/COLOR]
[*] [url="https://www.esoui.com/downloads/info970-CirconiansTextureIt.html"][color=#fa9c1b]@Baertram, @IceHeart, @Masteroshi430[/color][/url][COLOR="Gray"][i](Circonians TextureIt)[/i][/COLOR]
[/LIST]

[b][COLOR="Orange"]Testers & Suggestions:[/COLOR][/b]
[LIST]
[*] [color="#FF69B4"]@phlupp89[/color]
[*] [color="#FF69B4"]@Drakius192[/color]
[/LIST]

[b][color=#9CD04C]Check out my other addons/projects:[/color][/b]

[LIST]
[*] [url="https://www.esoui.com/downloads/fileinfo.php?id=4388#info"][color=#fa9c1b]Auto Lua Memory Cleaner[/color][/url]
[*] [url="https://www.esoui.com/downloads/fileinfo.php?id=4116#info"][color=#fa9c1b]Permanent Memento[/color][/url]
[*] [url="https://www.esoui.com/downloads/fileinfo.php?id=3249#info"][color=#fa9c1b]Tamriel Trade Center, HarvestMap, ESO-Hub, ESOUI Auto-Updater[/color][/url] [COLOR="Gray"][i](Linux, macOS, SteamDeck, & Windows)[/i][/COLOR]
[/LIST]

[b][color=#ff3300][SIZE="4"]BUG REPORTS[/SIZE][/color][/b]
If you encounter any issues, please submit a report here
[/center]
