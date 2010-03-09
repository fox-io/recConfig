-- $Id: loot.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...

-- Auto DE/Greed
t.events:RegisterEvent("START_LOOT_ROLL")
t.events:HookScript("OnEvent", function(self, event, id)
	if event == "START_LOOT_ROLL" then
		if UnitLevel("player") < 60 then return end
		if(id and select(4, GetLootRollItemInfo(id))==2 and not (select(5, GetLootRollItemInfo(id)))) then
			if RollOnLoot(id, 3) then
				RollOnLoot(id, 3)
			else
				RollOnLoot(id, 2)
			end
		end
	end
end)

-- Move/scale frame
local function on_show(self, ...)
	self:ClearAllPoints()
	if self:GetName() == "GroupLootFrame1" then
		self:SetPoint("CENTER", UIParent, "CENTER", -762.5, -330.5)
	else
		local _, _, num = self:GetName():find("GroupLootFrame(%d)")
		self:SetPoint("BOTTOM", _G[string.format("GroupLootFrame%d", num-1)], "TOP", 0, 5)
		self:SetFrameLevel(0)
	end
	self:SetScale(.75)
	
	if self.on_show then
		self:on_show(...)
	end
end

GroupLootFrame1.on_show = GroupLootFrame1:GetScript("OnShow")
GroupLootFrame2.on_show = GroupLootFrame2:GetScript("OnShow")
GroupLootFrame3.on_show = GroupLootFrame3:GetScript("OnShow")
GroupLootFrame4.on_show = GroupLootFrame4:GetScript("OnShow")

GroupLootFrame1:SetScript("OnShow", on_show)
GroupLootFrame2:SetScript("OnShow", on_show)
GroupLootFrame3:SetScript("OnShow", on_show)
GroupLootFrame4:SetScript("OnShow", on_show)