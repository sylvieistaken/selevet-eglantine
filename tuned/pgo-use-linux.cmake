# SPDX-FileCopyrightText: Copyright 2026 Eden Emulator Project
# SPDX-License-Identifier: GPL-3.0-or-later

# Linux counterpart of pgo-use-cache.cmake. Clang (not clang-cl), same
# x86-64-v3 target and the Windows-trained profile. Hash mismatches are
# expected; the warning suppressions match the Windows cache.
set(PGO_FLAGS "-march=x86-64-v3 -mtune=generic -fprofile-use=${CMAKE_CURRENT_LIST_DIR}/eglantine.profdata -Wno-profile-instr-unprofiled -Wno-profile-instr-out-of-date -Wno-backend-plugin")
set(CMAKE_BUILD_TYPE Release CACHE STRING "")
set(CMAKE_C_COMPILER "clang" CACHE FILEPATH "")
set(CMAKE_CXX_COMPILER "clang++" CACHE FILEPATH "")
set(CMAKE_C_FLAGS "${PGO_FLAGS}" CACHE STRING "")
set(CMAKE_CXX_FLAGS "${PGO_FLAGS}" CACHE STRING "")
set(CMAKE_EXE_LINKER_FLAGS "-fuse-ld=lld -Wl,--thinlto-jobs=1" CACHE STRING "")
set(ENABLE_LTO ON CACHE BOOL "")
set(USE_FASTER_LINKER ON CACHE BOOL "")
set(BUILD_TESTING OFF CACHE BOOL "")
set(YUZU_TESTS OFF CACHE BOOL "")
set(YUZU_CMD OFF CACHE BOOL "")
set(YUZU_ROOM OFF CACHE BOOL "")
set(YUZU_ROOM_STANDALONE OFF CACHE BOOL "")
set(YUZU_USE_BUNDLED_SDL3 OFF CACHE BOOL "")
set(ENABLE_UPDATE_CHECKER OFF CACHE BOOL "")
set(USE_DISCORD_PRESENCE OFF CACHE BOOL "")
