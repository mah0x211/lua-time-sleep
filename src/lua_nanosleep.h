/**
 * Copyright (C) 2022 Masatoshi Fukunaga
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to
 * deal in the Software without restriction, including without limitation the
 * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
 * sell copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
 * IN THE SOFTWARE.
 */

#ifndef lua_nanosleep_h
#define lua_nanosleep_h

#include <errno.h>
#include <math.h>
#include <time.h>
// lua
#include <lauxhlib.h>
#include <lua_errno.h>
#include <sys/time.h>

#define NSEC 1
#define USEC (NSEC * 1000)
#define MSEC (USEC * 1000)
#define SEC  (MSEC * 1000)

static inline int nsleep_lua(lua_State *L, int64_t unit)
{
    int64_t sec = lauxh_checknumber(L, 1) * unit;

    if (sec > 0) {
        struct timespec ts = {
            .tv_sec  = sec / SEC,
            .tv_nsec = sec % SEC,
        };
        struct timespec rem = {0};

        if (nanosleep(&ts, &rem) == 0) {
            lua_pushinteger(L, 0);
            return 1;
        } else if (errno == EINTR) {
            lua_pushinteger(L,
                            llround((double)(rem.tv_sec * SEC + rem.tv_nsec) /
                                    (double)unit));
            return 1;
        }
        lua_pushnil(L);
        lua_errno_new(L, errno, "nanosleep");
        return 2;
    }

    lua_pushinteger(L, 0);
    return 1;
}

#endif
