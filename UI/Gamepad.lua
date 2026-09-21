-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")

local GetGameTimeMilliseconds = GetGameTimeMilliseconds
local ZO_Gamepad_GetRightStickEasedX = ZO_Gamepad_GetRightStickEasedX
local ZO_Gamepad_GetRightStickEasedY = ZO_Gamepad_GetRightStickEasedY
local SetGamepadRightStickConsumedByUI = SetGamepadRightStickConsumedByUI
local GuiRoot = GuiRoot
local LibAPH = LibAPH

function LibAPH.CreateGamepadMover(target)
	local GAMEPAD_TIMEOUT_MS = 3000
	local poll_key = "LibAPH_GamepadMove_" .. tostring(target)
	local mover = {}
	local gp = nil

	local function stop_move()
		gp = nil
		EVENT_MANAGER:UnregisterForUpdate(poll_key)
		SetGamepadRightStickConsumedByUI(false)
		if mover.on_move_stop then
			mover.on_move_stop({ left = target:GetLeft(), top = target:GetTop() })
		end
	end

	local function poll()
		local x, y = ZO_Gamepad_GetRightStickEasedX(), ZO_Gamepad_GetRightStickEasedY()
		SetGamepadRightStickConsumedByUI(true)

		local now = GetGameTimeMilliseconds()
		local interval = now - gp.last_tick
		gp.last_tick = now

		local magnitude = zo_sqrt(x * x + y * y)
		if magnitude >= 0.02 then
			local speed = magnitude * interval
			gp.last_move = now
			gp.x = zo_clamp(gp.x + x * speed, 0, 1 + GuiRoot:GetWidth() - target:GetWidth())
			gp.y = zo_clamp(gp.y + -y * speed, 0, 1 + GuiRoot:GetHeight() - target:GetHeight())
			target:ClearAnchors()
			target:SetAnchor(TOPLEFT, GuiRoot, TOPLEFT, gp.x, gp.y)
		end

		if now - gp.last_move >= GAMEPAD_TIMEOUT_MS then
			stop_move()
		end
	end

	function mover:ToggleGamepadMove(enable)
		if enable and not gp then
			local now = GetGameTimeMilliseconds()
			gp = { last_tick = now, last_move = now, x = target:GetLeft(), y = target:GetTop() }
			EVENT_MANAGER:RegisterForUpdate(poll_key, 0, poll)
		elseif not enable and gp then
			stop_move()
		end
	end

	function mover:RegisterCallback(name, event_code, fn)
		mover.on_move_stop = fn
	end

	return mover
end
