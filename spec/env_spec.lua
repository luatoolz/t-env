describe("env", function()
  local meta, t, env
  setup(function()
    meta = require "meta"
    t = require "t"
    env = t.env
  end)
  it("SHELL", function()
--    assert.is_string(env.SHELL)
  end)
  it("default", function()
    assert.is_nil(env.NONEEXISTENT)
    env.NONEEXISTENT = "NONE_EXISTENT_DEFAULT"
    assert.equal("NONE_EXISTENT_DEFAULT", env.NONEEXISTENT)
    assert.is_nil(rawget(env, 'NONEEXISTENT'))
    env.NONEEXISTENT = nil
    assert.is_nil(env.NONEEXISTENT)
  end)
  it("is.typed", function()
    assert.is_string(t.is.typed(t.env))
  end)
end)
