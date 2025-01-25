describe("env", function()
  local t, env
  setup(function()
    t = require "t"
    env = t.env
    env.mongo = nil
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
    assert.is_nil(env.MONGO_HOST)
    assert.is_nil(env.MONGO_PASS)
    env.MONGO_PASS='some_pass'
    assert.equal('some_pass', env.MONGO_PASS)
    local options = {
      host = 'mongodb',
      port = '27017',
      db   = 'db',
      user = true,
      pass = true,
    }
    env.mongo = options
    assert.same({
      host = 'mongodb',
      port = '27017',
      db   = 'db',
      user = 'semiuser',
      pass = 'some_pass',
    }, env.mongo)
    assert.not_equal(options, env.mongo)
    assert.same({
      host = 'mongodb',
      port = '27017',
      db   = 'db',
      user = 'semiuser',
      pass = 'some_pass',
    }, env.mongo)
    assert.equal('mongodb', env.MONGO_HOST)
    assert.equal('27017', env.MONGO_PORT)
    env.mongo = nil
    env.MONGO_PASS=nil
  end)
  it("module setup with numbers", function()
    assert.is_nil(env.MONGO_HOST)
    env.mongo = {
      host = 'mongodb',
      port = 27017,
      db   = 'db',
      user = true,
      pass = true,
    }
    assert.same({
      db = 'db',
      host = 'mongodb',
      port = 27017,
      user = 'semiuser',
    }, env.mongo)
    assert.equal('mongodb', env.MONGO_HOST)
    assert.equal(27017, env.MONGO_PORT)
    env.mongo = nil
  end)
end)