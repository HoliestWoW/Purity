local CLASS_COLORS = {
	["WARRIOR"] = "C69B6D", ["MAGE"] = "3FC7EB", ["ROGUE"] = "FFF468",
	["DRUID"] = "FF7C0A", ["HUNTER"] = "AAD372", ["SHAMAN"] = "0070DD",
	["PRIEST"] = "FFFFFF", ["WARLOCK"] = "8788EE", ["PALADIN"] = "F48CBA",
}
local AceGUI = LibStub("AceGUI-3.0")

local PurityPanel = CreateFrame("Frame", "PurityCharacterPanel", CharacterFrame)
PurityPanel:SetAllPoints(true)
PurityPanel:Hide()

local frameOffsetX, frameOffsetY = 2, -1

local PurityOuterFrame = CreateFrame("Frame", "PurityOuterFrame", PurityPanel)
PurityOuterFrame:SetSize(400, 400)
PurityOuterFrame:SetPoint("CENTER")
local tL=PurityOuterFrame:CreateTexture(nil,"BACKGROUND");tL:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft");tL:SetPoint("TOPLEFT",CharacterFrame,"TOPLEFT",frameOffsetX,frameOffsetY);tL:SetSize(256,256)
local tR=PurityOuterFrame:CreateTexture(nil,"BACKGROUND");tR:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight");tR:SetPoint("TOPLEFT",CharacterFrame,"TOPLEFT",frameOffsetX+256,frameOffsetY);tR:SetSize(128,256)
local bL=PurityOuterFrame:CreateTexture(nil,"BACKGROUND");bL:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomLeft");bL:SetPoint("TOPLEFT",CharacterFrame,"TOPLEFT",frameOffsetX,frameOffsetY-256);bL:SetSize(256,256)
local bR=PurityOuterFrame:CreateTexture(nil,"BACKGROUND");bR:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomRight");bR:SetPoint("TOPLEFT",CharacterFrame,"TOPLEFT",frameOffsetX+256,frameOffsetY-256);bR:SetSize(128,256)

local title_text = PurityOuterFrame:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
title_text:SetPoint("TOP", CharacterFrame, "TOP", 0, -44)
title_text:SetTextColor(1, 0.82, 0)
title_text:SetText("Purity Challenge")

local PurityContentFrame = AceGUI:Create("SimpleGroup")
PurityContentFrame:SetLayout("List")
PurityContentFrame.frame:SetParent(PurityPanel)
PurityContentFrame.frame:SetPoint("TOPLEFT", PurityOuterFrame, "TOPLEFT", 20, -30)
PurityContentFrame.frame:SetPoint("BOTTOMRIGHT", PurityOuterFrame, "BOTTOMRIGHT", -20, 75)

local PurityTabGUI = CreateFrame("Button", "PurityCharacterTab", CharacterFrame)
PurityTabGUI:SetFrameStrata("MEDIUM")

PurityTabGUI:SetWidth(60)
PurityTabGUI:SetHeight(45)

PurityTabGUI.text = PurityTabGUI:CreateFontString(nil, "OVERLAY")
PurityTabGUI.text:SetFontObject(GameFontNormalSmall)
PurityTabGUI.text:SetPoint("CENTER", 0, 1)
PurityTabGUI.text:SetText("Purity")

local activeTextures = {}
local inactiveTextures = {}

activeTextures.left = PurityTabGUI:CreateTexture(nil, "ARTWORK"); activeTextures.left:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab"); activeTextures.left:SetSize(20, 32); activeTextures.left:SetTexCoord(0, 0.3125, 0, 1); activeTextures.left:SetPoint("TOPLEFT", 0, -2); activeTextures.left:Hide()
activeTextures.right = PurityTabGUI:CreateTexture(nil, "ARTWORK"); activeTextures.right:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab"); activeTextures.right:SetSize(20, 32); activeTextures.right:SetTexCoord(1 - 0.3125, 1, 0, 1); activeTextures.right:SetPoint("TOPRIGHT", 0, -2); activeTextures.right:Hide()
activeTextures.middle = PurityTabGUI:CreateTexture(nil, "ARTWORK"); activeTextures.middle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-ActiveTab"); activeTextures.middle:SetTexCoord(0.3125, 1 - 0.3125, 0, 1); activeTextures.middle:SetPoint("TOPLEFT", activeTextures.left, "TOPRIGHT"); activeTextures.middle:SetPoint("BOTTOMRIGHT", activeTextures.right, "BOTTOMLEFT"); activeTextures.middle:Hide()

inactiveTextures.left = PurityTabGUI:CreateTexture(nil, "ARTWORK"); inactiveTextures.left:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab"); inactiveTextures.left:SetSize(20, 32); inactiveTextures.left:SetTexCoord(0, 0.3125, 0, 1); inactiveTextures.left:SetPoint("TOPLEFT", 0, -6)
inactiveTextures.right = PurityTabGUI:CreateTexture(nil, "ARTWORK"); inactiveTextures.right:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab"); inactiveTextures.right:SetSize(20, 32); inactiveTextures.right:SetTexCoord(1 - 0.3125, 1, 0, 1); inactiveTextures.right:SetPoint("TOPRIGHT", 0, -6)
inactiveTextures.middle = PurityTabGUI:CreateTexture(nil, "ARTWORK"); inactiveTextures.middle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-InactiveTab"); inactiveTextures.middle:SetTexCoord(0.3125, 1 - 0.3125, 0, 1); inactiveTextures.middle:SetPoint("TOPLEFT", inactiveTextures.left, "TOPRIGHT"); inactiveTextures.middle:SetPoint("BOTTOMRIGHT", inactiveTextures.right, "BOTTOMLEFT")

PurityTabGUI:SetHighlightTexture("Interface\\PaperDollInfoFrame\\UI-Character-Tab-Highlight")
PurityTabGUI:GetHighlightTexture():SetBlendMode("ADD")

function ShowCharacterPurity()
	for _, texture in pairs(activeTextures) do texture:Show() end
	for _, texture in pairs(inactiveTextures) do texture:Hide() end
	PurityTabGUI.text:SetFontObject(GameFontHighlightSmall)
	PurityTabGUI.text:SetPoint("CENTER", 0, 3)
	PurityTabGUI:SetFrameStrata("HIGH") -- Move to top layer
	PurityPanel:Show()
end

function HideCharacterPurity()
	for _, texture in pairs(activeTextures) do texture:Hide() end
	for _, texture in pairs(inactiveTextures) do texture:Show() end
	PurityTabGUI.text:SetFontObject(GameFontNormalSmall)
	PurityTabGUI.text:SetPoint("CENTER", 0, 1)
	PurityTabGUI:SetFrameStrata("MEDIUM") -- Return to normal layer
	PurityPanel:Hide()
end

hooksecurefunc(CharacterFrame, "Show", function()
    local anchorFrame = nil

    for i = 5, 1, -1 do
        local tab = _G["CharacterFrameTab" .. i]
        if tab and tab:IsShown() then
            anchorFrame = tab
            break
        end
    end

    if _G["HardcoreCharacterTab"] and _G["HardcoreCharacterTab"]:IsShown() then
        anchorFrame = _G["HardcoreCharacterTab"]
    end
    
    if anchorFrame then
        PurityTabGUI:ClearAllPoints()
        PurityTabGUI:SetPoint("LEFT", anchorFrame, "RIGHT", -10, 0)
    end

    PurityTabGUI:Show()
end)

hooksecurefunc(CharacterFrame, "Hide", function() PurityTabGUI:Hide() end)

PurityTabGUI:SetScript("OnClick", function()
	PaperDollFrame:Hide(); PetPaperDollFrame:Hide(); HonorFrame:Hide()
	SkillFrame:Hide(); ReputationFrame:Hide(); TokenFrame:Hide()
	
	for i=1, 5 do
		PanelTemplates_DeselectTab(_G["CharacterFrameTab"..i])
	end

    if _G.HideCharacterHC then _G.HideCharacterHC() end

	ShowCharacterPurity()
	UpdateCharacterPurity()
	CharacterFrame.activeTab = 9
end)

hooksecurefunc("PanelTemplates_SetTab", function(frame, id)
	if frame == CharacterFrame and id and id ~= 9 then
		if PurityPanel:IsShown() then
			HideCharacterPurity()
		end
	end
end)

function UpdateCharacterPurity()
	PurityContentFrame:ReleaseChildren()
	Purity:SilentRequestTimePlayed()
	C_Timer.After(0.2, function()
		local data = Purity:GetRawStatusData()
		if not data then return end
		local db = Purity:GetDB()
		if not db then return end
		local playerClass, class_en = UnitClass("player")
		local playerName = UnitName("player")
		local playerLevel = UnitLevel("player")
		local goldColor = "|cffffd100"; local whiteColor = "|cffffffff"; local greenColor = "|cff00ff00"; local redColor = "|cffff4444"
		local statusColor = greenColor
		if data.status == "Failed" then statusColor = redColor
		elseif data.status == "Not Participating" then statusColor = "|cff888888"
		elseif data.status == "Temporary Failure - Uptime" then statusColor = "|cffffff00" end
		local meta_data_container = AceGUI:Create("SimpleGroup"); meta_data_container:SetLayout("List"); meta_data_container:SetFullWidth(true)
		PurityContentFrame:AddChild(meta_data_container)
		local function CreateLabel(text, size, height)
			local label = AceGUI:Create("Label"); label:SetText(text); label:SetFont("Fonts\\FRIZQT__.TTF", size, "OUTLINE")
			label:SetJustifyH("CENTER"); label:SetFullWidth(true); label:SetHeight(height); meta_data_container:AddChild(label)
            return label
		end
		local classColorHex = CLASS_COLORS[class_en] or "FFFFFF"; local classColorStr = "|cff" .. classColorHex .. playerClass .. "|r"
		CreateLabel("", 1, 35); CreateLabel(whiteColor .. playerName, 18, 35); CreateLabel("Level " .. playerLevel .. " " .. classColorStr, 12, 20)
		CreateLabel("", 1, 20); CreateLabel("\nChallenge Status", 16, 40)
		CreateLabel(goldColor .. "Challenge:|r " .. whiteColor .. (data.challengeTitle or "None"), 12, 20)
		CreateLabel(goldColor .. "Status:|r " .. statusColor .. data.status .. "|r", 12, 20)
		local uptimeDisplay = string.format("%.2f%%", (data.totalPlayed > 0 and (data.addonRuntime / data.totalPlayed) * 100) or 0)
		CreateLabel(goldColor .. "Addon Uptime:|r " .. whiteColor .. uptimeDisplay, 12, 20)
		if data.startDate and data.startDate ~= "N/A" then CreateLabel(goldColor .. "Started:|r " .. whiteColor .. data.startDate, 12, 20) end
		CreateLabel("", 1, 20); CreateLabel("\nGameplay Modifiers", 16, 40)
		local hcText = db.isHardcoreRun and (greenColor .. "ACTIVE") or (redColor .. "INACTIVE")
		CreateLabel(goldColor .. "Hardcore:|r " .. hcText .. "|r", 12, 20)
		local sfText = db.isSelfFoundRun and (greenColor .. "ACTIVE") or (redColor .. "INACTIVE")
		CreateLabel(goldColor .. "Self-Found:|r " .. sfText .. "|r", 12, 20)
		local ssfText = db.isSSFRun and (greenColor .. "ACTIVE") or (redColor .. "INACTIVE")
		CreateLabel(goldColor .. "Solo Self-Found:|r " .. ssfText .. "|r", 12, 20)
		
		local _, baseCoeff = Purity:GetCurrentChallengeInfo()
		local modifiers = Purity:GetGameplayModifiers()
		local multiplier = 1.0

		if modifiers.isHardcore then
			multiplier = multiplier * 2.0
		end
		if modifiers.isSelfFound then
			multiplier = multiplier * 1.5
		end
		if modifiers.isSSF then
			multiplier = multiplier * 2.0
		end
		
		local totalCoeff = baseCoeff * multiplier

		CreateLabel("", 1, 10)
		CreateLabel("\nLeaderboard Info", 16, 22)
        
		if totalCoeff == baseCoeff then
			local coeffLabel = CreateLabel(goldColor .. "Coefficient:|r " .. whiteColor .. string.format("%.2f", totalCoeff), 12, 16)
            coeffLabel.frame:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:AddLine("Score Calculation", 1, 1, 1)
                GameTooltip:AddLine(" ")
                local title = data.challengeTitle or "Challenge"
                GameTooltip:AddDoubleLine(title .. " Coefficient:", string.format("%.2f", baseCoeff), 1, 1, 1, 1, 1, 1)
                GameTooltip:Show()
            end)
            coeffLabel.frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
		else
			local baseLabel = CreateLabel(goldColor .. "Base Coefficient:|r " .. whiteColor .. string.format("%.2f", baseCoeff), 12, 16)
			local totalLabel = CreateLabel(goldColor .. "Total Coefficient:|r " .. whiteColor .. string.format("%.2f", totalCoeff), 12, 16)
            
            totalLabel.frame:SetScript("OnEnter", function(self)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:AddLine("Score Calculation", 1, 1, 1)
                GameTooltip:AddLine(" ")
                local title = data.challengeTitle or "Challenge"
                GameTooltip:AddDoubleLine(title .. " Coefficient:", string.format("%.2f", baseCoeff), 1, 1, 1, 1, 1, 1)
                if modifiers.isHardcore then GameTooltip:AddDoubleLine("Hardcore Modifier:", "x2.0", 1, 1, 1, 1, 1, 1) end
                if modifiers.isSelfFound then GameTooltip:AddDoubleLine("Self-Found Modifier:", "x1.5", 1, 1, 1, 1, 1, 1) end
                if modifiers.isSSF then GameTooltip:AddDoubleLine("Solo Self-Found Modifier:", "x2.0", 1, 1, 1, 1, 1, 1) end
                GameTooltip:AddLine(" ", 1, 1, 1, 1, 1, 1)
                GameTooltip:AddDoubleLine("Final Score:", string.format("%.2f", totalCoeff), 1, 0.82, 0, 1, 0.82, 0)
                GameTooltip:Show()
            end)
            totalLabel.frame:SetScript("OnLeave", function() GameTooltip:Hide() end)
		end
	end)
end