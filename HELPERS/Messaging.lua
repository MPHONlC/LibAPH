-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")

function LibAPH.ShowDialogChained(dialogId, title, body, buttons, delayMs)
	if not ESO_Dialogs[dialogId] then
		ESO_Dialogs[dialogId] = {
			canQueue = true,
			gamepadInfo = { dialogType = GAMEPAD_DIALOGS.BASIC },
			title = { text = title },
			mainText = { text = body },
			buttons = buttons,
		}
	end
	zo_callLater(function()
		if IsConsoleUI() or IsInGamepadPreferredMode() then
			ZO_Dialogs_ShowGamepadDialog(dialogId)
		else
			ZO_Dialogs_ShowDialog(dialogId)
		end
	end, delayMs or 50)
end

function LibAPH.SafeCSA(enabled, title, body, lifespanMs)
	if not enabled then return end
	if body == nil then
		body = title
		title = nil
	end

	local params = CENTER_SCREEN_ANNOUNCE:CreateMessageParams(CSA_CATEGORY_LARGE_TEXT, SOUNDS.NONE)
	if title then
		params:SetText(title, body)
	else
		params:SetText(body)
	end
	params:SetLifespanMS(lifespanMs or 4000)
	CENTER_SCREEN_ANNOUNCE:AddMessageWithParams(params)
end

function LibAPH.CreateChatLogger(shortTag, colorHex)
	local logger = {}
	function logger:Print(message, colorOverride)
		local tagged = "|c" .. (colorOverride or colorHex) .. "[" .. shortTag .. "]|r " .. message
		LibAPH.SendRawChatLine(tagged)
	end
	return logger
end

function LibAPH.SendRawChatLine(msg)
	if IsConsoleUI() then
		d(msg)
	elseif CHAT_SYSTEM then
		CHAT_SYSTEM:AddMessage(msg)
	end
end
