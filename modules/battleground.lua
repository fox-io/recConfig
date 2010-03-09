-- $Id: battleground.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...
t.events:RegisterEvent("PLAYER_DEAD")
t.events:HookScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_DEAD" then
		if MiniMapBattlefieldFrame.status == "active" then
			RepopMe()
		end
	end
end)