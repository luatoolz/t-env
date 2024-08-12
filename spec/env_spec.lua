describe("env", function()
  local t, env
  setup(function()
    t = require "t"
    env = t.env
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
    assert.type('t/env', t.env)
  end)
end)
