CMAKE_MINIMUM_REQUIRED (VERSION 3.3)
INCLUDE ("${CMAKE_SOURCE_DIR}/cmake-common/sac2c-variables.cmake")
INCLUDE ("${CMAKE_SOURCE_DIR}/cmake-common/resolve-sac2c-dependencies.cmake")
INCLUDE ("${CMAKE_SOURCE_DIR}/cmake-common/build-sac2c-program.cmake")
INCLUDE ("${CMAKE_SOURCE_DIR}/cmake/sac2c-prog-vers-runfile.cmake")

# SaC files relatively to this CMakeLists.txt.
SET (SAC_PROG_SRC
    loop05.sac
)

# For every sac file, compile Tree and Mod files.
FOREACH (name ${SAC_PROG_SRC})
    COMPILE_SAC2C_WITH_VER_RUNFILE (${name} "" "${SAC2C_DEF_FLAGS}" "loop05.inp")
ENDFOREACH (name)


