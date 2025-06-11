local frame = CreateFrame('Frame')
local handlers = {}

frame:SetScript('OnUpdate', function(self, elapsed)
    for _, h in ipairs(handlers) do h(elapsed) end
end)

local M = {}
function M.Add(fn) table.insert(handlers, fn) end

_G.Poller = M
return M
