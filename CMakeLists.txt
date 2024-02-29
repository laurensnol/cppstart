cmake_minimum_required(VERSION 3.21)
project(cppstart)

option(CPPSTART_BUILD_EXAMPLE   "Build example for cppstart"               OFF)
option(CPPSTART_BUILD_DOCS      "Build documentation for cppstart"         OFF)
option(CPPSTART_BUILD_TESTS     "Build tests for cppstart"                 OFF)
option(CPPSTART_ENABLE_TOOLS    "Enable tools and sanitizers for cppstart" OFF)
option(CPPSTART_ENABLE_COVERAGE "Add coverage options for cppstart"        OFF)

include("cmake/PreventInSourceBuild.cmake")

if(PROJECT_IS_TOP_LEVEL)
  include("cmake/SymlinkCompileCommands.cmake")
endif()

# Subdirectories

set(CPPSTART_HEADERS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/include/cppstart")
set(CPPSTART_SOURCES_DIR "${CMAKE_CURRENT_SOURCE_DIR}/src")
set(CPPSTART_EXAMPLE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/example")
set(CPPSTART_TESTS_DIR "${CMAKE_CURRENT_SOURCE_DIR}/test")

add_subdirectory(src cppstart)

if(CPPSTART_BUILD_EXAMPLE)
  add_subdirectory(example)
endif()

if(CPPSTART_BUILD_DOCS)
  add_subdirectory(docs)
endif()

# Options & tooling

include("cmake/CompilerOptions.cmake")
cppstart_set_compiler_options(cppstart example)

if(CPPSTART_ENABLE_TOOLS)
  include("cmake/Tooling.cmake")
  cppstart_enable_tooling(cppstart example)

  include("cmake/Sanitizers.cmake")
  cppstart_enable_sanitizers(cppstart example)
endif()

# Testing

if(CPPSTART_BUILD_TESTS)
  include(CTest) # will set BUILD_TESTING to ON
endif()

if(BUILD_TESTING)
  include(FetchContent)
  add_subdirectory(test)

  if(CPPSTART_ENABLE_COVERAGE)
    include("cmake/Coverage.cmake")
    cppstart_enable_coverage(cppstart)
  endif()
endif()
