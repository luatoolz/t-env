# t.env: os env vars interface object
```lua
local t = require "t"
local env = t.env
```

To get env:
```lua
print(env.PATH)
```

To set default value for undefined env (does not set real env var):
```lua
env.MONGO_HOST = 'mongodb'
```
