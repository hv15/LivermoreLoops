CMAKE_MINIMUM_REQUIRED (VERSION 3.3)
INCLUDE ("${CMAKE_SOURCE_DIR}/cmake-common/sac2c-variables.cmake")
INCLUDE ("${CMAKE_SOURCE_DIR}/cmake-common/resolve-sac2c-dependencies.cmake")
INCLUDE ("${CMAKE_SOURCE_DIR}/cmake-common/build-sac2c-program.cmake")
INCLUDE ("${CMAKE_SOURCE_DIR}/cmake-common/sac2c-prog-with-versions.cmake")

# SaC files relatively to this CMakeLists.txt.
SET (SAC_PROG_SRC
    loop08.sac
    loop08-split.sac
)

# For every sac file, compile Tree and Mod files.
FOREACH (name ${SAC_PROG_SRC})
    COMPILE_SAC2C_WITH_VER (${name} "" "${SAC2C_DEF_FLAGS}")
ENDFOREACH (name)


