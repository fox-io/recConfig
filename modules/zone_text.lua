-- $Id: zone_text.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...

-- Override Blizzard fade durations

FadingFrame_SetFadeInTime(  ZoneTextFrame,    2)
FadingFrame_SetHoldTime(    ZoneTextFrame,    0)
FadingFrame_SetFadeOutTime( ZoneTextFrame,    5)
FadingFrame_SetFadeInTime(  SubZoneTextFrame, 2)
FadingFrame_SetHoldTime(    SubZoneTextFrame, 0)
FadingFrame_SetFadeOutTime( SubZoneTextFrame, 5)

-- Override Blizzard function to set custom colors/fonts/anchors.
function SetZoneText(showZone)
	local pvpType, isSubZonePvP, factionName = GetZonePVPInfo()
	PVPArenaTextString:SetText("")
	PVPInfoTextString:SetText("")
	local pvpTextString = PVPInfoTextString
	if ( isSubZonePvP ) then
		pvpTextString = PVPArenaTextString
	end

	--[[if ( pvpType == "sanctuary" ) then
		pvpTextString:SetText(SANCTUARY_TERRITORY)
		pvpTextString:SetTextColor(0.41, 0.8, 0.94)
		ZoneTextString:SetTextColor(0.41, 0.8, 0.94)
		SubZoneTextString:SetTextColor(0.41, 0.8, 0.94)
	elseif ( pvpType == "arena" ) then
		pvpTextString:SetText(FREE_FOR_ALL_TERRITORY)
		pvpTextString:SetTextColor(1.0, 0.1, 0.1)
		ZoneTextString:SetTextColor(1.0, 0.1, 0.1)
		SubZoneTextString:SetTextColor(1.0, 0.1, 0.1)
	elseif ( pvpType == "friendly" ) then
		pvpTextString:SetFormattedText(FACTION_CONTROLLED_TERRITORY, factionName)
		pvpTextString:SetTextColor(0.1, 1.0, 0.1)
		ZoneTextString:SetTextColor(0.1, 1.0, 0.1)
		SubZoneTextString:SetTextColor(0.1, 1.0, 0.1)
	elseif ( pvpType == "hostile" ) then
		pvpTextString:SetFormattedText(FACTION_CONTROLLED_TERRITORY, factionName)
		pvpTextString:SetTextColor(1.0, 0.1, 0.1)
		ZoneTextString:SetTextColor(1.0, 0.1, 0.1)
		SubZoneTextString:SetTextColor(1.0, 0.1, 0.1)
	elseif ( pvpType == "contested" ) then
		pvpTextString:SetText(CONTESTED_TERRITORY)
		pvpTextString:SetTextColor(1.0, 0.7, 0)
		ZoneTextString:SetTextColor(1.0, 0.7, 0)
		SubZoneTextString:SetTextColor(1.0, 0.7, 0)
	elseif ( pvpType == "combat" ) then
		pvpTextString:SetText(COMBAT_ZONE)
		pvpTextString:SetTextColor(1.0, 0.1, 0.1)
		ZoneTextString:SetTextColor(1.0, 0.1, 0.1)
		SubZoneTextString:SetTextColor(1.0, 0.1, 0.1)
	else--]]
	
	ZoneTextString:SetTextColor(1, 1, 1)
	SubZoneTextString:SetTextColor(1, 1, 1)
	--end
	
	ZoneTextString:SetFont(    recMedia.fontFace.NORMAL, 18, "OUTLINE" )
	SubZoneTextString:SetFont( recMedia.fontFace.NORMAL, 18, "OUTLINE" )
	pvpTextString:SetFont(     recMedia.fontFace.NORMAL, 18, "OUTLINE" )
	
	ZoneTextString:SetJustifyH("CENTER")
	ZoneTextString:ClearAllPoints()
	ZoneTextString:SetPoint("CENTER", UIParent, "CENTER", 0, -10)
	SubZoneTextString:SetJustifyH("CENTER")
	SubZoneTextString:ClearAllPoints()
	SubZoneTextString:SetPoint("TOPLEFT", ZoneTextString, "BOTTOMLEFT", 0, -3)
	pvpTextString:SetJustifyH("CENTER")
	pvpTextString:ClearAllPoints()
	pvpTextString:SetPoint("TOPLEFT", SubZoneTextString, "BOTTOMLEFT", 0, -3)

	--if ( ZonePVPType ~= pvpType ) then
		--ZonePVPType = pvpType
--		FadingFrame_Show(ZoneTextFrame)
	--elseif ( not showZone ) then
		--PVPInfoTextString:SetText("")
		--SubZoneTextString:SetPoint("TOP", "ZoneTextString", "BOTTOM", 0, 0)
	--end

	--if ( PVPInfoTextString:GetText() == "" ) then
		--SubZoneTextString:SetPoint("TOP", "ZoneTextString", "BOTTOM", 0, 0)
	--else
		--SubZoneTextString:SetPoint("TOP", "PVPInfoTextString", "BOTTOM", 0, 0)
	--end
end

-- TODO: Override event handler
function ZoneText_OnEvent(self, event, ...)
	local showZoneText = false
	local zoneText = GetZoneText()
	if ( (zoneText ~= self.zoneText) or (event == "ZONE_CHANGED_NEW_AREA") ) then
		self.zoneText = zoneText
		ZoneTextString:SetText( zoneText )
		showZoneText = true
		SetZoneText( showZoneText )
		FadingFrame_Show( self )
	end
	
	local subzoneText = GetSubZoneText()
	if ( subzoneText == "" and not showZoneText) then
		subzoneText = zoneText
	end
	SubZoneTextString:SetText( "" )

	if ( subzoneText == zoneText ) then
		showZoneText = false
		if ( not self:IsShown() ) then
			SubZoneTextString:SetText( subzoneText )
			SetZoneText( showZoneText )
			FadingFrame_Show( SubZoneTextFrame )
		end
	else
		if (self:IsShown()) then
			showZoneText = true
		end
		SubZoneTextString:SetText( subzoneText )
		SetZoneText( showZoneText )
		FadingFrame_Show( SubZoneTextFrame )
	end
end