-- Module: WSG UI
-- Displays and manages flag‐carrier icons and health in WSG.
-- Feel free to tweak tooltip text or layout here.

local WorldFrame      = WorldStateAlwaysUpFrame
local GameTooltip     = GameTooltip
local GetTime         = GetTime
local UnitFactionGroup= UnitFactionGroup
local UnitName        = UnitName
local SendChatMessage = SendChatMessage
local RGB             = RGB_FACTION_COLORS
local tlength         = tlength

local flagCarriers, fcHealth = {}, {}
local sentAnnouncement, healthWarnings = false, {10, 20, 40}
local nextAnnouncement = 0

-- create texts & buttons
local h = WorldFrame:CreateFontString(nil,'OVERLAY')
h:SetFontObject(GameFontNormalSmall)
h:SetTextColor(RGB_FACTION_COLORS['Alliance']['r'], RGB_FACTION_COLORS['Alliance']['g'], RGB_FACTION_COLORS['Alliance']['b'])
h:SetJustifyH'LEFT'
h:SetText('horde')

local hb = CreateFrame('Button', nil, WorldStateAlwaysUpFrame)
hb:SetFrameLevel(2)
hb:SetAllPoints(h)
hb:EnableMouse(true)


local hh = WorldStateAlwaysUpFrame:CreateFontString(nil, 'OVERLAY')
hh:SetFontObject(GameFontNormalSmall)
hh:SetJustifyH'RIGHT'
hh:SetPoint('LEFT', h, 'RIGHT', 5, 0)


local a = WorldStateAlwaysUpFrame:CreateFontString(nil, 'OVERLAY')
a:SetFontObject(GameFontNormalSmall)
a:SetTextColor(RGB_FACTION_COLORS['Horde']['r'], RGB_FACTION_COLORS['Horde']['g'], RGB_FACTION_COLORS['Horde']['b'])
a:SetJustifyH'LEFT'
a:SetText('alliance')

local ab = CreateFrame('Button', nil, WorldStateAlwaysUpFrame)
ab:SetFrameLevel(2)
ab:SetAllPoints(a)
ab:EnableMouse(true)


local ah = WorldStateAlwaysUpFrame:CreateFontString(nil, 'OVERLAY')
ah:SetFontObject(GameFontNormalSmall)
ah:SetJustifyH'RIGHT'
ah:SetPoint('LEFT', a, 'RIGHT', 5, 0)

-- handlers
local function OnEnter(self)
    local label = (self == hb) and h or a
    label:SetTextColor(.9,.9,.4)
    if label:GetText() ~= '' then
        GameTooltip:SetOwner(self,'ANCHOR_TOPRIGHT',-40,10)
        GameTooltip:SetText('Click to target '..label:GetText())
        GameTooltip:Show()
    end
end
local function OnLeave(self)
    local label = (self == hb) and h or a
    local f     = (label==a) and 'Horde' or 'Alliance'
    label:SetTextColor(RGB[f].r,RGB[f].g,RGB[f].b)
    GameTooltip:Hide()
end
local function OnClick(self)
    TargetByName(((self==hb) and h or a):GetText(), true)
end

hb:SetScript('OnEnter',  OnEnter)
hb:SetScript('OnLeave',  OnLeave)
hb:SetScript('OnClick',  OnClick)
ab:SetScript('OnEnter',  OnEnter)
ab:SetScript('OnLeave',  OnLeave)
ab:SetScript('OnClick',  OnClick)

WSGUIupdateFC = function(fc)
    flagCarriers = fc

    if flagCarriers['Alliance'] then
        a:SetText(flagCarriers['Alliance'])
    else
        a:SetText('')
        ah:SetText('')
        fcHealth['Alliance'] = nil
    end

    if flagCarriers['Horde'] then
        h:SetText(flagCarriers['Horde'])
    else
        h:SetText('')
        hh:SetText('')
        fcHealth['Horde'] = nil
    end
end

WSGUIupdateFChealth = function(unit)
    if not unit or not UnitIsPlayer(unit) then return end
    local who = UnitName(unit)
    if flagCarriers['Alliance']==who then
        fcHealth['Alliance']=Utils.round(UnitHealth(unit)*100/UnitHealthMax(unit),1)
        ah:SetText(fcHealth['Alliance']..'%')
    end
    if flagCarriers['Horde']==who then
        fcHealth['Horde']=Utils.round(UnitHealth(unit)*100/UnitHealthMax(unit),1)
        hh:SetText(fcHealth['Horde']..'%')
    end
    if ENEMYFRAMESPLAYERDATA.efcBGannouncement then
        -- low-health announce
        local f, x = UnitFactionGroup'player', (UnitFactionGroup'player'=='Alliance' and 'Horde' or 'Alliance')
        local now = GetTime()
        local pct = fcHealth[f] or 100
        for _,th in ipairs(healthWarnings) do
            if pct<th and now>nextAnnouncement then
                nextAnnouncement = now + 4
                SendChatMessage('EFC <'..th..'%!'..(flagCarriers[x] and ' Get ready!' or ''),'BATTLEGROUND')
                break
            end
        end
    end
end

WSGUIinit = function(insideBG)
    if insideBG then
        local hdb = _G['AlwaysUpFrame1DynamicIconButton']
        h:SetPoint('LEFT', hdb, 'RIGHT', 4, 2)
        h:Show()
        h:SetText('')
        hh:Show()
        hh:SetText('')

        local adb = _G['AlwaysUpFrame2DynamicIconButton']
        a:SetPoint('LEFT', adb, 'RIGHT', 4, 2)
        a:Show()
        a:SetText('')
        ah:Show()
        ah:SetText('')
    else
        h:Hide()
        hh:Hide()
        a:Hide()
        ah:Hide()
        flagCarriers = {}
    end
end