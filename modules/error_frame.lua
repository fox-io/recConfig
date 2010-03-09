-- $Id: error_frame.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
UIErrorsFrame:UnregisterEvent("UI_ERROR_MESSAGE")

local useless_messages = {
	"fish are hooked",
	"Mail sent",
	"Discovered: "
}
-- Filter out messages we don't care about.
local oUIErrorsFrame_OnEvent = UIErrorsFrame:GetScript("OnEvent")
UIErrorsFrame:SetScript("OnEvent", function(self, event, msg, ...)
	if event == "UI_INFO_MESSAGE" then
		for _, keyword in pairs(useless_messages) do
			if msg:find(keyword) then return end
		end
	end

	return oUIErrorsFrame_OnEvent(self, event, msg, ...)
end)