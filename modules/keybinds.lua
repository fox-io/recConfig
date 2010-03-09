local bindings = {
                 ["W"] = "MOVEFORWARD",
                 ["S"] = "MOVEBACKWARD",
                 ["A"] = "TURNLEFT",
                 ["D"] = "TURNRIGHT",
                 ["Q"] = "STRAFELEFT",
                 ["E"] = "STRAFERIGHT",
                 ["1"] = "ACTIONBUTTON1",
                 ["2"] = "ACTIONBUTTON2",
                 ["3"] = "ACTIONBUTTON3",
                 ["4"] = "ACTIONBUTTON4",
                 ["5"] = "ACTIONBUTTON5",
                 ["6"] = "ACTIONBUTTON6",
                 ["7"] = "ACTIONBUTTON7",
                 ["8"] = "ACTIONBUTTON8",
                 ["9"] = "ACTIONBUTTON9",
                 ["0"] = "ACTIONBUTTON10",
                 ["-"] = "ACTIONBUTTON11",
                 ["="] = "ACTIONBUTTON12",
           ["BUTTON3"] = "MOVEANDSTEER",
             ["SPACE"] = "JUMP",
                 ["X"] = "SITORSTAND",
                 ["Z"] = "TOGGLESHEATH",
           ["NUMLOCK"] = "TOGGLEAUTORUN",
      ["NUMPADDIVIDE"] = "TOGGLERUN",
             ["ENTER"] = "OPENCHAT",
                 ["/"] = "OPENCHATSLASH",
            ["PAGEUP"] = "CHATPAGEUP",
          ["PAGEDOWN"] = "CHATPAGEDOWN",
    ["SHIFT-PAGEDOWN"] = "CHATBOTTOM",
                 ["R"] = "REPLY",
           ["SHIFT-R"] = "REPLY2",
               ["TAB"] = "TARGETNEARESTENEMY",
         ["SHIFT-TAB"] = "TARGETLASTENEMY",
          ["CTRL-TAB"] = "TARGETNEARESTFRIEND",
                ["F1"] = "TARGETSELF",
                ["F2"] = "TARGETPARTYMEMBER1",
                ["F3"] = "TARGETPARTYMEMBER2",
                ["F4"] = "TARGETPARTYMEMBER3",
                ["F5"] = "TARGETPARTYMEMBER4",
                 ["V"] = "NAMEPLATES",
           ["SHIFT-V"] = "FRIENDNAMEPLATES",
            ["CTRL-V"] = "ALLNAMEPLATES",
			     ["F"] = "ASSISTTARGET",
                 ["C"] = "TOGGLECHARACTER0",
                 ["B"] = "OPENALLBAGS",
                 ["P"] = "TOGGLESPELLBOOK",
                 ["N"] = "TOGGLETALENTS",
                 ["H"] = "TOGGLECHARACTER4",
                 ["K"] = "TOGGLECHARACTER1",
                 ["L"] = "TOGGLEQUESTLOG",
            ["ESCAPE"] = "TOGGLEGAMEMENU",
                 ["M"] = "TOGGLEWORLDMAP",
                 ["O"] = "TOGGLESOCIAL",
                 ["I"] = "TOGGLELFGPARENT",
           ["SHIFT-M"] = "TOGGLEBATTLEFIELDMINIMAP",
                 ["Y"] = "TOGGLEACHIEVEMENT",
       ["PRINTSCREEN"] = "SCREENSHOT",
      ["MOUSEWHEELUP"] = "CAMERAZOOMIN",
    ["MOUSEWHEELDOWN"] = "CAMERAZOOMOUT",
}

local event_frame = CreateFrame("Frame")
event_frame:RegisterEvent("PLAYER_ENTERING_WORLD")
event_frame:SetScript("OnEvent", function(self)
	-- Remove all keybinds
	for i = 1, GetNumBindings() do
		local command = GetBinding(i)
		while GetBindingKey(command) do
			local key = GetBindingKey(command)
			SetBinding(key) -- Clear Keybind
		end
	end
	
	-- Apply personal keybinds
	for key, bind in pairs(bindings) do
		SetBinding(key, bind)
	end
	
	-- Save keybinds
	SaveBindings(1)

	-- All done, clean up a bit.
	event_frame:UnregisterEvent(event)
	event_frame:SetScript("OnEvent", nil)
	bindings = nil	-- Remove table
	event_frame = nil -- Remove frame
end)