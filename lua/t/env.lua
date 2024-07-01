local t = require "t"
local default = {}

return setmetatable({}, {
  __newindex = function(self, k, v)
    if k then
      default[k]=v
    end
  end,
  __index = function(self, k)
    if k then
      return os.getenv(k) or default[k]
    end
  end
})
