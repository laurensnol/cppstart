cmake_minimum_required(VERSION 3.21)
project(cppstart
  DESCRIPTION "cppstart template project."
  HOMEPAGE_URL "https://github.com/laurensnol/cppstart"
  LANGUAGES C CXX)

option(CPPSTART_BUILD_DOCS      "Build documentation for cppstart"         ON)
option(CPPSTART_BUILD_TESTS     "Build tests for cppstart"                 ON)
option(CPPSTART_ENABLE_TOOLS    "Enable tools and sanitizers for cppstart" OFF)
option(CPPSTART_ENABLE_COVERAGE "Add coverage options for cppstart"        OFF)

include("cmake/PreventInSourceBuild.cmake")
include(FetchContent)

add_subdirectory(src ${PROJECT_NAME})
add_subdirectory(example)

include("cmake/CompilerOptions.cmake")
cppstart_set_compiler_options(${PROJECT_NAME} example)

if(CPPSTART_ENABLE_TOOLS)
  include("cmake/Tooling.cmake")
  cppstart_enable_tooling(${PROJECT_NAME} example)

  include("cmake/Sanitizers.cmake")
  cppstart_enable_sanitizers(${PROJECT_NAME} example)
endif()

if(PROJECT_IS_TOP_LEVEL)
  include("cmake/SymlinkCompileCommands.cmake")

  include(CTest)
  if(BUILD_TESTING AND CPPSTART_BUILD_TESTS)
    add_subdirectory(test)
  endif()

  if(CPPSTART_BUILD_DOCS)
    add_subdirectory(docs)
  endif()

  if(CPPSTART_ENABLE_COVERAGE)
    include("cmake/Coverage.cmake")
    cppstart_enable_coverage(${PROJECT_NAME})
  endif()
endif()
