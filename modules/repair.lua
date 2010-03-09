-- $Id: repair.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...
t.events:RegisterEvent("MERCHANT_SHOW")
t.events:HookScript("OnEvent", function(self, event, ...)
	if event == "MERCHANT_SHOW" then
		if CanMerchantRepair() then
			local repair_cost, repair_needed = GetRepairAllCost()
			if repair_needed and repair_cost > 0 and repair_cost < GetMoney() then
				RepairAllItems()	-- Use RepairAllItems(1) for guild bank.
				print(string.format("Repaired all items for: %.1fg", repair_cost * 0.0001))
			end
		end
	end
end)