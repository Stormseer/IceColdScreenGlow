local function CreateEdge(parent, point, r, g, b, a)
    local f = CreateFrame("Frame", nil, parent)
    f:SetFrameStrata("BACKGROUND")

    local t = f:CreateTexture(nil, "BACKGROUND")
    t:SetAllPoints()
    t:SetTexture("Interface/Buttons/WHITE8x8")

    if point == "TOP" then
        f:SetPoint("TOPLEFT")
        f:SetPoint("TOPRIGHT")
        f:SetHeight(180)

        -- bottom -> top
        t:SetGradient(
            "VERTICAL",
            CreateColor(r, g, b, 0), -- bottom transparent
            CreateColor(r, g, b, a)  -- top opaque
        )

    elseif point == "BOTTOM" then
        f:SetPoint("BOTTOMLEFT")
        f:SetPoint("BOTTOMRIGHT")
        f:SetHeight(180)

        -- bottom -> top
        t:SetGradient(
            "VERTICAL",
            CreateColor(r, g, b, a), -- bottom opaque
            CreateColor(r, g, b, 0)  -- top transparent
        )

    elseif point == "LEFT" then
        f:SetPoint("TOPLEFT")
        f:SetPoint("BOTTOMLEFT")
        f:SetWidth(180)

        t:SetGradient(
            "HORIZONTAL",
            CreateColor(r, g, b, a), -- left opaque
            CreateColor(r, g, b, 0)  -- right transparent
        )

    elseif point == "RIGHT" then
        f:SetPoint("TOPRIGHT")
        f:SetPoint("BOTTOMRIGHT")
        f:SetWidth(180)

        t:SetGradient(
            "HORIZONTAL",
            CreateColor(r, g, b, 0), -- left transparent
            CreateColor(r, g, b, a)  -- right opaque
        )
    end

    return f
end


-- Root fullscreen container
local root = CreateFrame("Frame", nil, UIParent)
root:SetAllPoints(UIParent)
root:SetFrameStrata("BACKGROUND")
root:Show()

-- Glow color (tweak freely)
local r, g, b, a = 0.4, 0.9, 0.85, 0.45

CreateEdge(root, "TOP", r, g, b, a)
CreateEdge(root, "BOTTOM", r, g, b, a)
CreateEdge(root, "LEFT", r, g, b, a)
CreateEdge(root, "RIGHT", r, g, b, a)

root:Hide()

local SPELL_ID = 414658
local HIDE_DELAY = 6

local hideTimer -- handle so we can cancel/restart

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
eventFrame:SetScript("OnEvent", function(_, _, unit, _, spellID)
    if unit ~= "player" then
        return
    end

    if spellID ~= SPELL_ID then
        return
    end

    -- Show the glow
    root:Show()
    root:SetAlpha(1)

    -- Restart hide timer
    if hideTimer then
        hideTimer:Cancel()
    end

    hideTimer = C_Timer.NewTimer(HIDE_DELAY, function()
        root:Hide()
    end)
end)
