local glowStart = 9
local glowEnd = 15
local LCG = LibStub("LibCustomGlow-1.0")

local arcaneSurgeSpellID = 365350

local function showGlow()
    for _, CdFrame in pairs({EssentialCooldownViewer:GetChildren()}) do
        LCG.ProcGlow_Start(CdFrame)
    end
end

local function hideGlow()
    for _, CdFrame in pairs({EssentialCooldownViewer:GetChildren()}) do
        LCG.ProcGlow_Stop(CdFrame)
    end
end


local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
eventFrame:SetScript("OnEvent", function(_, _, unit, _, spellID)
    if unit ~= "player" then
        return
    end

    if spellID ~= arcaneSurgeSpellID then
        return
    end

    C_Timer.NewTimer(glowStart, function()
        showGlow()
    end)

    C_Timer.NewTimer(glowEnd, function()
        hideGlow()
    end)
end)
