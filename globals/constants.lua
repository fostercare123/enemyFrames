-- Module: Constants
-- Edit these values to tweak sizes, timings, and thresholds.

local M = {
  -- Refresh intervals
  refreshRate          = 1/60,
  announcementInterval = 4,
  -- Health warnings (percent)
  healthThresholds     = {10, 20, 40},

  -- UI dimensions
  flagIconSize         = 36,
  castBarWidth         = 160,
  castBarHeight        = 10,
  borderDefaultPadding = 2.5,
  borderTCut           = 1/4.2,
}

_G.EF_CONST = M
return M
