# t.env: os env vars interface object
```lua
local t = require "t"
local env = t.env

print(env.PATH)               -- get env var

env.MONGO_HOST = 'mongodb'    -- set explicit default (do not set real env)
env.MONGO_HOST = nil          -- delete 
env[nil] = {'X', 'Y', 'Z'}    -- delete bulk

env({                         -- set module fallback defaults
  MY_APP  = 'myappserver',
  MY_DB   = 'test',
})

env.mongo = {                 -- use lowercase
  host = 'mongodb',           -- setting app fallback
  port = '27017',             -- numbers ok too but first found preferred
  user = true,                -- set keys without defaults to true
  pass = true,
}

local mongo_opts = env.mongo  -- got smallcased table with env vars
mongo_opts == {               -- ready to pass args
  host = 'varhost',
  port = '27017',
  user = 'gooduser',
  pass = 'goodpass',
}

_ = env - 'MY_APP'            -- remove app fallback
_ = env - {'MY_APP', 'MY_DB'} -- remove bulk
```

NOTE: deleting explicit DOES NOT DELETE fallback!

## priority
- explicit user defaults
- os.getenv
- fallback

## luarocks depends
- `t`

## test depends
- `busted`
- `luacheck`

## nginx notes
- `env APP;` options required in `nginx.conf`
