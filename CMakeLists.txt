cmake_minimum_required(VERSION 3.21)
project(
  cppstart
  VERSION 1.0
  DESCRIPTION "cppstart template project."
  HOMEPAGE_URL "https://github.com/laurensnol/cppstart"
  LANGUAGES C CXX)

# Prevent in-source builds
if(PROJECT_SOURCE_DIR STREQUAL PROJECT_BINARY_DIR)
  message(FATAL_ERROR "In-source builds are not allowed")
endif()

# Since building documentation doesn't require building any targets, we can
# immediately return if BUILD_DOCS is ON
if(BUILD_DOCS)
  add_subdirectory(docs)
  return()
endif()

# Only include tests if top level
if(PROJECT_IS_TOP_LEVEL)
  include(CTest)
  include(FetchContent)

  add_subdirectory(test)
endif()

add_subdirectory(src ${PROJECT_NAME})
add_subdirectory(app)

# Apply set compiler flags
target_compile_options(${PROJECT_NAME} PRIVATE ${DEBUG_FLAGS}${RELEASE_FLAGS}${COVERAGE_OPTIONS})
target_link_libraries(${PROJECT_NAME} PRIVATE ${COVERAGE_LIBRARIES})

if(ENABLE_TOOLS)
  message(STATUS "Enabling tools")

  set(CLANG_TIDY_PROPERTIES "")
  find_program(CLANG_TIDY_PROGRAM clang-tidy)
  if(CLANG_TIDY_PROGRAM)
    list(APPEND CLANG_TIDY_PROPERTIES
      ${CLANG_TIDY_PROGRAM}
      "-p=${PROJECT_BINARY_DIR}"
      "-header-filter=.*")
  else()
    message(WARNING "clang-tidy not found")
  endif()

  set(CPPCHECK_PROPERTIES "")
  find_program(CPPCHECK_PROGRAM cppcheck)
  if(CPPCHECK_PROGRAM)
    # NOTE: Suppress "unusedFunction" here to avoid false positives since
    #       cppcheck will check every file individually.
    #       Truly unused functions will be caught by clang-tidy.
    list(APPEND CPPCHECK_PROPERTIES
      ${CPPCHECK_PROGRAM}
      "--quiet"
      "--enable=all"
      "--suppress=missingIncludeSystem"
      "--suppress=unusedFunction"
      "--suppress=unmatchedSuppression"
      "--suppress=checkersReport"
      "--inline-suppr")
  else()
    message(WARNING "cppcheck not found")
  endif()

  set(IWYU_PROPERTIES "")
  find_program(IWYU_PROGRAM include-what-you-use)
  if(IWYU_PROGRAM)
    list(APPEND IWYU_PROPERTIES
      ${IWYU_PROGRAM})
  else()
    message(STATUS "include-what-you-use not found")
  endif()

  set(CCACHE_PROPERTIES "")
  find_program(CCACHE_PROGRAM ccache)
  if(CCACHE_PROGRAM)
    list(APPEND CCACHE_PROPERTIES
      ${CCACHE_PROGRAM})
  else()
    message(STATUS "Ccache not found")
  endif()

  set_target_properties(${PROJECT_NAME} app PROPERTIES
    CXX_CLANG_TIDY        "${CLANG_TIDY_PROPERTIES}"
    CXX_CPPCHECK          "${CPPCHECK_PROPERTIES}"
    CXX_IWYU              "${IWYU_PROPERTIES}"
    CXX_COMPILER_LAUNCHER "${CCACHE_PROPERTIES}")
endif()
