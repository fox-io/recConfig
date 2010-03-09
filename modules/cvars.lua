-- $Id: cvars.lua 550 2010-03-02 15:27:53Z john.d.mann@gmail.com $
local n, t = ...
t.events:RegisterEvent("PLAYER_LOGIN")
t.events:HookScript("OnEvent", function(self, event, ...)
	if event == "PLAYER_LOGIN" then
		SetCVar("alwaysCompareItems", 0)						-- 0,1 show comparison tooltips 0 == with shift, 1 == full time
		SetCVar("autoDismount", 1)								-- 0,1 dismount when using an ability
		SetCVar("autoDismountFlying", 1)						-- 0,1 dismount when using an ability while flying
		SetCVar("autointeract", 0)								-- 0,1 aka: Click to move
		SetCVar("autoStand", 1)									-- 0,1 stand up when using an ability
		SetCVar("autoUnshift", 1)								-- 0,1 unshapeshift when necessary for abilities
		SetCVar("baseMip", 1)									-- 0-1, lower == better quality aka Texture Resolution
		SetCVar("cameraDistanceMax", 50)						-- 1-50 max distance camera can zoom
		SetCVar("cameraDistanceMaxFactor", 3.4)					-- 1-3.4 max camera distance factor (max*factor)
		SetCVar("cameraDistanceMoveSpeed", 50)					--
		SetCVar("cameraViewBlendStyle", 2)						-- 1,2 camera movement from saved position: 1 smooth, 2 instant
		SetCVar("componentTextureLevel", 8)						-- 8-9 aka Player Textures
		SetCVar("environmentDetail", 0)							-- 0-2 draw distance for doodads
		SetCVar("equipmentManager", 1)							--
		SetCVar("extShadowQuality", 0)							-- 0-5
		SetCVar("farclip", 1277)								-- 177-1277 aka View Distance
		SetCVar("farclipoverride", 0)							-- 0,1 Override 777 farclip limit, only needed in some clients
		SetCVar("ffx", "0")										--
		SetCVar("ffxDeath", "0")								-- 0,1 aka Death Effect
		SetCVar("ffxGlow", "0")									-- 0,1 aka Full Screen Glow
		SetCVar("groundEffectDensity", 0)						-- 16-64 aka Ground Clutter Density (0-250?)
		SetCVar("groundEffectDist", 0)							-- 70-140 aka Ground Clutter Radius
		SetCVar("gxapi", "d3d9")								-- "d3d9", "d3d9ex", "opengl"
		SetCVar("gxCursor", "1")								-- 0,1 aka Use Hardware Cursor
		SetCVar("gxFixLag", "0")								--
		SetCVar("gxMultisample","1")							--
		SetCVar("gxMultisampleQuality","0.000000")				--
		SetCVar("gxRefresh", "50")								--
		SetCVar("gxtextureCacheSize", 0)						-- 0-512 in MB cache textures in memory (see also texturecachesize)
		SetCVar("gxTripleBuffer", "0")							--
		SetCVar("gxVSync", "0")									--
		SetCVar("M2Faster", 1)									-- 0,1 reduce the number of times we re-program the vertex shader hardware when vertex shaders are enabled
		SetCVar("mapShadows", "0")								-- 0,1 terrain shadows
		SetCVar("Maxfps", "45")									-- limit game fps. 0 = no limit
		SetCVar("maxfpsbk", "10")								-- limit game fps when game is in background/minimized. 0 = no limit
		SetCVar("nameplateShowEnemies", 1)						--
		SetCVar("objectFade", 1)								-- 0,1 fading of small objects
		SetCVar("ObjectSelectionCircle", 1)						-- 0,1 show selection circle
		SetCVar("particleDensity", 1)							-- 0.1-1
		SetCVar("previewTalents", 1)							--
		SetCVar("projectedTextures", 1)							-- 0,1
		SetCVar("screenshotFormat", "jpeg")						-- 'jpeg' or 'tga'
		SetCVar("ScreenshotQuality", 10)						-- 1-10
		SetCVar("secureAbilityToggle", 1)						--
		SetCVar("shadowLevel", "0")								--
		SetCVar("shadowLOD", "0")								-- 0,1 blob shadows
		SetCVar("showfootprints", "0")							--
		SetCVar("showNewbieTips", 0)							--
		SetCVar("showGameTips", 0)								-- 0,1 Loading screen tips
		SetCVar("showTutorials", 0)								-- 0,1 Level 1 tutorial nonsense
		SetCVar("skycloudlod", 0)								-- 0-3 level of sky detail
		SetCVar("Sound_AmbienceVolume", "1")					--
		SetCVar("Sound_EnableErrorSpeech", "0")					--
		SetCVar("Sound_EnableMusic", "0")						--
		SetCVar("Sound_EnableSoundWhenGameIsInBG", "1")			--
		SetCVar("Sound_ListenerAtCharacter", 1)					-- 0,1 1 = character 0 = camera
		SetCVar("Sound_MasterVolume", "1")						--
		SetCVar("Sound_MusicVolume", "0")						--
		SetCVar("Sound_OutputQuality", "0")						--
		SetCVar("Sound_SFXVolume", "1")							--
		SetCVar("specular", "0")								-- 0,1 aka Specular Lighting
		SetCVar("spellEffectLevel", "9")						-- 9-2000 2000 will make video card catch fire and die a quick death.
		SetCVar("synchronizeSettings", 1)						-- 0,1 sync ui settings to server
		SetCVar("synchronizeConfig", 1)							-- 0,1 sync game options to server
		SetCVar("synchronizeBindings", 1)						-- 0,1 sync key binds to server
		SetCVar("synchronizeMacros", 1)							-- 0,1 sync macros to server
		SetCVar("textureCacheSize", 32)							-- 0-512 in MB cache textures in memory (see also gxtexturecachesize)
		SetCVar("textureFilteringMode", 0)						-- 0-5 aka Texture Filtering
		SetCVar("UberTooltips", 1)								-- 0,1 Shows spell descriptions in tooltips
		SetCVar("violencelevel", 5)								-- 0-5 Level of violence, 0 == none, 1 == green blood 2-5 == red blood
		SetCVar("useWeatherShaders", "0")						--
		SetCVar("weatherDensity", 0)							-- 0-3 aka Weather Intensity
		SetCVar("processAffinityMask", "3")						-- how many processor cores to use. 1 = 1 core, 3 = 2 cores, 15 = 4 cores, 255 = 8 cores
		SetCVar("useUiScale", 1)								--
		SetCVar("uiScale", 0.84)								--
		ConsoleExec( "pitchlimit 449" )							-- 89, 449. 449 allows doing flips, 89 will not
		ConsoleExec( "characterAmbient -0.1")					-- -0.1-1 use ambient lighting for character. <0 == off
		--ConsoleExec( "gxRestart" )							-- Needed for some settings to take effect
	end
end)