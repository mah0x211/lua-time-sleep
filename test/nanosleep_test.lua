local assert = require('assert')
local clock_gettime = require('clock').gettime
local nanosleep = require('nanosleep')

local function test_nanosleep()
    -- test that sleep for a specified number of seconds
    local elapsed = clock_gettime()
    local res, err = nanosleep(1.5)
    elapsed = clock_gettime() - elapsed
    assert.equal(res, 0)
    assert.is_nil(err)
    assert.equal(math.floor(elapsed * 100), 150)

    -- test that negative seconds treat as 0
    elapsed = clock_gettime()
    res, err = nanosleep(-1.5)
    elapsed = clock_gettime() - elapsed
    assert.equal(res, 0)
    assert.is_nil(err)
    assert.equal(math.floor(elapsed * 100), 0)

    -- test that throws an error if seconds is negative number
    err = assert.throws(nanosleep, '1.5')
    assert.match(err, 'number expected,')
end

for name, f in pairs({
    test_nanosleep = test_nanosleep,
}) do
    local ok, err = xpcall(f, debug.traceback)
    if ok then
        print(('%s: ok'):format(name))
    else
        print(('%s: failed'):format(name))
        print(err)
    end
end
