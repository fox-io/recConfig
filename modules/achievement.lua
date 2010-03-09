-- $Id: achievement.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...
local function reanchor()
	local one, two, lfg = AchievementAlertFrame1, AchievementAlertFrame2, DungeonCompletionAlertFrame1
	if one then
		one:ClearAllPoints()
		one:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
	end
	if two then
		two:ClearAllPoints()
		two:SetPoint("TOP", one, "BOTTOM", 0, -10)	
	end
	if lfg:IsShown() then
		lfg:ClearAllPoints()
		if one then
			if two then
				lfg:SetPoint("TOP", two, "BOTTOM", 0, -10)
			else
				lfg:SetPoint("TOP", one, "BOTTOM", 0, -10)
			end
		else
			lfg:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
		end
	end
end

t.events:RegisterEvent("VARIABLES_LOADED")
t.events:HookScript("OnEvent", function(self, event, ...)
	if event == "VARIABLES_LOADED" then
		AlertFrame_FixAnchors = reanchor
	end
end)