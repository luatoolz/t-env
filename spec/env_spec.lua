describe("env", function()
  local t, env
  setup(function()
    t = require 't'
    env = t.env
--    env.test = nil
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
    assert.is_nil(env.TEST_HOST)
    assert.is_nil(env.TEST_PASS)
    env.TEST_PASS='some_pass'
    env.TEST_USER='semiuser'
    assert.equal('some_pass', env.TEST_PASS)
    local options = {
      host = 'testdb',
      port = '27017',
      db   = 'db',
      user = true,
      pass = true,
    }
    env.test = options
    assert.same({
      host = 'testdb',
      port = '27017',
      db   = 'db',
      user = 'semiuser',
      pass = 'some_pass',
    }, env.test)
    assert.not_equal(options, env.test)
    assert.same({
      host = 'testdb',
      port = '27017',
      db   = 'db',
      user = 'semiuser',
      pass = 'some_pass',
    }, env.test)
    assert.equal('testdb', env.TEST_HOST)
    assert.equal('27017', env.TEST_PORT)
    env.test = nil
    env.TEST_PASS=nil
  end)
  it("module setup with numbers", function()
    assert.is_nil(env.TEST_HOST)
    env.test = {
      host = 'testdb',
      port = 27017,
      db   = 'db',
      user = true,
      pass = true,
    }
    assert.same({
      db = 'db',
      host = 'testdb',
      port = 27017,
      user = 'semiuser',
    }, env.test)
    assert.equal('testdb', env.TEST_HOST)
    assert.equal(27017, env.TEST_PORT)
    env.test = nil
  end)
--  it("load from files", function()
--    local iter = t.iter
--    assert.equal('', t.env.one)
--    assert.equal('', iter.map(env,tostring))
--  end)
end)