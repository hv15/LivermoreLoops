# This script creates a shell script to run a previously generated
# binary with the correct input file. This is for convience as
# sometimes the number of generated files can be large and it
# isn't immediately clear how to run things. The user can still pass
# flags to the binary through the script (the script copies all
# arguments to the binary).
#
# Parameters:
#   BINARYNAME   the name of the binary to call
#   BINARYPATH   the path to the binary to call
#   TARGET       build type of the binary
#   INPUTPATH    path to input file (for stdin)
#
IF (NOT BINARYNAME)
    MESSAGE (FATAL_ERROR "Missing binary name")
ENDIF ()

IF (NOT BINARYPATH)
    MESSAGE (FATAL_ERROR "Missing path to binary")
ENDIF ()

IF (NOT TARGET)
    MESSAGE (FATAL_ERROR "Missing target specification")
ENDIF ()

IF (NOT INPUTPATH)
    MESSAGE (FATAL_ERROR "Missing input file path")
ENDIF ()

SET (__filename "run-${BINARYNAME}-${TARGET}.sh")
FILE (WRITE "${__filename}"
    "#!/usr/bin/env bash\n${BINARYPATH}/${BINARYNAME} $@ < ${INPUTPATH}")

IF (UNIX) # we can set file permission
    EXECUTE_PROCESS (COMMAND chmod +x "${__filename}")
    MESSAGE (STATUS "Created file ${__filename}, call this to run binary ${BINARYNAME}")
ELSE ()
    MESSAGE (STATUS "Created file ${__filename}, use `sh` call the file to run binary ${BINARYNAME}")
ENDIF ()
