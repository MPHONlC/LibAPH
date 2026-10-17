[SIZE="5"][COLOR="SeaGreen"]LibAPH[/COLOR][/SIZE]
[COLOR="Gray"][i]Helper library for my addons.[/i][/COLOR]

Everyday helper code my add-ons share, kept in one place so none of them has to carry its own copy. Any functions are subject to change.

[SIZE="3"][COLOR="DarkOrchid"]Features[/COLOR][/SIZE]

[LIST]
[*] [b]Window & Theme[/b] - resizable status/scroll-list windows with a shared flat theme
[spoiler]
[b]Window[/b]
[IMG]https://i.postimg.cc/XJ06YMhg/APH-CODERUNNER-DEMOWINDOW.gif[/IMG]

[b]Results Window[/b]
[IMG]https://i.postimg.cc/90JpKTZJ/ALC-BENCHMARK-PC-results-summary.gif[/IMG]
[/spoiler]
[*] [b]Console Support[/b] - right-stick window drag/resize, console text-entry and picker dialogs
[spoiler]
[b]Window moved and resized with the right stick[/b]
[IMG]https://i.postimg.cc/TYdN02gg/ALC-BENCHMARK-CONSOLE-RESIZING-MOVING.gif[/IMG]
[/spoiler]
[*] [b]Context Menu & Search Bar[/b] - multi-level context menu, movable expanding search bar, key-hint icons
[spoiler]
[b]Context menu[/b]
[IMG]https://i.postimg.cc/90V8vCkk/ALC-BENCHMARK-CONSOLE-COMPARE.gif[/IMG]

[b]Search bar position[/b]
[IMG]https://i.postimg.cc/6qmjDGG7/APH-SEARCHBAR-POSITION.gif[/IMG]

[b]Clearing recent searches[/b]
[IMG]https://i.postimg.cc/ZKqz2rX3/APH-SEARCH-DELETE-HISTORY.gif[/IMG]
[/spoiler]
[*] [b]Module Manager[/b] - soft-disables individual add-on files and rebuilds the Client Info file list
[*] [b]Wizard Helper[/b] - schedules a first-run setup wizard, auto-unloads once completed
[*] [b]Messaging & Dialogs[/b] - chained/window-hiding dialogs, safe CSAs, a chat logger
[spoiler]
[b]Dialogs[/b]
[IMG]https://i.postimg.cc/XX6jMGW7/Ao-M-CREATE-DELETE-MOVETO-CATEGORY.gif[/IMG]
[/spoiler]
[*] [b]Player State[/b] - crafting/interacting/menu busy checks, movement and teleport trackers
[*] [b]SavedVariables[/b] - disk-usage reporting, throttled priority saves, unused-SV cleanup
[spoiler]
[b]Save size[/b]
[IMG]https://i.postimg.cc/9X7wkytW/Ao-M-SAVE-SIZE.gif[/IMG]
[/spoiler]
[*] [b]Library & Version Checks[/b] - checks an optional library's version and builds a shared warning message
[spoiler]
[b]Version filters[/b]
[IMG]https://i.postimg.cc/zXYHY30k/Ao-M-VERSION-FILTERS.gif[/IMG]
[/spoiler]
[*] [b]Bug Reporting[/b] - a shared [color=#00FFFF]/xxxbugreport[/color] popup format used by every add-on
[spoiler]
[b]Bug report[/b]
[IMG]https://i.postimg.cc/wjHNL3NM/Ao-M-ERROR-CAPTURE-AND-BUG-REPORT.gif[/IMG]
[/spoiler]
[*] [b]Activity Triggers[/b] - a shared table of "is the player doing X" checks
[*] [b]Scheduler[/b] - spreads work across frames within a time budget, staged add-on init
[*] [b]Memory Cleanup[/b] - the Auto Lua Memory Cleaner cleanup methods for any add-on, shown in Auto Lua Memory Cleaner when it is installed, plus a console hook for the game's Low Add-On memory warning so any add-on can free memory before the game disables add-ons
[spoiler]
[b]Cleaning[/b]
[IMG]https://i.postimg.cc/zBvT1dWS/ALC-CLEANING-VID.gif[/IMG]
[/spoiler]
[*] [b]Saved Records[/b] - packs long number lists for SavedVariables, rounds results and seals them so edits show
[*] [b]Status Line[/b] - a one-line text overlay at the top right of the screen, and label text that is only set when it changes
[*] [b]Text Fitting[/b] - wraps text into lines that fit, shrinks one-line text until it fits, and keeps text above graph lines
[*] [b]Crash Copy[/b] - keeps unfinished work through a crash, disconnect or the game disabling add-ons, and says on the next load what cut it off
[*] [b]Memory Display[/b] - Lua and add-on pool memory at the top right, on PC and console
[*] [b]Game Settings[/b] - FPS cap, and Limit Background FPS / Idle Power Reduction held off while measuring
[*] [b]House Travel[/b] - house destinations, random picks, and jumps that report when they fail
[*] [b]Graphs[/b] - pooled drawing for graphs that redraw often, with axis-step and time-tick helpers
[spoiler]
[b]Timeline on PC[/b]
[IMG]https://i.postimg.cc/Wb1SrWcD/ALC-BENCHMARK-PC-timeline.gif[/IMG]

[b]Timeline on console[/b]
[IMG]https://i.postimg.cc/PxbKb0q9/ALC-BENCHMARK-CONSOLE-TIMELINE.gif[/IMG]
[/spoiler]
[/LIST]

[SIZE="3"][COLOR="DarkOrchid"]Installation[/COLOR][/SIZE]

Extract [b]LibAPH[/b] into your AddOns directory, then declare it as a dependency in your add-on manifest:

[code]## DependsOn: LibAPH>=<version>[/code]

It loads as a global table; no require or manual initialization needed:

[code]LibAPH.GetPlatformString()[/code]

[SIZE="3"][COLOR="DarkOrchid"]Usage[/COLOR][/SIZE]

LibAPH's functions hang off the single global [color=#00FFFF]LibAPH[/color] table, organized internally by folder [COLOR="Gray"][i](UI/, UTILS/, MODULES/, MENU/, HELPERS/, DATA/)[/i][/COLOR]. Call whatever you need directly:

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
[*] [color=#00FFFF]CreateCopyTextBox(opts)[/color]: builds a read-only, selectable copy-text box [COLOR="Gray"][i](used by every bug report popup)[/i][/COLOR]
[*] [color=#00FFFF]OpenPastebin()[/color] / [color=#00FFFF]ConfirmOpenPastebin(win)[/color]: opens [COLOR="Gray"][i](or confirms opening)[/i][/COLOR] an external pastebin link
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
[*] [color=#00FFFF]UseTextSelection(combo)[/color]: shows a dropdown's selected entries as colored text with no background, as in the bug report windows
[*] [color=#00FFFF]CreateStickyFragment(control, scenes)[/color]: keeps a window's own close state sticky across scene changes
[*] [color=#00FFFF]CreateWindowPosition(win, opts)[/color]: saves and restores a movable window's spot, resets it to a default, and runs the console right-stick move
[*] [color=#00FFFF]opts.onMoving(win)[/color] / [color=#00FFFF]opts.watchMs[/color]: optional; runs every watchMs [COLOR="Gray"][i](default 50 ms)[/i][/COLOR] while the window is dragged with the mouse or moved with the right stick
[*] [color=#00FFFF]opts.onMoveStop(win)[/color] / [color=#00FFFF]opts.onMoveEnd(win)[/color]: optional; onMoveStop runs after the new spot is saved, onMoveEnd runs whenever a right-stick move ends, moved or not
[*] [color=#00FFFF]pos:WatchMove()[/color] / [color=#00FFFF]pos:StopWatch()[/color]: start or stop the onMoving loop by hand [COLOR="Gray"][i](WatchMove returns false without onMoving)[/i][/COLOR]
[*] [color=#00FFFF]GetScreenThirdAlign(control)[/color] / [color=#00FFFF]GetScreenThirdAlignAt(centerX, screenWidth)[/color]: returns TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER or TEXT_ALIGN_RIGHT for whichever third of the screen a control's center sits in, so text can hug the nearest edge
[*] [color=#00FFFF]EnableUndoRedo(edit, opts)[/color]: keeps an undo history for an edit box, with typing grouped into steps; call :Undo() from your own button
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

[b]Controller Focus[/b] [COLOR="Gray"][i](UI/PadFocus.lua, UI/Bindings.xml)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]RegisterPadFocus(name, spec)[/color]: one shared controller layer for every add-on window. Returns a handle with [color=#00FFFF]:Request(auto)[/color], [color=#00FFFF]:Release(passOn)[/color], [color=#00FFFF]:IsFocused()[/color] and [color=#00FFFF]:Unregister()[/color]. [color=#00FFFF]spec.canFocus(auto)[/color] says whether the window can act, [color=#00FFFF]spec.onFocus()[/color] and [color=#00FFFF]spec.onBlur(reason)[/color] run when it gets or loses the buttons [COLOR="Gray"][i](reason is "taken" or "released")[/i][/COLOR], [color=#00FFFF]spec.buttons[button]()[/color] handles a press and returns true when it used it, and [color=#00FFFF]spec.release[button]()[/color] runs when that button comes up
[*] [color=#00FFFF]GetPadFocusOwner()[/color]: the name of the window that has the controller, or nil
[/LIST]

For add-on authors: the shared controller layer
[spoiler]
LibAPH has one controller layer that every add-on window can share. Only the window with focus gets the buttons: opening another add-on's window takes focus from yours, closing it hands focus back to the window used before, and a button the focused window doesn't use goes to the game. Dialogs always get their buttons, and a window that is hidden behind a menu lets the menu have them.

Register once with a name and a handler for each button your window uses: [color=#00FFFF]up[/color], [color=#00FFFF]down[/color], [color=#00FFFF]left[/color], [color=#00FFFF]right[/color], [color=#00FFFF]lb[/color], [color=#00FFFF]rb[/color], [color=#00FFFF]lt[/color], [color=#00FFFF]rt[/color], [color=#00FFFF]a[/color], [color=#00FFFF]x[/color], [color=#00FFFF]y[/color], [color=#00FFFF]ls[/color], [color=#00FFFF]rs[/color] or [color=#00FFFF]b[/color]. A handler returns true when it used the press. [color=#00FFFF]release[/color] handlers run when the button comes up, or at once if your window loses focus while it is held, so a hold never keeps running.

[color=#00FFFF]Request(false)[/color] takes focus, for when the player opens your window. [color=#00FFFF]Request(true)[/color] takes it only when no other window has it, for a window that takes control on its own [COLOR="Gray"][i](on console, for example)[/i][/COLOR]. [color=#00FFFF]Release(true)[/color] hands focus back to the window used before; call it when your window closes. [color=#00FFFF]canFocus[/color] must say false while your window can't act. Keep the [color=#00FFFF]LibAPH.RegisterPadFocus[/color] check [COLOR="Gray"][i](or your own layer as a fallback)[/i][/COLOR], so your add-on still works with an older LibAPH.
[code]
local DemoPad = { name = "DemoPad" }

local function IsPad() return IsConsoleUI() or IsInGamepadPreferredMode() end

local function Close()
	DemoPadWindow:SetHidden(true)
	if DemoPad.focus then DemoPad.focus:Release(true) end
end

local function Open()
	DemoPadWindow:SetHidden(false)
	if DemoPad.focus then DemoPad.focus:Request(false) end
end

EVENT_MANAGER:RegisterForEvent(DemoPad.name, EVENT_ADD_ON_LOADED, function(_, addon_name)
	if addon_name ~= DemoPad.name then return end
	EVENT_MANAGER:UnregisterForEvent(DemoPad.name, EVENT_ADD_ON_LOADED)
	if not (LibAPH and LibAPH.RegisterPadFocus) then return end
	DemoPad.focus = LibAPH.RegisterPadFocus(DemoPad.name, {
		canFocus = function() return IsPad() and not DemoPadWindow:IsHidden() end,
		onFocus = function() DemoPadWindowHints:SetHidden(false) end,
		onBlur = function() DemoPadWindowHints:SetHidden(true) end,
		buttons = {
			up = function() return DemoPad.Scroll(-1) end,
			down = function() return DemoPad.Scroll(1) end,
			b = function() Close() return true end,
		},
	})
	SLASH_COMMANDS["/demopad"] = Open
end)
[/code]
[/spoiler]
[/spoiler]

[b]Context Menu[/b] [COLOR="Gray"][i](UI/ContextMenu.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]ShowContextMenu(control, entries, opts)[/color] / [color=#00FFFF]CloseContextMenu()[/color] / [color=#00FFFF]CloseContextMenuLevel()[/color]: opens/closes the multi-level menu; it opens beside opts.window [COLOR="Gray"][i](or control)[/i][/COLOR]: on the side [COLOR="Gray"][i](below, above, left or right)[/i][/COLOR] where the whole menu fits and the screen is most open, else the roomier of below and above, then inside, with opts.gap, opts.belowGap and opts.aboveGap keeping room for hint bars
[*] [color=#00FFFF]PlaceContextMenuBeside(window, opts)[/color]: moves the open menu beside another window in the same order, with the same opts
[*] [color=#00FFFF]IsContextMenuOpen()[/color] / [color=#00FFFF]GetContextMenuDepth()[/color] / [color=#00FFFF]GetContextMenuRowCount(level)[/color] / [color=#00FFFF]GetContextMenuPlacement(level)[/color]: menu-state queries
[*] [color=#00FFFF]RefreshContextMenu()[/color]: rebuilds the currently open menu in place
[*] [color=#00FFFF]ContextMenuRowClicked(row)[/color] / [color=#00FFFF]ContextMenuRowEntered(row)[/color] / [color=#00FFFF]MoveContextMenuFocus(direction)[/color] / [color=#00FFFF]ActivateContextMenuFocus()[/color]: row interaction and console focus movement
[*] [color=#00FFFF]UseContextMenuForCombo(container, build, opts)[/color]: adapts a combo box to open through this context menu
[*] [color=#00FFFF]GroupedChoiceEntries(groups, opts)[/color] / [color=#00FFFF]ShowGroupedChoiceMenu(control, groups, opts)[/color]: a long list of choices split into one scrollable submenu per group [COLOR="Gray"][i](e.g. Default Categories / User Categories)[/i][/COLOR], with the current choice ticked and its group colored
[/LIST]
[/spoiler]

[b]Search Bar & Key Hints[/b] [COLOR="Gray"][i](UI/SearchBar.lua, UI/KeyHints.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]CreateSearchBar(opts)[/color]: a movable search bar that expands into a match palette, with a console route
[*] [color=#00FFFF]CreateKeyHints(parent, name, hints)[/color]: shows the game's key icons, drawn key caps, or controller button hints
[*] [color=#00FFFF]CreatePadHintBar(name, opts)[/color]: a controller hint bar under a window [COLOR="Gray"][i](above it when there's no room)[/i][/COLOR], one line per hint so the button icons never overlap, drawn just above the add-on's own windows [COLOR="Gray"][i](opts.parent, the owner and any opts.above controls or functions)[/i][/COLOR] on their tier and layer, and hidden while opts.parent is hidden; :Show(owner, parts) returns the room it takes below and above, :Hide(), :GetText(), :IsShown()
[/LIST]
[/spoiler]

[b]Status Icons[/b] [COLOR="Gray"][i](UI/StatusIcons.lua)[/i][/COLOR]
[spoiler]
[b]Status icons[/b]
[IMG]https://i.postimg.cc/13FkxPcG/AOM-CONSOLE-ICONS.gif[/IMG]

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
[*] [color=#00FFFF]CallOptional(warnedTable, tag, unavailableNote, fn, label, ...)[/color]: calls a possibly-nil [COLOR="Gray"][i](module-disabled)[/i][/COLOR] function, warning once if it's missing
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
[*] [color=#00FFFF]SetSlashCommandsShown(names, shown)[/color]: adds or removes slash commands and clears the chat autocomplete, so a command only exists while it can act
[*] [color=#00FFFF]IsSafeToReloadUI()[/color] / [color=#00FFFF]ReloadUIWhenSafe(namespace, opts)[/color]: defers a ReloadUI() until it's safe to do [COLOR="Gray"][i](not mid-combat, etc.)[/i][/COLOR]
[/LIST]
[/spoiler]

[b]Player State[/b] [COLOR="Gray"][i](HELPERS/PlayerState.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]IsPlayerCrafting()[/color] / [color=#00FFFF]IsPlayerInteracting()[/color] / [color=#00FFFF]IsPlayerInMenu()[/color]: quick busy-state checks
[*] [color=#00FFFF]CheckBusyReason(checks)[/color]: runs a list of busy checks and returns which one [COLOR="Gray"][i](if any)[/i][/COLOR] is true
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
[*] [color=#00FFFF]BuildLibraryWarning(templates, fullName, shortName, ver, enabled, requiredVer, consequence)[/color] / [color=#00FFFF]BuildLibraryWarningFromData(...)[/color]: builds the shared missing/disabled/outdated-library warning text [COLOR="Gray"][i](dialog + CSA + chat)[/i][/COLOR]
[*] [color=#00FFFF]CheckSelfVersion(store, currentVersion, opts)[/color]: detects if this add-on's own AddOnVersion changed since last load
[*] [color=#00FFFF]CheckAddonVersions(knownVersions, warnedTable, onMismatch)[/color]: compares known dependent add-ons' versions against a reference table
[/LIST]
[/spoiler]

[b]Bug Reporting[/b] [COLOR="Gray"][i](UTILS/BugReport.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]SetAddonMetadataProvider(provider)[/color]: registers how to fetch an add-on's own metadata for reports
[*] [color=#00FFFF]CreateAddonBugReporter(opts)[/color]: builds a ready-to-use /xxxbugreport popup for one add-on
[*] [color=#00FFFF]/libaphbugreport[/color]: opens LibAPH's own bug report popup [COLOR="Gray"][i](PC)[/i][/COLOR]
[*] [color=#00FFFF]GetLiveApiLine()[/color]: the current live API version, formatted
[*] [color=#00FFFF]BuildEnabledAddonsReport()[/color] / [color=#00FFFF]BuildEnvironmentReport()[/color]: lists every enabled add-on/library with Version, AddOnVersion, API
[*] [color=#00FFFF]DefaultBugReportSections(hasErrors)[/color] / [color=#00FFFF]BuildBugReportSections(opts)[/color] / [color=#00FFFF]BuildBugReportText(opts)[/color] / [color=#00FFFF]RenderBugReport(sections, enabled)[/color]: assembles the final report text
[*] [color=#00FFFF]FitBugReportText(text)[/color]: trims a report to fit the SavedVariables character limit
[/LIST]
[/spoiler]

[b]Dependency Registration[/b] [COLOR="Gray"][i](UTILS/DependencyRegistry.lua)[/i][/COLOR]
[spoiler]
[b]Used as a dependency[/b]
[IMG]https://i.postimg.cc/9fXFcJXt/LIBAPH-DEPENDENCY-REGISTRATION.png[/IMG]

[LIST]
[*] [color=#00FFFF]RegisterAddonDependencies(addonName, requiredLibs, optionalLibs)[/color]: declares an add-on's dependencies for the Client Info panel
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
[b]Switching dependencies on from an icon[/b]
[IMG]https://i.postimg.cc/13FkxPcG/AOM-CONSOLE-ICONS.gif[/IMG]

[LIST]
[*] [color=#00FFFF]EnableRequiredDependencies(index, setEnabled, onEnabled)[/color] / [color=#00FFFF]EnableAddonWithDependencies(index, setEnabled, onEnabled)[/color]: enables an add-on along with its dependencies
[*] [color=#00FFFF]GetPlatformString()[/color] / [color=#00FFFF]GetPlatformServiceName()[/color]: platform and storefront detection
[*] [color=#00FFFF]GetKeybindMarkup(action)[/color]: the bound key for an action as inline icon markup, or an empty string when nothing is bound
[*] [color=#00FFFF]IsGameScreenShown()[/color]: true only while the base game scene is fully shown [COLOR="Gray"][i](no menu, no transition)[/i][/COLOR]
[*] [color=#00FFFF]IsDialogOnScreen()[/color]: true only while a dialog is on screen, so keys don't give way to one that already closed
[*] [color=#00FFFF]ShowMenuScene(scene)[/color]: opens a main-menu scene through the keyboard main menu when it knows the scene, otherwise through SCENE_MANAGER
[*] [color=#00FFFF]AfterSceneShown(scene, fn)[/color]: runs fn once scene is shown, checking every 100 ms for up to a second
[*] [color=#00FFFF]IsAddonActiveAndRunning(addonName)[/color] / [color=#00FFFF]IsLibraryAddonByName(am, addonName)[/color]: add-on state queries
[/LIST]
[/spoiler]

[b]Error Capture[/b] [COLOR="Gray"][i](HELPERS/ErrorCapture.lua)[/i][/COLOR]
[spoiler]
[b]Error capture on console[/b]
[IMG]https://i.postimg.cc/fygGsRrv/AOM-CONSOLE-ERRORS-SLOW.gif[/IMG]

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
[*] [color=#00FFFF]StripColors(text, fallback)[/color]: strips color markup from a string
[*] [color=#00FFFF]PickDiskUnit(usageMB)[/color] / [color=#00FFFF]FormatSizeMB(sizeMB, decimals, subMegabyteUnit)[/color] / [color=#00FFFF]FormatDiskUsageMB(usageMB, short)[/color] / [color=#00FFFF]FormatDiskUsageRangeMB(usedMB, capacityMB)[/color] / [color=#00FFFF]FormatMemoryMB(sizeMB)[/color]: disk/memory-size formatting
[*] [color=#00FFFF]FormatInstallDateLine(installedDate, todayStr)[/color] / [color=#00FFFF]GetTodayDateString()[/color]: install-date formatting
[/LIST]
[/spoiler]

[b]Profile Store[/b] [COLOR="Gray"][i](UTILS/ProfileStore.lua)[/i][/COLOR]
[spoiler]
[b]Profiles[/b]
[IMG]https://i.postimg.cc/hj2w8GcS/AOM-DISABLE-UNUSED-CONSOLE.gif[/IMG]

[LIST]
[*] [color=#00FFFF]CreateProfileStore(opts)[/color]: a saved-profile manager [COLOR="Gray"][i](create/switch/delete named settings profiles)[/i][/COLOR]; opts.perCharacter keeps a separate active profile for each character while the profiles stay account-wide
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

[b]Saved Records[/b] [COLOR="Gray"][i](UTILS/SavedRecords.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]PackNumbers(list, scale)[/color] / [color=#00FFFF]UnpackNumbers(packed, scale)[/color]: packs a list of numbers [COLOR="Gray"][i](or false gaps)[/i][/COLOR] into short text, several times smaller than the list, split into chunks under the 2,000 character SavedVariables limit; scale sets the decimals kept [COLOR="Gray"][i](10 keeps one)[/i][/COLOR]
[*] [color=#00FFFF]RoundNumbers(t, decimals)[/color]: rounds every number in a table and its subtables [COLOR="Gray"][i](default 2 decimals)[/i][/COLOR]
[*] [color=#00FFFF]CreateSeal(opts)[/color]: returns a sealer for finished results, or nil when opts.salt is missing or already taken; each salt can be claimed once per session, so create it while your add-on loads and keep it in a local. opts.skip: top-level keys left out of the seal, such as a name the player may change; opts.decimals [COLOR="Gray"][i](default 2)[/i][/COLOR]: Seal rounds every number to this many decimals first, and any number that is not exactly one of those values counts as edited, so even a change far smaller than the last decimal shows; opts.verify(record): your own check that the numbers agree with each other, false means edited
[*] [color=#00FFFF]sealer.Seal(record)[/color]: writes record.seal, a 64-bit checksum of the record, the account and the server, plus record.seal_account and record.seal_world; it never replaces a seal that is already there
[*] [color=#00FFFF]sealer.Check(record)[/color]: returns "sealed", "changed", "not_sealed", or "other_player" / "other_server" when the record is intact but was sealed by another account or on another server [COLOR="Gray"][i](named in record.seal_account and record.seal_world)[/i][/COLOR]
[*] The seal shows edits made to the saved file; anyone who reads your code can still make a matching seal, so it is not proof
[/LIST]
[/spoiler]

[b]Text Fitting[/b] [COLOR="Gray"][i](UI/FitText.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]FitButtonText(button, opts)[/color]: steps a button's font down until its text fits the button
[*] [color=#00FFFF]FitButtonRow(container, buttons, opts)[/color]: shrinks a row of buttons to fit its container, keybind labels together, and refits when the container resizes
[*] [color=#00FFFF]WrapText(label, text, width, opts)[/color]: returns the text broken into lines that fit width at the label's font, the line count, and whether a single word is still too wide; lists break between items [COLOR="Gray"][i](at ", ")[/i][/COLOR] before words; colour codes don't count toward the width
[*] [color=#00FFFF]FitLabelText(label, text, opts)[/color]: sets a one-line label's text and steps its font down [COLOR="Gray"][i](opts.font, a face|size|effect string or a named font, down to opts.minSize, default 8)[/i][/COLOR] until it fits opts.width or the label's width; returns false when even the smallest size can't fit it
[*] [color=#00FFFF]RaiseLabel(label, opts)[/color]: draws a label above graph lines and markers [COLOR="Gray"][i](opts.level, default 20)[/i][/COLOR] and, unless opts.backdrop is false, puts a backing [COLOR="Gray"][i](opts.color)[/i][/COLOR] just under it; the label keeps its own draw layer unless opts.layer is given
[/LIST]
[/spoiler]

[b]Status Line[/b] [COLOR="Gray"][i](UI/StatusLine.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]SettingsMenuEntries(controls, opts)[/color]: turns a LibAddonMenu-2.0 options table into context menu entries, so the same settings can sit in an add-on's own menu: checkboxes stay checkboxes, dropdowns open their choices with the current one green, sliders ask for a number (opts.askText(spec), opts.rangeText) snapped to their step and range, buttons run, dangerous ones through opts.confirm(id, title, body, onConfirm), submenus nest, greyed-out controls stay greyed out, and descriptions are left out
[*] [color=#00FFFF]CreateStatusLine(name, opts)[/color]: a one-line text overlay at the top right of the screen [COLOR="Gray"][i](lower on console, clear of the game's memory display)[/i][/COLOR]; line:Set(text), line:Hide(), line:GetText() [COLOR="Gray"][i](nil while hidden)[/i][/COLOR]; opts.font, opts.width, opts.align, opts.offsetX / opts.offsetY, opts.consoleOffsetX / opts.consoleOffsetY, opts.point, and opts.relativeTo [COLOR="Gray"][i](a control or its global name)[/i][/COLOR] with opts.relativePoint to place it under another control, such as ZO_CompassFrame; opts.stack [COLOR="Gray"][i](a group name, such as "compass")[/i][/COLOR] with opts.order stacks lines from several add-ons one under another in that order instead of overlapping, and a hidden one gives its place to the next
[*] [color=#00FFFF]SetTextIfChanged(label, text)[/color]: sets a label's text only when it differs from what this function last set, so text redrawn every frame or second makes no work when nothing changed
[/LIST]
[/spoiler]

[b]Memory Display[/b] [COLOR="Gray"][i](UI/MemoryDisplay.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]SetMemoryDisplay(owner, on)[/color]: shows Lua and add-on pool memory at the top right while any add-on asks for it [COLOR="Gray"][i]("Lua N MB Pool N MB")[/i][/COLOR]. On PC it is LibAPH's own label, updated every second; on console it turns on the game's add-on memory display, moves it to the top right and adds Lua, and puts it back as the player had it once no add-on wants it. Returns whether it is shown
[*] [color=#00FFFF]IsMemoryDisplayShown()[/color] / [color=#00FFFF]GetMemoryDisplayText()[/color]: whether it is shown, and its text right now
[/LIST]
[/spoiler]

[b]Game Settings[/b] [COLOR="Gray"][i](UTILS/GameSettings.lua, UTILS/Platform.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]GetFpsCap()[/color] / [color=#00FFFF]SetFpsCap(fps)[/color]: the frame-rate cap [COLOR="Gray"][i](nil when uncapped)[/i][/COLOR]. SetFpsCap takes FPS_CAP_MIN to FPS_CAP_MAX [COLOR="Gray"][i](10 to 1000)[/i][/COLOR], or nil / "uncapped" to remove the cap, and returns false, "range" or false, "console" when it can't [COLOR="Gray"][i](PC only)[/i][/COLOR]
[*] [color=#00FFFF]HoldGameSettings()[/color] / [color=#00FFFF]ReholdGameSettings(held)[/color] / [color=#00FFFF]ReleaseGameSettings(held)[/color] / [color=#00FFFF]GetHeldGameSettingNames(held)[/color]: switches Limit Background FPS and Idle Power Reduction off for a measurement without saving the change, again after a reload, back afterwards, and names what was held [COLOR="Gray"][i](PC only)[/i][/COLOR]
[*] [color=#00FFFF]CountRunningAddOns()[/color]: { on, total, libs_on, libs_total }, counting enabled add-ons that are out of date as running
[/LIST]
[/spoiler]

[b]House Travel[/b] [COLOR="Gray"][i](UTILS/HouseTravel.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]GetHouseDestinations()[/color]: every house collectible as { house, outside, owned, zone, text }: inside and outside for houses you own, a preview for the others
[*] [color=#00FFFF]PickHouseDestination(opts)[/color]: a random destination, skipping opts.skipZones [COLOR="Gray"][i](a set of zone ids)[/i][/COLOR], opts.avoidZone and opts.avoidHouse; nil when none is left
[*] [color=#00FFFF]RequestHouseJump(house, outside, opts)[/color]: jumps after opts.delayMs [COLOR="Gray"][i](1000)[/i][/COLOR] and calls opts.onFailed() once when the jump fails, can't start from here, or no loading screen begins within opts.timeoutMs [COLOR="Gray"][i](20000)[/i][/COLOR]; opts.isLive() lets the caller drop it quietly. Returns a handle with Cancel() and IsLive()
[*] [color=#00FFFF]GetCurrentPlace()[/color] / [color=#00FFFF]IsInOwnedHouse()[/color]: { zone, house } where you are, and whether it is a house you own
[/LIST]
[/spoiler]

[b]Crash Copy[/b] [COLOR="Gray"][i](UTILS/CrashCopy.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]CreateCrashCopy(opts)[/color]: keeps a copy of unfinished work in your SavedVariables so it survives a crash, a disconnect or the game disabling add-ons. opts.addonName, opts.store() returning the saved table, and opts.key naming the field [COLOR="Gray"][i]("crash_copy" by default)[/i][/COLOR]; opts.active() says whether work is running, opts.expectedReload() marks your own planned reloads, opts.onCause(cause) runs when a logout, quit or reload is noted. copy:Keep(data), copy:Update() [COLOR="Gray"][i](stamps the time and add-on memory, and near the memory limit asks the game to save, once per 10 s)[/i][/COLOR], copy:SaveNow(), copy:Get(), copy:Reset(), copy:Clear(), and on the next load copy:Take() returns the data and why it was cut off
[*] [color=#00FFFF]GetCrashReason(data, opts)[/color]: { cause, short }: cause is logout, quit, reload, out_of_memory [COLOR="Gray"][i](opts.lowMemory: after the game's Low Add-On memory warning)[/i][/COLOR], likely_out_of_memory [COLOR="Gray"][i](the add-on pool was near its limit)[/i][/COLOR] or unknown; short is the few words to show [COLOR="Gray"][i]("logged out", "game closed", "reloaded", "out of memory", "cut off")[/i][/COLOR]
[/LIST]
[/spoiler]

[b]Graphs[/b] [COLOR="Gray"][i](UI/Graph.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]CreateGraphCanvas(area, opts)[/color]: pooled rectangles and text on a control, for graphs that redraw often: canvas:Begin(), canvas:Rect(kind, x, y, w, h, color), canvas:Text(kind, text, color), canvas:Line(plot, values, low, high, colorOf, thickness) [COLOR="Gray"][i](a stepped line with risers and a gap where a value is false)[/i][/COLOR], and canvas:Finish() hides whatever the redraw did not use. opts.levels sets the draw level per kind [COLOR="Gray"][i](text above everything)[/i][/COLOR], with opts.font() and opts.textColor
[*] [color=#00FFFF]NiceGraphStep(range)[/color] / [color=#00FFFF]GraphTickStep(span, target, steps)[/color] / [color=#00FFFF]FormatClock(seconds)[/color]: round axis steps, time-tick spacing for about target labels, and m:ss times
[/LIST]
[/spoiler]

[b]Scheduler[/b] [COLOR="Gray"][i](UTILS/Scheduler.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]Schedule(name, step, opts)[/color] / [color=#00FFFF]RunOrSchedule(name, step, opts)[/color]: spreads a function's work across frames within a time budget
[*] [color=#00FFFF]ScheduleLoop(name, items, body, opts)[/color]: schedules a per-item loop across frames
[*] [color=#00FFFF]ScheduleWait(name, condition, onDone, opts)[/color]: waits for a condition across frames before continuing
[*] [color=#00FFFF]RunInitStages(name, stages)[/color]: runs a list of init functions one per frame [COLOR="Gray"][i](staged add-on load)[/i][/COLOR]
[*] [color=#00FFFF]InitOnFirstShow(sceneObject, fn)[/color]: defers init until a scene is first shown
[*] [color=#00FFFF]GetScheduledJob(name)[/color] / [color=#00FFFF]IsScheduled(name)[/color] / [color=#00FFFF]GetScheduledCount()[/color]: scheduler-state queries
[*] [color=#00FFFF]GetSchedulerBudgetMs()[/color] / [color=#00FFFF]SetSchedulerBudgetMs(ms)[/color]: reads/sets the per-frame time budget; it shrinks to what is left of the game's per-frame add-on CPU limit [COLOR="Gray"][i](1000 ms on console)[/i][/COLOR] and drops to 1 ms while the add-on memory pool is above 95% of its cap
[*] [color=#00FFFF]StepTimeLeftMs()[/color]: inside a scheduled step, how many ms the step may still use this frame; check it in data-sized loops and return false to carry on next frame
[*] [color=#00FFFF]StepCleanup(passes, onDone)[/color] / [color=#00FFFF]IsStepCleanupRunning()[/color]: the shared stepped garbage-collection job every add-on's cleanup routes through
[/LIST]
[/spoiler]

[b]Memory Cleanup[/b] [COLOR="Gray"][i](UTILS/MemoryCleanup.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]RunCleanup(opts)[/color]: runs one garbage collection with the Auto Lua Memory Cleaner methods: opts.method is "automatic" [COLOR="Gray"][i](default)[/i][/COLOR], "background", "aggressive", "deep" or "vanilla" [COLOR="Gray"][i](runs only with opts.force)[/i][/COLOR], opts.source names your add-on and [color=#00FFFF]opts.onDone(result)[/color] gets the result. A call while another add-on's cleanup is running joins it instead of cleaning twice. Returns true, method or false, reason
[*] [color=#00FFFF]GetCleanupMethods()[/color] / [color=#00FFFF]PickCleanupMethod(force, reason)[/color]: the method names, and what Automatic would pick right now
[*] [color=#00FFFF]RegisterCleanupListener(name, fn)[/color] / [color=#00FFFF]UnregisterCleanupListener(name)[/color]: calls [color=#00FFFF]fn(result)[/color] after every cleanup from any add-on; result has source, method, picked, reason [COLOR="Gray"][i](what the caller passed, such as "lowmem")[/i][/COLOR] and beforeLua/afterLua/freedLua, beforePool/afterPool/freedPool in MB
[*] [color=#00FFFF]IsCleanupRunning()[/color] / [color=#00FFFF]GetLastCleanup()[/color] / [color=#00FFFF]GetMemoryUsageMB()[/color]: state queries; the last returns Lua and add-on pool MB
[*] [color=#00FFFF]RegisterLowMemoryCallback(name, fn)[/color] / [color=#00FFFF]UnregisterLowMemoryCallback(name)[/color]: console only [COLOR="Gray"][i](returns false on PC)[/i][/COLOR]. Calls [color=#00FFFF]fn(used, limit)[/color] when the game shows its "Low Add-On memory: 70 MB/100 MB" warning, so your add-on can drop caches or call [color=#00FFFF]StartLowMemoryRescue({ source = name })[/color] before the game disables every add-on. LibAPH listens once for all add-ons
[*] [color=#00FFFF]GetAddOnMemoryLimitMB()[/color] / [color=#00FFFF]IsAddOnMemoryLow(share)[/color]: the add-on memory in use and its limit in MB [COLOR="Gray"][i](nil on PC, which has no limit)[/i][/COLOR], and whether it is at or above share of the limit [COLOR="Gray"][i](0.7 by default, where the game warns)[/i][/COLOR]
[*] [color=#00FFFF]StartLowMemoryRescue(opts)[/color] / [color=#00FFFF]StopLowMemoryRescue(source)[/color] / [color=#00FFFF]IsLowMemoryRescueRunning(source)[/color]: console only [COLOR="Gray"][i](returns false, "no limit" on PC)[/i][/COLOR]. Your add-on starts it, usually from [color=#00FFFF]RegisterLowMemoryCallback[/color]; LibAPH never starts it by itself. It cleans in small steps every frame within the add-on CPU time the game leaves free [COLOR="Gray"][i](about 2 ms, up to 6 ms near the limit)[/i][/COLOR] until add-on memory is back under 65% of the limit, adds a Deep Clean at most every 5 seconds above 80% when the steps fall behind, and keeps going in combat. opts.source names your add-on, [color=#00FFFF]opts.canRun()[/color] returning false takes your add-on out of it, [color=#00FFFF]opts.onPass(result)[/color] gets each pass [COLOR="Gray"][i](the cleanup result fields, with method "rescue" or "deep" and reason "lowmem")[/i][/COLOR] and [color=#00FFFF]opts.onDone(reached, totals)[/color] gets whether memory got back under 65% and freedLua, freedPool, passes, deepCleans, tookMs. A second add-on joins the running rescue instead of starting another. Returns true, "started", "joined" or "running", or false, reason
[*] [color=#00FFFF]GetLowMemoryRescueLines(limit)[/color]: where the game turns add-ons off [COLOR="Gray"][i](90%)[/i][/COLOR], where the rescue starts [COLOR="Gray"][i](70%)[/i][/COLOR], stops [COLOR="Gray"][i](65%)[/i][/COLOR] and adds Deep Cleans [COLOR="Gray"][i](80%)[/i][/COLOR], in MB
[*] [color=#00FFFF]ReadLowAddOnMemoryWarning(message)[/color]: used, limit when a UI error message is that warning, in any game language; nil for anything else
[/LIST]
When Auto Lua Memory Cleaner is installed, every cleanup run through [color=#00FFFF]RunCleanup[/color] shows in its window, chat logs and announcements.

Full Memory Cleanup example:
[spoiler]
[color=#00FFFF]/democlean[/color] shows the status; [color=#00FFFF]/democlean automatic[/color], background, aggressive, deep or vanilla runs that method. Every other add-on's cleanup shows in chat too.
[code]
local DemoCleanup = { name = "DemoCleanup" }
local LUA_LIMIT_MB = 300
local CHECK_EVERY_MS = 2000
local chat = LibAPH.CreateChatLogger("DemoCleanup", "00FFFF")

local function Describe(result)
	local how = result.picked and ("automatic, picked " .. result.picked) or result.method
	return string.format("%s by %s: Lua %.1f MB (-%.1f), pool %.1f MB (-%.1f)",
		how, result.source, result.afterLua, result.freedLua, result.afterPool, result.freedPool)
end

local function BusyChecks()
	return {
		{ reasonKey = "in combat", delayMs = 5000, check = function() return IsUnitInCombat("player") end },
		{ reasonKey = "dead", delayMs = 5000, check = function() return IsUnitDead("player") end },
		{ reasonKey = "crafting", delayMs = 3000, check = LibAPH.IsPlayerCrafting },
		{ reasonKey = "talking to an NPC", delayMs = 3000, check = LibAPH.IsPlayerInteracting },
		{ reasonKey = "travelling", delayMs = 3000, check = function() return DemoCleanup.teleport:IsTeleporting() end },
	}
end

function DemoCleanup.PickMethod(lua_mb)
	if LibAPH.IsPlayerInMenu() then return "deep" end
	if DemoCleanup.movement:IsMoving() then return "background" end
	if lua_mb >= LUA_LIMIT_MB * 1.5 then return "aggressive" end
	return "automatic"
end

function DemoCleanup.Run(method, force)
	local started, how = LibAPH.RunCleanup({
		method = method,
		source = DemoCleanup.name,
		force = force,
		onDone = function(result)
			DemoCleanup.saved.freedMB = DemoCleanup.saved.freedMB + result.freedLua
		end,
	})
	if not started and how == "vanilla" then
		chat:Print("Vanilla: nothing to clean yet, the game handles it.")
	elseif not started then
		chat:Print("Unknown method. Use one of: " .. table.concat(LibAPH.GetCleanupMethods(), ", "))
	elseif how == "joined" then
		chat:Print("Another add-on is already cleaning; joined it.")
	end
	return started
end

function DemoCleanup.Check()
	DemoCleanup.movement:Update()
	if GetGameTimeMilliseconds() < DemoCleanup.waitUntil or LibAPH.IsCleanupRunning() then return end
	local lua_mb = LibAPH.GetMemoryUsageMB()
	if lua_mb < LUA_LIMIT_MB then return end
	local busy, reason, delay_ms = LibAPH.CheckBusyReason(DemoCleanup.busy)
	if busy then
		DemoCleanup.waitReason = reason
		DemoCleanup.waitUntil = GetGameTimeMilliseconds() + delay_ms
		return
	end
	DemoCleanup.waitReason = nil
	DemoCleanup.Run(DemoCleanup.PickMethod(lua_mb))
end

function DemoCleanup.Status()
	local lua_mb, pool_mb = LibAPH.GetMemoryUsageMB()
	chat:Print(string.format("Lua %.1f MB, pool %.1f MB, freed this game session %.1f MB", lua_mb, pool_mb, DemoCleanup.saved.freedMB))
	chat:Print("Automatic would pick: " .. LibAPH.PickCleanupMethod(true))
	if DemoCleanup.waitReason then chat:Print("Waiting: " .. DemoCleanup.waitReason) end
	local last = LibAPH.GetLastCleanup()
	if last then chat:Print("Last cleanup: " .. Describe(last)) end
end

local function Init()
	DemoCleanup.saved = ZO_SavedVars:NewAccountWide("DemoCleanupSaved", 1, GetWorldName() or "Default", { freedMB = 0, clientStart = 0 })
	if not LibAPH.IsSameClientSession(DemoCleanup.saved.clientStart) then
		DemoCleanup.saved.freedMB = 0
		DemoCleanup.saved.clientStart = LibAPH.GetClientStartTime()
	end
	DemoCleanup.movement = LibAPH.CreateMovementTracker({ throttleMs = 500, threshold = 0.5 })
	DemoCleanup.teleport = LibAPH.CreateTeleportTracker({ staleMs = 5000 })
	DemoCleanup.busy = BusyChecks()
	DemoCleanup.waitUntil = 0

	LibAPH.RegisterCleanupListener(DemoCleanup.name, function(result)
		chat:Print(Describe(result))
	end)

	SLASH_COMMANDS["/democlean"] = function(args)
		local method = zo_strlower(zo_strtrim(args or ""))
		if method == "" then return DemoCleanup.Status() end
		DemoCleanup.Run(method, true)
	end

	LibAPH.RunWhenPlayerActivated(DemoCleanup.name .. "_Start", function()
		EVENT_MANAGER:RegisterForUpdate(DemoCleanup.name .. "_Watch", CHECK_EVERY_MS, DemoCleanup.Check)
	end)
end

EVENT_MANAGER:RegisterForEvent(DemoCleanup.name, EVENT_ADD_ON_LOADED, function(_, addon_name)
	if addon_name ~= DemoCleanup.name then return end
	EVENT_MANAGER:UnregisterForEvent(DemoCleanup.name, EVENT_ADD_ON_LOADED)
	Init()
end)
[/code]
[/spoiler]

For add-on authors: the low-memory rescue on console
[spoiler]
On console the game disables every add-on when add-on memory reaches about 90% of its limit. Register one callback at load. When the game warns, drop what your add-on can rebuild and start the shared rescue. Don't call [color=#00FFFF]collectgarbage("collect")[/color] yourself: when several add-ons each run a full collect on the same warning, their freezes stack. If another add-on [COLOR="Gray"][i](such as Auto Lua Memory Cleaner)[/i][/COLOR] already started the rescue, your call joins it, so there is still one rescue with one CPU budget.

Declare [color=#00FFFF]## OptionalDependsOn: LibAPH[/color] and keep the [color=#00FFFF]LibAPH.RegisterLowMemoryCallback[/color] check, so your add-on still loads without LibAPH or with an older version. On PC nothing happens, since PC has no add-on memory limit.
[code]
local DemoRescue = { name = "DemoRescue", cache = {} }

local function OnLowMemory(used, limit)
	ZO_ClearTable(DemoRescue.cache)
	LibAPH.StartLowMemoryRescue({
		source = DemoRescue.name,
		used = used,
		cap = limit,
		onDone = function(reached, totals)
			DemoRescue.chat:Print(string.format("Freed %.1f MB of add-on memory in %d passes", totals.freedPool, totals.passes))
		end,
	})
end

EVENT_MANAGER:RegisterForEvent(DemoRescue.name, EVENT_ADD_ON_LOADED, function(_, addon_name)
	if addon_name ~= DemoRescue.name then return end
	EVENT_MANAGER:UnregisterForEvent(DemoRescue.name, EVENT_ADD_ON_LOADED)
	if LibAPH and LibAPH.RegisterLowMemoryCallback then
		DemoRescue.chat = LibAPH.CreateChatLogger(DemoRescue.name, "00FFFF")
		LibAPH.RegisterLowMemoryCallback(DemoRescue.name, OnLowMemory)
	end
end)
[/code]
Only clear data you can rebuild later, such as lookup tables, search indexes or tooltip caches, never saved variables. Clearing a table turns its contents into garbage, and the rescue frees it. Pass [color=#00FFFF]canRun[/color] to step out of the rescue while your add-on is busy; the rescue keeps going for the other add-ons.
[/spoiler]
[/spoiler]

[b]Settings Helpers[/b] [COLOR="Gray"][i](HELPERS/Settings.lua)[/i][/COLOR]
[spoiler]
[LIST]
[*] [color=#00FFFF]FormatSettingsSnapshot(settings, fields, onLabel, offLabel)[/color]: formats a settings table for display [COLOR="Gray"][i](Client Info, etc.)[/i][/COLOR]
[*] [color=#00FFFF]ResetToDefaults(settings, defaults, excludeKeys, postFn)[/color]: the shared reset-to-defaults loop every add-on's Reset button calls
[/LIST]
[/spoiler]

[center]

[b][COLOR="Orange"]⚠️ CONSOLE TESTING NOTES ⚠️[/COLOR][/b]
This addon was developed and tested on [b][COLOR="#FF69B4"]PC / Steam Deck[/COLOR][/b] [COLOR="Gray"][i](using Force Console Flow for console testing)[/i][/COLOR].

[SIZE="5"][COLOR="Red"]LICENSE & USAGE[/COLOR][/SIZE]

Copyright © 2026 [COLOR="#FF69B4"]@APHONlC[/COLOR]. All rights reserved. See LICENSE.md

[COLOR="Gray"][i](For permissions or inquiries, contact [COLOR="#FF69B4"]@APHONlC[/COLOR] on ESOUI.)[/i][/COLOR]

[SIZE="5"][COLOR="Red"]Credits[/COLOR][/SIZE]
[b][COLOR="Orange"]I would like to thank the following:[/COLOR][/b]
[COLOR="Gray"][i](For providing resources and their awesome projects)[/i][/COLOR]
[url="https://wiki.esoui.com/Main_Page"][color=#fa9c1b]ESOUI Wiki[/color][/url]
[url="https://forums.elderscrollsonline.com/en/discussion/689370/libharvensaddonsettings-to-libvotan-change-guide"][color=#fa9c1b]ESO Forums[/color][/url]
[url="https://github.com/esoui/esoui"][color=#fa9c1b]@sirinsidiator[/color][/url]
[url="https://www.esoui.com/downloads/info4074-ESOluaAPIintellisenseforVisualStudioCode.html"][color=#fa9c1b]@Flat-Badger-1971[/color][/url]
[url="https://www.esoui.com/downloads/info7.html"][color=#fa9c1b]@sirinsidiator & @Seerah[/color][/url][COLOR="Gray"][i](LibAddonMenu-2.0)[/i][/COLOR]
[url="https://www.esoui.com/downloads/info584.html"][color=#fa9c1b]@Harven & @votan[/color][/url][COLOR="Gray"][i](LibHarvensAddonSettings)[/i][/COLOR]
[url="https://www.esoui.com/downloads/info1624.html"][color=#fa9c1b]@SinusPi, @merlight, @Rhyono, @Dolgubon[/color][/url][COLOR="Gray"][i](Zgoo High Isle)[/i][/COLOR]
[url="https://www.esoui.com/downloads/info2601.html"][color=#fa9c1b]@Baertram[/color][/url][COLOR="Gray"][i](Mer Torchbug - Fixed and Improved "Variable inspector/Scripts/Events/and more")[/i][/COLOR]
[url="https://www.esoui.com/downloads/info970-CirconiansTextureIt.html"][color=#fa9c1b]@Baertram, @IceHeart, @Masteroshi430[/color][/url][COLOR="Gray"][i](Circonians TextureIt)[/i][/COLOR]

[b][COLOR="Orange"]Testers & Suggestions:[/COLOR][/b]
[color="#FF69B4"]@phlupp89[/color]
[color="#FF69B4"]@Drakius192[/color]

[b][color=#9CD04C]Check out my other addons/projects:[/color][/b]

[url="https://www.esoui.com/downloads/fileinfo.php?id=4388#info"][color=#fa9c1b]Auto Lua Memory Cleaner[/color][/url]
[url="https://www.esoui.com/downloads/fileinfo.php?id=4116#info"][color=#fa9c1b]Permanent Memento[/color][/url]
[url="https://www.esoui.com/downloads/fileinfo.php?id=3249#info"][color=#fa9c1b]Tamriel Trade Center, HarvestMap, ESO-Hub, ESOUI Auto-Updater[/color][/url] [COLOR="Gray"][i](Linux, macOS, SteamDeck, & Windows)[/i][/COLOR]

[b][color=#ff3300][SIZE="4"]BUG REPORTS[/SIZE][/color][/b]
If you encounter any issues, please submit a report here
[/center]
