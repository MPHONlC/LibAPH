-- LibAPH - Copyright 2026 @APHONlC.
-- Licensed under the GNU General Public License v3.0 (GPLv3).
-- See LICENSE.md and NOTICE.md.

assert(LibAPH, "LibAPH.lua must be loaded before this file")

function LibAPH.RunDoubleGCPass(opts)
	opts = opts or {}
	assert(type(opts.onDone) == "function", "LibAPH.RunDoubleGCPass needs opts.onDone")
	local settle_before = opts.settleBeforeMs or 500
	local settle_after = opts.settleAfterMs or 200
	zo_callLater(function()
		local before_lua = collectgarbage("count") / 1024
		local before_pool = opts.getPoolMB and opts.getPoolMB() or 0
		for _ = 1, 2 do collectgarbage("collect") end
		if opts.extraPass then collectgarbage("collect") end

		zo_callLater(function()
			local after_lua = collectgarbage("count") / 1024
			local after_pool = opts.getPoolMB and opts.getPoolMB() or 0
			local freed_lua = math.max(before_lua - after_lua, 0)
			local freed_pool = math.max(before_pool - after_pool, 0)
			opts.onDone(before_lua, after_lua, freed_lua, before_pool, after_pool, freed_pool)
		end, settle_after)
	end, settle_before)
end
