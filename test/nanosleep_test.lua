local assert = require('assert')
local clock_gettime = require('clock').gettime
local nanosleep = require('nanosleep')
local usleep = require('nanosleep.usleep')

local testcase = {}

function testcase.nanosleep()
    -- test that sleep for a specified number of seconds
    local elapsed = clock_gettime()
    local res, err = nanosleep(10 * 1000 * 1000)
    elapsed = clock_gettime() - elapsed
    assert.equal(res, 0)
    assert.is_nil(err)
    assert.greater(elapsed, 0.01)
    assert.less(elapsed, 0.015)

    -- test that negative seconds treat as 0
    elapsed = clock_gettime()
    res, err = nanosleep(-1)
    elapsed = clock_gettime() - elapsed
    assert.equal(res, 0)
    assert.is_nil(err)
    elapsed = elapsed
    assert.less(elapsed, 0.0001)

    -- test that throws an error if seconds is negative number
    err = assert.throws(nanosleep, '1.5')
    assert.match(err, 'number expected,')
end

function testcase.usleep()
    -- test that sleep for a specified number of seconds
    local elapsed = clock_gettime()
    local res, err = usleep(10 * 1000)
    elapsed = clock_gettime() - elapsed
    assert.equal(res, 0)
    assert.is_nil(err)
    assert.greater(elapsed, 0.01)
    assert.less(elapsed, 0.015)
end

for _, name in ipairs({
    'nanosleep',
    'usleep',
}) do
    local ok, err = xpcall(testcase[name], debug.traceback)
    if ok then
        print(('%s: ok'):format(name))
    else
        print(('%s: failed'):format(name))
        print(err)
    end
end
