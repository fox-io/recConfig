-- $Id: buffs.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...
-- BuffRemover is essentially a rip of the AntiHawk addon by p3lim, modified
-- to remove any and all buffs that you do not want on your character.  To use
-- BuffRemover, simply obtain the spell ID for the buff you want to remove and
-- enter it in the list below.
local unwanted_buffs = {
	[58493] = true,	-- Mr. T mohawk
}

t.events:RegisterEvent("UNIT_AURA")
t.events:HookScript("OnEvent", function(self, event, ...)
	if event == "UNIT_AURA" then
		if unit == "player" then
			for k,_ in pairs(unwanted_buffs) do
				if UnitAura(unit, GetSpellInfo(k)) then
					CancelUnitBuff(unit, GetSpellInfo(k))
				end
			end
		end
	end
end)