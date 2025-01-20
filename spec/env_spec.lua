describe("env", function()
  local t, env
  setup(function()
    t = require "t"
    env = t.env
    t.env.MONGO_PASS='some_pass'
  end)
  it("PATH", function()
    assert.is_string(env.PATH)
  end)
  it("default", function()
    assert.is_nil(env.NONEEXISTENT)

    env({NONEEXISTENT='fallback'})
    assert.equal("fallback", env.NONEEXISTENT)

    env.NONEEXISTENT = "NONE_EXISTENT_DEFAULT"
    assert.equal("NONE_EXISTENT_DEFAULT", env.NONEEXISTENT)
    assert.is_nil(rawget(env, 'NONEEXISTENT'))

    env.NONEEXISTENT = nil
    assert.equal("fallback", env.NONEEXISTENT)

    local _ = env - {'NONEEXISTENT'}
    assert.is_nil(env.NONEEXISTENT)
  end)
  it("is.type", function()
    assert.type('env', t.env)
  end)
  it("module setup with strings", function()
    env.mongo = {
      host = 'mongodb',
      port = true,
      db   = 'db',
      user = true,
      pass = true,
      xport = '27017',
    }
    assert.same({
      db = 'db',
      host = 'mongodb',
      port = '27017',
      user = 'semiuser',
      pass = 'some_pass',
      xport = '27017',
    }, env.mongo)
  end)
  it("module setup with numbers", function()
    env.mongo = {
      host = 'mongodb',
      port = true,
      db   = 'db',
      user = true,
      pass = true,
      xport = 27017,
    }
    assert.same({
      db = 'db',
      host = 'mongodb',
      port = '27017',
      user = 'semiuser',
      pass = 'some_pass',
      xport = 27017,
    }, env.mongo)
  end)
end)