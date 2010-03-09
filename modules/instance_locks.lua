-- $Id: instance_locks.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...
t.events:RegisterEvent("ADDON_LOADED")
t.events:RegisterEvent("UPDATE_INSTANCE_INFO")

t.events:HookScript("OnEvent", function(self, event, ...)
	if event == "ADDON_LOADED" then
		if ... == "recConfig" then
			RequestRaidInfo()
		end
	end
	
	if event == "UPDATE_INSTANCE_INFO" then
		for i = 1, GetNumSavedInstances() do
			local name, _, _, _, is_locked, is_extended = GetSavedInstanceInfo(i)
			if (name == "The Oculus" or name == "The Culling of Stratholme") and is_locked and (not is_extended) then
				SetSavedInstanceExtend(i, true)
			end
		end
	end
end)