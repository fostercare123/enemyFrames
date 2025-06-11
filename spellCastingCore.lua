local casts  = require('globals.spells.casts')
local buffs  = require('globals.spells.buffs')
local parser = require('globals.spells.parser')

_G.SPELLCASTINGCOREgetCast    = casts.getCast
_G.SPELLCASTINGCOREgetBuffs   = buffs.getAll
_G.SPELLCASTINGCOREgetPrioBuff= buffs.getPrio
-- parser handles COMBAT_LOG events, etc.