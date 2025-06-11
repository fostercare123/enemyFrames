local M = {}

-- checkbox factory
function M.CheckBox(parent, x, y, id, label, color, onClick)
    local cb = CreateFrame('CheckButton', nil, parent, 'UICheckButtonTemplate')
    cb:SetPoint('TOPLEFT', parent, 'TOPLEFT', x, y)
    cb.id = id
    cb:SetScript('OnClick', function() onClick(cb:GetChecked()) end)
    local txt = _G[cb:GetName()..'Text']
    txt:SetText(label); txt:SetTextColor(color.r, color.g, color.b, .9)
    return cb
end

-- slider factory
function M.Slider(parent, x, y, lowText, highText, min, max, step, color, onChange)
    local s = CreateFrame('Slider', nil, parent, 'OptionsSliderTemplate')
    s:SetPoint('TOPLEFT', parent, 'TOPLEFT', x, y)
    s:SetMinMaxValues(min, max); s:SetValueStep(step)
    _G[s:GetName()..'Low']:SetText(lowText); _G[s:GetName()..'Low']:SetTextColor(color.r, color.g, color.b, .9)
    _G[s:GetName()..'High']:SetText(highText); _G[s:GetName()..'High']:SetTextColor(color.r, color.g, color.b, .9)
    s:SetScript('OnValueChanged', function() onChange(s:GetValue()) end)
    return s
end

_G.UIFactory = M
return M
