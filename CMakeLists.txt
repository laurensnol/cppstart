cmake_minimum_required(VERSION 3.21)
project(cppstart)

option(CPPSTART_BUILD_EXAMPLE   "Build example for cppstart"               OFF)
option(CPPSTART_BUILD_DOCS      "Build documentation for cppstart"         OFF)
option(CPPSTART_BUILD_TESTS     "Build tests for cppstart"                 OFF)
option(CPPSTART_ENABLE_TOOLS    "Enable tools and sanitizers for cppstart" OFF)
option(CPPSTART_ENABLE_COVERAGE "Add coverage options for cppstart"        OFF)
option(CPPSTART_INSTALL         "Install cppstart"                         OFF)

include("cmake/PreventInSourceBuild.cmake")

if(PROJECT_IS_TOP_LEVEL)
  include("cmake/SymlinkCompileCommands.cmake")
endif()

# Subdirectories

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
  include(CTest)
endif()

if(BUILD_TESTING) # will be defined by "include(CTest)"
  include(FetchContent)
  add_subdirectory(test)

  if(CPPSTART_ENABLE_COVERAGE)
    include("cmake/Coverage.cmake")
    cppstart_enable_coverage(cppstart)
  endif()
endif()
