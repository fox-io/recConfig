-- $Id: trash.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...
t.events:RegisterEvent("MERCHANT_SHOW")
t.events:HookScript("OnEvent", function(self, event, ...)
	if event == "MERCHANT_SHOW" then
		for bag_id = 0, 4 do
			for slot_id = 0, GetContainerNumSlots(bag_id) do
				local item_link = GetContainerItemLink(bag_id, slot_id)
				-- Vendor all grey items.
				if item_link and select(3, GetItemInfo(item_link)) == 0 then
					UseContainerItem(bag_id, slot_id)
				end
			end
		end
	end
end)