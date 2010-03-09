-- $Id: duels.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...
t.events:RegisterEvent("DUEL_REQUESTED")
t.events:HookScript("OnEvent", function(self, event, ...)
	if event == "DUEL_REQUESTED" then
		CancelDuel()
	end
end)