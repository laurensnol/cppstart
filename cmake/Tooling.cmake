set(CLANG_TIDY_PROPERTIES "")
find_program(CLANG_TIDY_PROGRAM clang-tidy)
if(CLANG_TIDY_PROGRAM)
  list(APPEND CLANG_TIDY_PROPERTIES
    ${CLANG_TIDY_PROGRAM}
    "-p=${PROJECT_BINARY_DIR}"
    "-header-filter=.*"
    "--warnings-as-errors=*")
  message(STATUS "Enabled clang-tidy")
else()
  message(STATUS "clang-tidy not found")
endif()

set(CPPCHECK_PROPERTIES "")
find_program(CPPCHECK_PROGRAM cppcheck)
if(CPPCHECK_PROGRAM)
  # Suppress "unusedFunction" here to avoid false positives since cppcheck
  # will check every file individually. Truly unused functions will be caught
  # by clang-tidy.
  list(APPEND CPPCHECK_PROPERTIES
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

set(IWYU_PROPERTIES "")
find_program(IWYU_PROGRAM include-what-you-use)
if(IWYU_PROGRAM)
  set(IWYU_PROPERTIES "${IWYU_PROGRAM};-Xiwyu;")
  message(STATUS "Enabled include-what-you-use")
else()
  message(STATUS "include-what-you-use not found")
endif()

set(CCACHE_PROPERTIES "")
find_program(CCACHE_PROGRAM ccache)
if(CCACHE_PROGRAM)
  list(APPEND CCACHE_PROPERTIES
    ${CCACHE_PROGRAM})
  message(STATUS "Enabled Ccache")
else()
  message(STATUS "Ccache not found")
endif()

set_target_properties(${PROJECT_NAME} example PROPERTIES
  CXX_CLANG_TIDY           "${CLANG_TIDY_PROPERTIES}"
  CXX_CPPCHECK             "${CPPCHECK_PROPERTIES}"
  CXX_INCLUDE_WHAT_YOU_USE "${IWYU_PROPERTIES}"
  CXX_COMPILER_LAUNCHER    "${CCACHE_PROPERTIES}")
