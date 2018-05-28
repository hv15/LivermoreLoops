CMAKE_MINIMUM_REQUIRED (VERSION 3.3)

PROJECT (sac-LivermoreLoops)

# Where the compiled sac modules result
SET (DLL_BUILD_DIR  "${PROJECT_BINARY_DIR}/lib")

# For what targets we build modules
SET (TARGETS            seq mt_pth  CACHE STRING "Build stdlib-jpeg for these targets")
SET (SAC2C_EXEC                     CACHE STRING "A path to sac2c compiler")
SET (LINKSETSIZE        "0"         CACHE STRING "Set a value for -linksetsize parameter of sac2c")

# Check whether sac2c is operational
INCLUDE ("cmake-common/check-sac2c.cmake")
INCLUDE ("cmake-common/misc-macros.cmake")

# The old Makefile had SAC2CFLAGS set to "-O3 -v1 -maxlur 3"
# We port -O3 and -maxlur 3, but we use -v0
SET (SAC2C_DEF_FLAGS -v0 -O3 -maxlur 3 -linksetsize ${LINKSETSIZE} -L ${DLL_BUILD_DIR} -T ${DLL_BUILD_DIR})

# For every target run CMakeLists.txt in src
FOREACH (TARGET IN ITEMS ${TARGETS})
    ADD_SUBDIRECTORY (loop01   loop01-${TARGET})
    ADD_SUBDIRECTORY (loop02   loop02-${TARGET})
    ADD_SUBDIRECTORY (loop03   loop03-${TARGET})
    ADD_SUBDIRECTORY (loop04   loop04-${TARGET})
    ADD_SUBDIRECTORY (loop05   loop05-${TARGET})
    ADD_SUBDIRECTORY (loop06   loop06-${TARGET})
ENDFOREACH ()
