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
      fallback[string.lower(k)]=v
    elseif type(k)=='string' then
      if type(v)=='nil' then
        if string.lower(k)==k then
          fallback[k]=nil
          fallback[string.upper(k)]=nil
          local p = k:upper()..'_'
          for kf in table.keys(fallback) do if kf:startswith(p) then fallback[kf]=nil end end
        end
        if string.upper(k)==k then
          default[k]=nil
        end
      else
        default[k]=v and tostring(v)
      end
    end
  end,
  __index = function(self, k) if not ok(k) then return nil end
    if k==string.lower(k) then
      local set = fallback[k]
      if type(set)=='table' then
        return setmetatable(table.map(set,function(x, n)
          if x==true then x=nil end
          local found = self[string.upper(table.concat({k,n},'_'))]
          return found or x, n
        end), nil)
      end
    end
    local tab, it = string.match(string.lower(k), '^([^%_]+)%_?(.*)$')
    local rv = os.getenv(k) or default[k] or fallback[k] or (fallback[tab] or {})[it]
    return type(rv)~='boolean' and rv or nil
  end,
  __sub = function(self, it) if ok(it) then fallback[it]=nil end;
    if type(it)=='table' then for _,k in ipairs(it) do fallback[k]=nil end end
  end,
})