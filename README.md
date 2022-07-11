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


## rem, err = nanosleep( sec )

this function suspends execution of the calling thread until either `sec` seconds have elapsed or a signal is delivered to the thread and its action is to invoke a signal-catching function or to terminate the process.

if the call is interrupted by a signal handler, it returns the `rem` remaining seconds greater than `0`.

```lua
local nanosleep = require('nanosleep')
local rem, err = nanosleep(1.5) -- sleep for 1.5 seconds
print(rem, err) -- 0.0 nil
```

**Parameters**

- `sec:number`: seconds.

**Returns**

- `rem:number`: remaining seconds, or `nil` if an error other than `EINTR` occurs.
- `err:error`: error object.

