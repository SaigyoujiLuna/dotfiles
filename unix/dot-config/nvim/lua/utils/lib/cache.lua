local Set = require("utils/lib/set")

---@class yukivim.utils.lib.Cache
---@field private sets table<integer, yukivim.utils.lib.Set?>
local Cache = {}
Cache.__index = Cache

---@return yukivim.utils.lib.Cache
function Cache.new()
    local self = setmetatable({}, Cache)
    self.sets = {}
    return self
end

---@param buf integer
---@return yukivim.utils.lib.Set
function Cache:get(buf)
    if not self.sets[buf] then
        self.sets[buf] = Set.new()
    end
    return self.sets[buf]
end

return Cache

