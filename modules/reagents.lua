-- $Id: reagents.lua 594 2010-03-07 20:07:35Z john.d.mann@gmail.com $
local n, t = ...
--[[
	This is where you will add your characters, their realm, and the stock levels
	of each item they will want auto-stocked.
--]]
local my_reagents
local reagents = {
	["Moon Guard"] = {
		["Lanuit"]	= { [17028] = 40,	[8766]  = 60,	[4599]  = 20 },
		["Suzi"]	= { [17032] = 20,	[17031] = 20,	[17020] = 100 },
		["Foliage"]	= { [1708]	= 20,	[17036] = 5 },
		["Zima"]	= { [41586] = 18000 },
		["Lewts"]	= { [3770]	= 20,	[6947]	= 20,	[3775] = 20 },
		["Neural"]	= { [33449] = 20 },
		["Kudzu"]	= { [17030] = 10 },
	},
	["Sisters of Elune"] = {
		["Suzie"]   = { [1708] = 40, [4607] = 20 },
	},
	["Sentinels"] = {
		["Suzy"]    = { [3030] = 5000, [1645] = 20, [4599] = 20 },
	},
}

local not_enough_money		= "Not enough money to purchase reagents."
local itemid_pattern		= "item:(%d+)"
local GetContainerNumSlots	= GetContainerNumSlots
local GetContainerItemLink	= GetContainerItemLink
local GetContainerItemInfo	= GetContainerItemInfo
local GetMerchantNumItems	= GetMerchantNumItems
local GetMerchantItemInfo	= GetMerchantItemInfo
local GetMerchantItemLink	= GetMerchantItemLink
local BuyMerchantItem		= BuyMerchantItem
local UnitName				= UnitName
local GetRealmName			= GetRealmName
local GetItemInfo			= GetItemInfo
local GetMoney				= GetMoney
local select				= select
local print					= print
local math_max				= math.max
local math_min				= math.min
local math_floor			= math.floor
local tonumber				= tonumber
local string_find			= string.find
local player_realm, player_name

--[[
	Returns the amount of checkid which would be needed to stock the item to the preset level.
	This does NOT return the amount of the item which will be purchased (due to possible
	overstock), rather the total amount which would be ideal.
--]]
local get_num_reagents_needed = function(checkid)
	if not my_reagents[checkid] then return 0 end
	local total = 0
	for bag = 0, NUM_BAG_FRAMES do
		for slot = 1, GetContainerNumSlots(bag) do
			local link = GetContainerItemLink(bag, slot)
			if link then
				local id = tonumber(select(3, string_find(link, itemid_pattern)))
				local stack = select(2, GetContainerItemInfo(bag, slot))
				if id == checkid then total = total + stack end
			end
		end
	end
	return math_max(0, (my_reagents[checkid] - total))
end

--[[
	Purchases the required amount of reagents to come as close as possible to the requested
	stock level.  Does NOT overstock, so you may end up with less than the stock level you
	asked for.
--]]
local buy_reagents = function()
	for i=1, GetMerchantNumItems() do
		local link, id = GetMerchantItemLink(i)
		if link then id = tonumber(select(3, string_find(link, itemid_pattern))) end
		if id and my_reagents[id] then
			local price, stack, stock = select(3, GetMerchantItemInfo(i))
			local quantity = get_num_reagents_needed(id)
			if quantity > 0 then
				if stock ~= -1 then quantity = math_min(quantity, stock) end
				subtotal = price * (quantity/stack)
				if subtotal > GetMoney() then print(not_enough_money); return end
				local fullstack = select(8, GetItemInfo(id))
				while quantity > fullstack do
					BuyMerchantItem(i, math_floor(fullstack/stack))
					quantity = quantity - fullstack
				end
				if quantity >= stack then
					BuyMerchantItem(i, math_floor(quantity/stack))
				end
			end
		end
	end
end

--[[
	Ensures that we have the player's name, their realm, and that a table actually exists for
	that particular character before scanning the vendor for purchases.
--]]
t.events:RegisterEvent("MERCHANT_SHOW")
t.events:HookScript("OnEvent", function(self, event, ...)
	if event == "MERCHANT_SHOW" then
		if not my_reagents then
			if not player_name then player_name = UnitName("player") end
			if not player_realm then player_realm = GetRealmName() end
			if reagents[player_realm] and reagents[player_realm][player_name] then
				my_reagents = reagents[player_realm][player_name]
				reagents = nil
			end
		end
		buy_reagents()
	end
end)