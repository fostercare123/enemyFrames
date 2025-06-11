local M = {}
-- round a number to idp decimal places
function M.round(num, idp)
    local mult = 10 ^ (idp or 0)
    return math.floor(num * mult + 0.5) / mult
end
-- return remaining time, 0 decimal if >3s else 1 decimal
function M.getTimerLeft(tEnd)
    local t = tEnd - GetTime()
    if t > 3 then
        return M.round(t, 0)
    else
        return M.round(t, 1)
    end
end
return M
