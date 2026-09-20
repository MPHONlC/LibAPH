-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")

function LibAPH.ScheduleWizardIfNeeded(isCompleted, runFn, delayMs)
	if isCompleted then return end
	zo_callLater(runFn, delayMs or 3000)
end

function LibAPH.AutoUnloadWizardModule(settings, toggleFn)
	if not (settings.module_disabled and settings.module_disabled.wizard) then
		toggleFn("wizard", true)
	end
end
