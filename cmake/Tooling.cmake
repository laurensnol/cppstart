function(cppstart_enable_tooling)
  message(STATUS "Enabling tooling for targets ${ARGN}")

  set(CPPSTART_CLANG_TIDY_PROPERTIES "")
  find_program(CLANG_TIDY_PROGRAM clang-tidy)
  if(CLANG_TIDY_PROGRAM)
    list(APPEND CPPSTART_CLANG_TIDY_PROPERTIES
      ${CLANG_TIDY_PROGRAM}
      "-p=${PROJECT_BINARY_DIR}"
      "-header-filter=.*"
      "--warnings-as-errors=*")
    message(STATUS "Enabled clang-tidy")
  else()
    message(STATUS "clang-tidy not found")
  endif()

  set(CPPSTART_CPPCHECK_PROPERTIES "")
  find_program(CPPCHECK_PROGRAM cppcheck)
  if(CPPCHECK_PROGRAM)
    # Suppress "unusedFunction" here to avoid false positives since cppcheck
    # will check every file individually. Truly unused functions will be caught
    # by clang-tidy.
    list(APPEND CPPSTART_CPPCHECK_PROPERTIES
      ${CPPCHECK_PROGRAM}
      "--quiet"
      "--enable=all"
      "--suppress=missingIncludeSystem"
      "--suppress=unusedFunction"
      "--suppress=unmatchedSuppression"
      "--suppress=checkersReport"
      "--inline-suppr")
    message(STATUS "Enabled cppcheck")
  else()
    message(STATUS "cppcheck not found")
  endif()

  set(CPPSTART_IWYU_PROPERTIES "")
  find_program(IWYU_PROGRAM include-what-you-use)
  if(IWYU_PROGRAM)
    set(CPPSTART_IWYU_PROPERTIES "${IWYU_PROGRAM};-Xiwyu;")
    message(STATUS "Enabled include-what-you-use")
  else()
    message(STATUS "include-what-you-use not found")
  endif()

  set(CPPSTART_CCACHE_PROPERTIES "")
  find_program(CCACHE_PROGRAM ccache)
  if(CCACHE_PROGRAM)
    list(APPEND CPPSTART_CCACHE_PROPERTIES
      ${CCACHE_PROGRAM})
    message(STATUS "Enabled Ccache")
  else()
    message(STATUS "Ccache not found")
  endif()

  foreach(target ${ARGN})
    set_target_properties(${target} PROPERTIES
      CXX_CLANG_TIDY           "${CPPSTART_CLANG_TIDY_PROPERTIES}"
      CXX_CPPCHECK             "${CPPSTART_CPPCHECK_PROPERTIES}"
      CXX_INCLUDE_WHAT_YOU_USE "${CPPSTART_IWYU_PROPERTIES}"
      CXX_COMPILER_LAUNCHER    "${CPPSTART_CCACHE_PROPERTIES}")
  endforeach()
endfunction()

