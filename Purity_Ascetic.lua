-- Purity AddOn - The Ascetic's Path Challenge

if not Purity then return end

local DIFFICULTY_COLORS = {
    EASY = "|cff0070dd",
    MEDIUM = "|cffa335ee",
    HARD = "|cffff8000"
}

local AsceticModule = {
    challengeName = "The Ascetic's Path",
    description = "A challenge of self-denial. You must limit your reliance on material possessions, choosing a path of increasing difficulty to prove your conviction.",
    isGlobalChallenge = true,
    needsWeaponWarning = false,

    specializations = {
        {
            name = "Path of Humility",
            buttonText = "Path of Humility",
            id = "EASY",
            description = "Only items of Common (white) quality or lower may be equipped.",
            IsItemForbidden = function(itemLink)
                if not itemLink then return false end
                local _, _, itemRarity, _, _, itemType = GetItemInfo(itemLink)
                
                if itemType ~= "Armor" and itemType ~= "Weapon" then
                    return false
                end
                
                return itemRarity and itemRarity > 1
            end
        },
        {
            name = "Path of Resilience",
            buttonText = "Path of Resilience",
            id = "MEDIUM",
            description = "No armor may be worn. Weapons and shields are permitted.",
            IsItemForbidden = function(itemLink)
                if not itemLink then return false end
                local _, _, _, _, _, itemType = GetItemInfo(itemLink)

                return itemType == "Armor"
            end
        },
        {
            name = "Path of the Unburdened",
            buttonText = "Path of the Unburdened",
            id = "HARD",
            description = "No items may be equipped whatsoever. You must face the world with nothing.",
            IsItemForbidden = function(itemLink)
                if not itemLink then return false end
                
                local _, _, _, _, _, itemType, _, _, equipSlot = GetItemInfo(itemLink)

                if itemType == "Armor" or itemType == "Weapon" then
                    return true
                end

                if equipSlot and equipSlot ~= "INVTYPE_NON_EQUIP" then
                    return true
                end

                return false
            end
        }
    },
    
    selectedDifficultyId = nil
}

function AsceticModule:isWeaponAllowed(itemLink)
    local difficulty = self.selectedDifficultyId
    if not difficulty and Purity.tempSelectedSpec and Purity.tempSelectedSpec.id then
        difficulty = Purity.tempSelectedSpec.id
    end

    if difficulty == "HARD" then
        return false
    end

    return true
end

function AsceticModule:IsItemForbidden(itemLink)
    if not self.selectedDifficultyId then
        if Purity.tempSelectedSpec and Purity.tempSelectedSpec.id then
            self.selectedDifficultyId = Purity.tempSelectedSpec.id
        else
            self.selectedDifficultyId = "EASY"
        end
    end

    for _, spec in ipairs(self.specializations) do
        if spec.id == self.selectedDifficultyId then
            return spec.IsItemForbidden(itemLink)
        end
    end
    
    return self.specializations[3].IsItemForbidden(itemLink)
end

function AsceticModule:GetRulesText()
    local currentDifficultyId = self.selectedDifficultyId

    if Purity.optInFrame and Purity.optInFrame:IsShown() and Purity.tempSelectedSpec then
        currentDifficultyId = Purity.tempSelectedSpec.id
    end

    local selectedSpec = self.specializations[1]
    for _, spec in ipairs(self.specializations) do
        if spec.id == currentDifficultyId then
            selectedSpec = spec
            break
        end
    end
    
    local difficultyColor = DIFFICULTY_COLORS[selectedSpec.id] or "|cff261A0D"

    return {
        "|cffffd100Selected Path:|r",
        difficultyColor .. (selectedSpec.name or "None") .. "|r",
        " ",
        "|cffffd100Rule:|r",
        difficultyColor .. "• " .. (selectedSpec.description or "Select a difficulty to see its rules.") .. "|r",
        " ",
        "|cffffd100Challenge Conditions:|r",
        "|cff261A0D  • Must be started on a level 1 character of ANY class.|r",
        "|cff261A0D  • Must be accepted before leveling to 2.|r",
        "|cff261A0D  • An uptime of at least 96.0% must be maintained.|r",
    }
end

function AsceticModule:GetChallengeSpecifier()
    return self.selectedDifficultyId or nil
end

function AsceticModule:InitializeOnPlayerEnterWorld()
    local db = Purity:GetDB()
    if not db.asceticChallengeData then
        db.asceticChallengeData = {}
    end
    self.selectedDifficultyId = db.asceticChallengeData.difficulty
    self.needsWeaponWarning = (self.selectedDifficultyId == "HARD")
end

function AsceticModule:SaveData()
    local db = Purity:GetDB()
    db.asceticChallengeData = db.asceticChallengeData or {}
    if Purity.tempSelectedSpec and Purity.tempSelectedSpec.id then
        db.asceticChallengeData.difficulty = Purity.tempSelectedSpec.id
        self.selectedDifficultyId = Purity.tempSelectedSpec.id
    end
    self.needsWeaponWarning = (db.asceticChallengeData.difficulty == "HARD")
end

Purity.GlobalModules = Purity.GlobalModules or {}
Purity.GlobalModules.ASCETIC = AsceticModule