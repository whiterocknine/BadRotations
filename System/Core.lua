function bb:Engine()
	-- Hidden Frame
	if Pulse_Engine == nil then
		Pulse_Engine = CreateFrame("Frame", nil, UIParent)
		Pulse_Engine:SetScript("OnUpdate", BadBoyUpdate)
		Pulse_Engine:Show()
	end
end
-- Chat Overlay: Originally written by Sheuron.
local function onUpdate(self,elapsed)
	if self.time < GetTime() - 2.0 then if self:GetAlpha() == 0 then self:Hide(); else self:SetAlpha(self:GetAlpha() - 0.02); end end
end
chatOverlay = CreateFrame("Frame",nil,ChatFrame1)
chatOverlay:SetSize(ChatFrame1:GetWidth(),50)
chatOverlay:Hide()
chatOverlay:SetScript("OnUpdate",onUpdate)
chatOverlay:SetPoint("TOP",0,0)
chatOverlay.text = chatOverlay:CreateFontString(nil,"OVERLAY","MovieSubtitleFont")
chatOverlay.text:SetAllPoints()
chatOverlay.texture = chatOverlay:CreateTexture()
chatOverlay.texture:SetAllPoints()
chatOverlay.texture:SetTexture(0,0,0,.50)
chatOverlay.time = 0
function ChatOverlay(Message, FadingTime)
	if getOptionCheck("Overlay Messages") then
		chatOverlay:SetSize(ChatFrame1:GetWidth(),50)
		chatOverlay.text:SetText(Message)
		chatOverlay:SetAlpha(1)
		if FadingTime == nil then
			chatOverlay.time = GetTime()
		else
			chatOverlay.time = GetTime() - 2 + FadingTime
		end
		chatOverlay:Show()
	end
end
-- Minimap Button
function bb:MinimapButton()
	local dragMode = nil --"free", nil
	local function moveButton(self)
		local centerX, centerY = Minimap:GetCenter()
		local x, y = GetCursorPosition()
		x, y = x / self:GetEffectiveScale() - centerX, y / self:GetEffectiveScale() - centerY
		centerX, centerY = math.abs(x), math.abs(y)
		centerX, centerY = (centerX / math.sqrt(centerX^2 + centerY^2)) * 76, (centerY / sqrt(centerX^2 + centerY^2)) * 76
		centerX = x < 0 and -centerX or centerX
		centerY = y < 0 and -centerY or centerY
		self:ClearAllPoints()
		self:SetPoint("CENTER", centerX, centerY)
	end
	local button = CreateFrame("Button", "BadBoyButton", Minimap)
	button:SetHeight(25)
	button:SetWidth(25)
	button:SetFrameStrata("MEDIUM")
	button:SetPoint("CENTER", 75.70,-6.63)
	button:SetMovable(true)
	button:SetUserPlaced(true)
	button:SetNormalTexture("Interface\\HelpFrame\\HotIssueIcon.blp")
	button:SetPushedTexture("Interface\\HelpFrame\\HotIssueIcon.blp")
	button:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-Background.blp")
	button:SetScript("OnMouseDown",function(self, button)
		if button == "RightButton" then
			if bb.data.options[bb.selectedSpec] then
				if not FireHack then
						print("|cffFF1100BadBoy |cffFFFFFFCannot Start... |cffFF1100Firehack |cffFFFFFFis not loaded. Please attach Firehack.")
                else
                    if bb.ui.window.profile.parent then
                        if bb.data.options[bb.selectedSpec]["configFrame"] == true then
                            bb.ui.window.profile.parent.closeButton:Click()
                        else
                            bb.ui.window.profile.parent:Show()
                            bb.data.options[bb.selectedSpec]["configFrame"] = true
                        end
                    end
				end
			end
        end
        if button == "MiddleButton" then
            if bb.ui.window.help then
                bb.ui.window.help.parent:Show()
            end
        end
		if IsShiftKeyDown() and IsAltKeyDown() then
			self:SetScript("OnUpdate",moveButton)
		end
	end)
	button:SetScript("OnMouseUp",function(self)
		self:SetScript("OnUpdate",nil)
	end)
	button:SetScript("OnClick",function(self, button)
		if button == "LeftButton" then
			if IsShiftKeyDown() and not IsAltKeyDown() then
				if bb.data["Main"] == 1 then
					bb.data["Main"] = 0
					mainButton:Hide()
				else
					bb.data["Main"] = 1
					mainButton:Show()
				end
			elseif not IsShiftKeyDown() and not IsAltKeyDown() then
                if bb.ui.window.config.parent then
                    if bb.data.options[bb.selectedSpec]["optionsFrame"] == true then
                        bb.ui.window.config.parent.closeButton:Click()
                    else
                        bb.ui.window.config.parent:Show()
                        bb.data.options[bb.selectedSpec]["optionsFrame"] = true
                    end

                end
            end
		end
	end)
	button:SetScript("OnEnter", function(self)
		GameTooltip:SetOwner(Minimap, "ANCHOR_CURSOR", 50 , 50)
		GameTooltip:SetText("BadBoy The Ultimate Raider", 214/255, 25/255, 25/255)
		GameTooltip:AddLine("CodeMyLife - CuteOne - Masoud")
		GameTooltip:AddLine("Gabbz - Chumii - AveryKey")
		GameTooltip:AddLine("Ragnar - Cpoworks - Tocsin")
		GameTooltip:AddLine("Mavmins - CukieMunster - Magnu")
		GameTooltip:AddLine("Left Click to toggle config frame.", 1, 1, 1, 1)
		GameTooltip:AddLine("Shift+Left Click to toggle toggles frame.", 1, 1, 1, 1)
		GameTooltip:AddLine("Alt+Shift+LeftButton to drag.", 1, 1, 1, 1)
		GameTooltip:AddLine("Right Click to open profile options.", 1, 1, 1, 1)
        GameTooltip:AddLine("Middle Click to open help frame.", 1, 1, 1, 1)
		GameTooltip:Show()
	end)
	button:SetScript("OnLeave", function(self)
		GameTooltip:Hide()
	end)
end
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[---------          ---           --------       -------           --------------------------------------------------------------------------------------------------------------------]]
--[[---------  -----  ----   ---------------  ----  -------  --------  ---------------------------------------------------------------------------------------------------]]
--[[---------  ----  -----           ------  ------  ------  ---------  ----------------------------------------------------------------------------------------------------------]]
--[[---------       ------  --------------             ----  ---------  -------------------------------------------------------------------------------------------------------------]]
--[[---------  ----  -----  -------------  ----------  ----  --------  -------------------------------------------------------------------------------------------------]]
--[[---------  -----  ----           ---  ------------  ---            -------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
local frame = CreateFrame("FRAME")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterUnitEvent("ACTIVE_TALENT_GROUP_CHANGED")
frame:RegisterUnitEvent("CHARACTER_POINTS_CHANGED")
frame:RegisterUnitEvent("PLAYER_EQUIPMENT_CHANGED")
frame:RegisterUnitEvent("PLAYER_ENTERING_WORLD")
frame:RegisterUnitEvent("PLAYER_LEVEL_UP")
frame:RegisterUnitEvent("PLAYER_TALENT_UPDATE")
frame:RegisterUnitEvent("ZONE_CHANGED_NEW_AREA")
frame:RegisterUnitEvent("ZONE_CHANGED")
function bb:reloadOnSpecChange()
    if bb.data["Power"] == 1 then
        ReloadUI()
    end
end
-- Sets 'talentHasChanged' to true
function bb:characterTalentChanged()
    if bb.talentHasChanged == nil then
        bb.talentHasChanged = true
    end
end
-- Sets 'equipHasChanged' to true
function bb:characterEquipChanged()
    if bb.equipHasChanged ~= true then
        bb.equipHasChanged = true
    end
end
function bb:savePosition(windowName)
	if bb.selectedSpec == nil then bb.selectedSpec = select(2,GetSpecializationInfo(GetSpecialization())) end
	if bb.data.options[bb.selectedSpec] == nil then bb.data.options[bb.selectedSpec] = {} end
	if bb.ui.window[windowName] ~= nil then
		if bb.ui.window[windowName].parent ~= nil then
			local point, relativeTo, relativePoint, xOfs, yOfs = bb.ui.window[windowName].parent:GetPoint(1)
	        bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_point"] = point
	        bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_relativeTo"] = relativeTo:GetName()
	        bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_relativePoint"] = relativePoint
	        bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_xOfs"] = xOfs
	        bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_yOfs"] = yOfs

	        point, relativeTo, relativePoint, xOfs, yOfs = bb.ui.window[windowName].parent:GetPoint(2)
	        if point then
	            bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_point2"] = point
	            bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_relativeTo2"] = relativeTo:GetName()
	            bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_relativePoint2"] = relativePoint
	            bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_xOfs2"] = xOfs
	            bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_yOfs2"] = yOfs
	        end

	        bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_width"]  = bb.ui.window[windowName].parent:GetWidth()
	        bb.data.options[bb.selectedSpec][windowName.. "Frame".. "_height"] = bb.ui.window[windowName].parent:GetHeight()
	    end
	end
end
function bb:saveWindowPosition()
    bb:savePosition("profile")
    bb.savePosition("config")
end

function frame:OnEvent(event, arg1, arg2)
	if event == "ADDON_LOADED" and arg1 == "BadBoy" then
		--bb:Run()
	end
	if ((event == "ACTIVE_TALENT_GROUP_CHANGED" or event == "PLAYER_SPECIALIZATION_CHANGED") and arg1 ~= arg2 and arg2 ~= 0 and bb.loadedIn) then
        -- Closing the windows will save the position
        bb.ui.window.config.parent.closeButton:Click()
        bb.ui.window.profile.parent.closeButton:Click()

        -- Update Selected Spec/Profile
        bb.selectedSpec = select(2,GetSpecializationInfo(GetSpecialization()))
        if bb.data.options[bb.selectedSpec]["RotationDrop"] == nil then
	        bb.selectedProfile = 1
	    else
	        bb.selectedProfile = bb.data.options[bb.selectedSpec]["RotationDrop"]
	    end

        -- Recreate ConfigWindow with new Spec
        bb.ui:createConfigWindow()

        -- rebuild up UI
		BadBoyFrame()
    end
    if event == "PLAYER_LOGOUT" then
        bb:saveWindowPosition()
    end
    if event == "PLAYER_EQUIPMENT_CHANGED" then
        bb:characterEquipChanged() -- Sets a global to indicate equip was changed
    end
    if event == "PLAYER_ENTERING_WORLD" then
    	-- Update Selected Spec
        bb.selectedSpec = select(2,GetSpecializationInfo(GetSpecialization()))
    	-- Update Selected Spec
    	if not bb.loadedIn then
    		bagsUpdated = true
        	bb:Run()
        end
    end
    --if event == "ZONE_CHANGED" then
        -- temp
    --end
end
frame:SetScript("OnEvent", frame.OnEvent)
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
--[[This function is refired everytime wow ticks. This frame is located in Core.lua]]
function BadBoyUpdate(self)
	-- prevent ticking when firechack isnt loaded
	-- if user click power button, stop everything from pulsing.
	if not getOptionCheck("Start/Stop BadBoy") or bb.data["Power"] ~= 1 then
		optionsFrame:Hide()
		_G["debugFrame"]:Hide()
		return false
	end
	if FireHack == nil then
		optionsFrame:Hide()
		_G["debugFrame"]:Hide()
		if getOptionCheck("Start/Stop BadBoy") then
			ChatOverlay("FireHack not Loaded.")
		end
		return
	end
	-- pulse enemiesEngine
	bb:PulseUI()

    -- get DBM Timer/Bars
    -- global -> bb.DBM.Timer
    bb.DBM:getBars()

    -- Show Debug Frame TEMP
    if isChecked("Debug Frame") then
        bb.ui.window.debug.parent:Show()--_G["debugFrame"]:Show()
    else
        bb.ui.window.debug.parent:Hide()--_G["debugFrame"]:Hide()
    end

	-- accept dungeon queues
	bb:AcceptQueues()
	--[[Class/Spec Selector]]
    bb.selectedProfile = bb.data.options[bb.selectedSpec]["Rotation".."Drop"] or 1
	--local playerClass = select(3,UnitClass("player"))
	--local playerSpec = GetSpecialization()
	local playerSpec = GetSpecializationInfo(GetSpecialization())
	local playerLevel = UnitLevel("player")
	if playerSpec == 71 then -- Warrior
			WarriorArms()
		elseif playerSpec == 72 then
			WarriorFury()
		elseif playerSpec == 73 then
			WarriorProtection()
	elseif playerSpec == 65 then -- Paladin
			PaladinHoly()
		elseif playerSpec == 66 then
			PaladinProtection()
		elseif playerSpec == 70 then
			PaladinRetribution()
	elseif playerSpec == 253 then -- Hunter
			HunterBeastmaster()
		elseif playerSpec == 254 then
			HunterMarksmanship()
		elseif playerSpec == 255 then
			HunterSurvival()
	elseif playerSpec == 259 then -- Rogue
			RogueAssassination()
		elseif playerSpec == 260 then
			RogueOutlaw()
		elseif playerSpec == 261 then
			RogueSubtlety()
	elseif playerSpec == 256 then -- Priest
			PriestDiscipline()
		elseif playerSpec == 257 then
			PriestHoly()
		elseif playerSpec == 258 then
			PriestShadow()
	elseif playerSpec == 250 then -- Death Knight
			DeathKnightBlood()
		elseif playerSpec == 251 then
			DeathKnightFrost()
		elseif playerSpec == 252 then
			DeathKnightUnholy()
	elseif playerSpec == 262 then -- Shaman
			ShamanElemental()
		elseif playerSpec == 263 then
			ShamanEnhancement()
		elseif playerSpec == 264 then
			ShamanRestoration()
	elseif playerSpec == 62 then -- Mage
			MageArcane()
		elseif playerSpec == 63 then
			MageFire()
		elseif playerSpec == 64 then
			MageFrost()
	elseif playerSpec == 265 then -- Warlock
			WarlockAffliction()
		elseif playerSpec == 266 then
			WarlockDemonology()
		elseif playerSpec == 267 then
			WarlockDestruction()
	elseif playerSpec == 268 then -- Monk
			MonkBrewmaster()
		elseif playerSpec == 269 then
			MonkMistweaver()
		elseif playerSpec == 270 then
			MonkWindwalker()
	elseif playerSpec == 102 then -- Druid
			DruidMoonkin()
		elseif playerSpec == 103 then
			DruidFeral()
		elseif playerSpec == 104 then
			DruidGuardian()
		elseif playerSpec == 105 then
			DruidRestoration()
	elseif playerSpec == 577 then --Demon Hunter
			DemonHunterHavoc()
		elseif playerSpec == 581 then
			DemonHunterVengeance()
			else print("Contact A Developer")
	end
end

--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]

--[[-------------------------------------------------------------------------------------------------------------------------------------------------------]]
