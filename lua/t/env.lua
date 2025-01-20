local t = t or require "t"
local ok = function(k) return type(k)=='string' and #k>0 end
local default, fallback = {}, {}

-- priority:
-- default: options explicitly set by user (PREFERRED)
-- os.getenv: os defaults
-- fallback: app/modules fallback defaults
return setmetatable({}, {
  __call = function(self, it) if type(it)=='table' then for k,v in pairs(it) do fallback[k]=v end end end,
  __newindex = function(self, k, v) if not ok(k) then return end
    if type(v)=='table' then
      fallback[string.lower(k)]=table(v)
    else
      default[k]=v and tostring(v)
    end
  end,
  __index = function(self, k) if not ok(k) then return nil end
    if k==string.lower(k) then
      local set = fallback[k]
      if type(set)=='table' then
        return set*function(x, n)
          local found = self[string.upper(table.concat({k,n},'_'))]
          return found or x, n end
      end
    end
    return os.getenv(k) or default[k] or fallback[k]
  end,
  __sub = function(self, it) if ok(it) then fallback[it]=nil end;
    if type(it)=='table' then for _,k in ipairs(it) do fallback[k]=nil end end
  end,
})