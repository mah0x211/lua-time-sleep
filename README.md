# lua-nanosleep

[![test](https://github.com/mah0x211/lua-nanosleep/actions/workflows/test.yml/badge.svg)](https://github.com/mah0x211/lua-nanosleep/actions/workflows/test.yml)
[![codecov](https://codecov.io/gh/mah0x211/lua-nanosleep/branch/master/graph/badge.svg)](https://codecov.io/gh/mah0x211/lua-nanosleep)

suspend thread execution for an interval measured in nanoseconds.


## Installation

```
luarocks install nanosleep
```

## Error Handling

the following functions return the `error` object created by https://github.com/mah0x211/lua-errno module.


## rem, err = nanosleep( nsec )

this function suspends execution of the calling thread until either `nsec` nanoseconds have elapsed or a signal is delivered to the thread and its action is to invoke a signal-catching function or to terminate the process.

if the call is interrupted by a signal handler, it returns the `rem` remaining nanoseconds greater than `0`.

```lua
local nanosleep = require('nanosleep')
local rem, err = nanosleep(15*1e8) -- sleep for 1.5 seconds
print(rem, err) -- 0.0 nil
```

**Parameters**

- `nsec:integer`: nanoseconds.

**Returns**

- `rem:integer`: remaining nanoseconds, or `nil` if an error other than `EINTR` occurs.
- `err:error`: error object.


## rem, err = usleep( usec )

this function equivalent to `nanosleep(nsec * 1000)`.

```lua
local usleep = require('nanosleep.usleep')
local rem, err = usleep(15*1e5) -- sleep for 1.5 seconds
print(rem, err) -- 0.0 nil
```

**Parameters**

- `usec:integer`: microseconds.

**Returns**

- `rem:integer`: remaining microseconds, or `nil` if an error other than `EINTR` occurs.
- `err:error`: error object.


## rem, err = msleep( msec )

this function equivalent to `usleep(usec * 1000)`.

```lua
local msleep = require('nanosleep.msleep')
local rem, err = msleep(15*1e2) -- sleep for 1.5 seconds
print(rem, err) -- 0.0 nil
```

**Parameters**

- `msec:integer`: milliseconds.

**Returns**

- `rem:integer`: remaining milliseconds, or `nil` if an error other than `EINTR` occurs.
- `err:error`: error object.


## rem, err = sleep( sec )

this function equivalent to `msleep(msec * 1000)`.

```lua
local sleep = require('nanosleep.sleep')
local rem, err = sleep(1) -- sleep for 1 second
print(rem, err) -- 0.0 nil
```

**Parameters**

- `sec:integer`: seconds.

**Returns**

- `rem:integer`: remaining seconds, or `nil` if an error other than `EINTR` occurs.
- `err:error`: error object.

