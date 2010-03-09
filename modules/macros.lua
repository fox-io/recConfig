LoadAddOn("Blizzard_MacroUI")

-- Sample.  Need to create table and loop, class checks etc.
local btn = CreateFrame("Button", "ViperHawkButton", UIParent, "SecureUnitButtonTemplate")
btn:SetAttribute("type", "macro")
btn:SetAttribute("macrotext", [[/castsequence !Aspect of the Hawk, !Aspect of the Viper]])
ClearOverrideBindings(btn)
SetOverrideBindingClick(btn, false, [[`]], btn:GetName())

-- Snatched via Cael's copy of Gotai's macro code.
-- Modified to be a bit less featureful, but still do what needs to be done.
-- Unless you edit this, you do not want this to run on your system, I think.
-- IF YOU RUN THIS CODE, ALL MACROS NOT IN THIS LIST WILL BE DELETED!
--local i_understand = true
-- Uncomment the line above to enable this module.  You have been warned.
local macros = {
	["AutoHP"] = {
		body = [[]],
	},
	["AutoMP"] = {
		body = [[]],
	},
	["AutoPet"] = {
		class = "HUNTER",
		body = [[]],
	},
	["Icy Touch"] = {
		class = "DEATHKNIGHT",
		body = [[
#showtooltip
/cast Icy Touch
/cast !Rune Strike
/startattack
]],
	},
	["Plague Strike"] = {
		class = "DEATHKNIGHT",
		body = [[
#showtooltip
/cast Plague Strike
/cast !Rune Strike
/startattack
]],
	},
	["Heart Strike"] = {
		class = "DEATHKNIGHT",
		body = [[
#showtooltip
/cast Heart Strike
/cast !Rune Strike
/startattack
]],
	},
	["Death Coil"] = {
		class = "DEATHKNIGHT",
		body = [[
#showtooltip
/cast Death Coil
/cast !Rune Strike
/startattack
]],
	},
	["Death Strike"] = {
		class = "DEATHKNIGHT",
		body = [[
#showtooltip
/cast Death Strike
/cast !Rune Strike
/startattack
]],
	},
	["EoEDrakes"] = {
		body = [[/raid ==DPS Drakes==
/raid Target Malygos
/raid 11112 11112
/raid 1115 if targeted
/raid ==Heal Drakes==
/raid Target Self
/raid 333334 333334
/raid 3335 if targeted]],
	},
	["FishAttack"] = {
		body = [[#showtooltip
/cast [equipped:Fishing Pole] Fishing; [equipped:Wand] Shoot; [noequipped:Fishing Pole, noequipped:Wand, nomodifier:ctrl] Auto Attack; [modifier:ctrl] Pick Lock;
               ]],
	},
	["Focus"] = {
		body = [[/stopmacro [target=focus,dead] [noexists]
/target focus
/focus [target=lasttarget]
               ]],
	},
	["Thaddius"] = {
		body = [[/raid NEG  <--  boss  -->   POS]],
	},
	["QuestTurnIn"] = {
		body = [[/run SelectGossipActiveQuest(1); CompleteQuest(); GetQuestReward()]],
	},
}

local function CreateBlizzardMacro(name, perChar, icon)
	if icon then
		if type(icon) == "string" then
			local path = icon:match("Interface.Icons.(.+)") or icon
			path = "Interface\\Icons\\"..path       -- Allow discrepancies in given path.
			
			for i=1, GetNumMacroIcons() do
				if GetMacroIconInfo(i) == path then
					icon = i
					break
				end
			end
		end
		
		if type(icon) ~= "number" then
			icon = nil
		end
	end
	
	local macroname = name:sub(1,13)
	local show = macros[name].show
	local macrobody = macros[name].body
	
	if show then
		show = string.format("#showtooltip %s\n", show)
		if show:len()+macrobody:len() <= 255 then
			macrobody = show..macrobody
		end
	end
	
	local index = GetMacroIndexByName(macroname)
	if index > 0 then
		EditMacro(index, nil, icon or 1, macrobody, 1)
	else
		local Macros, PerCharMacros = GetNumMacros()
		if perChar and PerCharMacros >= 18 then -- MAX_CHARACTER_MACROS
			perChar = nil
		end
		
		if not perChar and Macros >= 36 then -- MAX_ACCOUNT_MACROS
			return -- full
		end
		
		CreateMacro(macroname, icon or 1, macrobody, perChar)
	end
end

local event_frame = CreateFrame("Frame")
event_frame:RegisterEvent("PLAYER_ENTERING_WORLD")
event_frame:SetScript("OnEvent", function(self, event, ...)
	if i_understand then
		local _, playerClass = UnitClass("player")
		local playerName = UnitName("player")
		
		if InCombatLockdown() then
			return self:RegisterEvent("PLAYER_REGEN_ENABLED")
		end
		
		-- Remove all macros
		local NumMacros, NumMacrosPerChar = GetNumMacros()

		local name
		
		for i=NumMacros, 1, -1 do
			name = GetMacroInfo(i)
			if not macros[name] then
				DeleteMacro(i)
			end
		end
		
		for i=37+(NumMacrosPerChar-1 or 0), 37, -1 do
			name = GetMacroInfo(i)
			if not macros[name] then
				DeleteMacro(i)
			end
		end

		-- Insert recUI macros
		for k,v in pairs(macros) do
			if v.class and v.class:find(playerClass) then
				CreateBlizzardMacro(k, true, v.icon)
			else
				if v.char and v.char:find(playerName) then
					CreateBlizzardMacro(k, true, v.icon)
				else
					CreateBlizzardMacro(k, false, v.icon)
				end
			end
		end
	end
	
	self:UnregisterEvent(event)
	self:SetScript("OnEvent", nil)
	event_frame = nil
	macros = nil
end)