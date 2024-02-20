cmake_minimum_required(VERSION 3.21)
project(
  cppstart
  VERSION 1.0
  DESCRIPTION "cppstart template project."
  HOMEPAGE_URL "https://github.com/laurensnol/cppstart"
  LANGUAGES C CXX)

include("cmake/PreventInSourceBuild.cmake")

# Since building documentation doesn't require building any targets, we can
# immediately return if BUILD_DOCS is ON
if(BUILD_DOCS)
  add_subdirectory(docs)
  return()
endif()

# Only include tests if top level
if(PROJECT_IS_TOP_LEVEL)
  include(FetchContent)

  include(CTest)
  add_subdirectory(test)
endif()

add_subdirectory(src ${PROJECT_NAME})
add_subdirectory(example)

# Apply compiler flags and coverage libraries
target_compile_options(${PROJECT_NAME} PRIVATE ${COMPILER_FLAGS}${COVERAGE_OPTIONS})
target_link_libraries(${PROJECT_NAME} PRIVATE ${COVERAGE_LIBRARIES})

include("cmake/SymlinkCompileCommands.cmake")
include("cmake/Tooling.cmake")
