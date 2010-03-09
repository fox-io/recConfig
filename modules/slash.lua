-- $Id: slash.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
SLASH_RECUI_RELOAD1 = "/rl"
SlashCmdList["RECUI_RELOAD"] = function() ReloadUI() end

SLASH_RECUI_DISABLE_ADDON1 = "/disable"
SlashCmdList["RECUI_DISABLE_ADDON"] = function(addon) DisableAddOn(addon) end

SLASH_RECUI_ENABLE_ADDON1 = "/enable"
SlashCmdList["RECUI_ENABLE_ADDON"] = function(addon) EnableAddOn(addon) end

SLASH_RECUI_GM_TICKET1 = "/gm"
SlashCmdList["RECUI_GM_TICKET"] = function() ToggleHelpFrame() end

SLASH_RECUI_CLEAR_CHAT1 = "/clear"
SLASH_RECUI_CLEAR_CHAT2 = "/cls"
SlashCmdList["RECUI_CLEAR_CHAT"] = function()
	for i=1,7 do
		if i ~= 2 then
			_G[string.format("ChatFrame%d", i)]:Clear()
		end
	end
end

-- /tt
-- Sends whisper to your target.
ChatFrameEditBox:HookScript("OnTextChanged", function(self, from_user, ...)
	if from_user then
		local message = string.match(self:GetText(), "^/tt (.*)")
		if message and UnitExists("target") and UnitIsPlayer("target") and UnitIsFriend("player", "target") then
			local name, realm = UnitName("target")
			if name and not UnitIsSameServer("player", "target") then
				name = string.format("%s-%s", name, realm)
			end
			ChatFrame_SendTell(name)
			ChatFrameEditBox:SetText(message)
		end
	end
end)