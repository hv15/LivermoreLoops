# this macro resolves `vers` files and builds different _versions_
# of a binary depeneding on the parameters of the vers file. This
# macro is very similar to the COMPILE_SAC2C_WITH_VER macro, but
# additionally generates a shell script which can be used to call the
# binary with the correct arguments/inputs preset.
MACRO (COMPILE_SAC2C_WITH_VER_RUNFILE name local_sac_modules sac2c_flags input)
    # Full source to the sac program.
    SET (src "${CMAKE_CURRENT_SOURCE_DIR}/${name}")
    # sac2c requires computes objectfiles relatively to the working directory
    # of the call to sac2c.
    GET_FILENAME_COMPONENT (dir "${CMAKE_CURRENT_BINARY_DIR}/${name}" DIRECTORY)
    GET_FILENAME_COMPONENT (namewe ${name} NAME_WE)

    SET (version_file "${CMAKE_CURRENT_SOURCE_DIR}/${namewe}.vers")
    IF (EXISTS "${version_file}")
        FILE (READ ${version_file} content)
        STRING (REPLACE "\n" ";" lines ${content})

        FOREACH (l ${lines})
            STRING (REGEX MATCH "([a-zA-Z_0-9]+)[ \t]*:[ \t]*(.*)" match ${l})
            IF (NOT match)
                MESSAGE (FATAL_ERROR 
                         "error while parsing version file ${version_file}:\n${l}")
            ENDIF ()
            SET (suffix "${CMAKE_MATCH_1}")
            STRING (REGEX REPLACE "[ \t]+" ";" flags "${CMAKE_MATCH_2}")
            SET (binary "${namewe}${suffix}")
            SET (new_flags ${sac2c_flags} ${flags})
            SAC2C_COMPILE_PROG_DEPS (${name} ${binary} "${version_file}" "${local_sac_modules}" "${new_flags}")
            ADD_CUSTOM_TARGET (runfile-${binary}-${TARGET} ALL
                COMMAND ${CMAKE_COMMAND}
                    -DBINARYNAME:STRING="${binary}"
                    -DBINARYPATH:PATH="${dir}"
                    -DTARGET:STRING="${TARGET}"
                    -DINPUTPATH:PATH="${CMAKE_CURRENT_SOURCE_DIR}/${input}"
                    -P "${CMAKE_SOURCE_DIR}/cmake/gen-run-file.cmake"
                DEPENDS "${dir}/${binary}"
                WORKING_DIRECTORY "${CMAKE_BINARY_DIR}")
        ENDFOREACH ()
    ELSE ()
            SET (binary "${namewe}-${TARGET}")
            SAC2C_COMPILE_PROG (${name} ${binary} "${local_sac_modules}" "${sac2c_flags}")
            ADD_CUSTOM_TARGET (runfile-${binary}-${TARGET} ALL
                COMMAND ${CMAKE_COMMAND}
                    -DBINARYNAME:STRING="${binary}"
                    -DBINARYPATH:PATH="${dir}"
                    -DTARGET:STRING="${TARGET}"
                    -DINPUTPATH:PATH="${CMAKE_CURRENT_SOURCE_DIR}/${input}"
                    -P "${CMAKE_SOURCE_DIR}/cmake/gen-run-file.cmake"
                DEPENDS "${dir}/${binary}"
                WORKING_DIRECTORY "${CMAKE_BINARY_DIR}")
    ENDIF ()
ENDMACRO ()
