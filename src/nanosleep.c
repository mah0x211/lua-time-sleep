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
#include <errno.h>
#include <time.h>
// lua
#include <lauxhlib.h>
#include <lua_errno.h>

static int nanosleep_lua(lua_State *L)
{
    lua_Number sec = lauxh_checknumber(L, 1);

    if (sec > 0) {
        lua_Integer tv_sec = sec;
        struct timespec ts = {
            .tv_sec  = tv_sec,
            .tv_nsec = (sec - (lua_Number)tv_sec) * 1e9,
        };
        struct timespec rem = {0};

        if (nanosleep(&ts, &rem) == 0) {
            lua_pushnumber(L, 0);
            return 1;
        } else if (errno == EINTR) {
            lua_pushnumber(L, (double)rem.tv_sec + ((double)rem.tv_nsec / 1e9));
            return 1;
        }
        lua_pushnumber(L, sec);
        lua_errno_new(L, errno, "nanosleep");
        return 2;
    }

    lua_pushnumber(L, 0);
    return 1;
}

LUALIB_API int luaopen_nanosleep(lua_State *L)
{
    lua_errno_loadlib(L);
    lua_pushcfunction(L, nanosleep_lua);
    return 1;
}
