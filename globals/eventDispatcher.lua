local frame = CreateFrame('Frame')
local subs = {}

frame:SetScript('OnEvent', function(self, ev, ...)
    for _, fn in ipairs(subs[ev] or {}) do fn(...) end
end)

function frame:Subscribe(evt, fn)
    self:RegisterEvent(evt)
    subs[evt] = subs[evt] or {}
    table.insert(subs[evt], fn)
end

_G.EventDispatcher = frame
return frame
