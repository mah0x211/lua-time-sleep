local testcase = require('testcase')
local assert = require('assert')
local new_timer = require('testcase.timer').new
local nanosleep = require('time.sleep.nanosleep')
local usleep = require('time.sleep.usleep')
local msleep = require('time.sleep.msleep')
local sleep = require('time.sleep')

function testcase.nanosleep()
    -- test that sleep for a specified number of seconds
    local timer = new_timer()
    timer:start()
    local res, err = nanosleep(10 * 1000 * 1000)
    local elapsed = timer:elapsed_sec()
    assert.equal(res, 0)
    assert.is_nil(err)
    assert.greater(elapsed, 0.01)
    assert.less(elapsed, 0.015)

    -- test that negative seconds treat as 0
    timer:reset()
    timer:start()
    res, err = nanosleep(-1)
    elapsed = timer:elapsed_sec()
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
    local timer = new_timer()
    timer:start()
    local res, err = usleep(10 * 1000)
    local elapsed = timer:elapsed_sec()
    assert.equal(res, 0)
    assert.is_nil(err)
    assert.greater(elapsed, 0.01)
    assert.less(elapsed, 0.015)
end

function testcase.msleep()
    -- test that sleep for a specified number of seconds
    local timer = new_timer()
    timer:start()
    local res, err = msleep(10)
    local elapsed = timer:elapsed_sec()
    assert.equal(res, 0)
    assert.is_nil(err)
    assert.greater(elapsed, 0.01)
    assert.less(elapsed, 0.015)
end

function testcase.sleep()
    -- test that sleep for a specified number of seconds
    local timer = new_timer()
    timer:start()
    local res, err = sleep(1)
    local elapsed = timer:elapsed_sec()
    assert.equal(res, 0)
    assert.is_nil(err)
    assert.greater(elapsed, 1)
    assert.less(elapsed, 1.05)
end

