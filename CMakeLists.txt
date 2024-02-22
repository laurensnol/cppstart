cmake_minimum_required(VERSION 3.21)
project(
  cppstart
  DESCRIPTION "cppstart template project."
  HOMEPAGE_URL "https://github.com/laurensnol/cppstart"
  LANGUAGES C CXX)

include("cmake/PreventInSourceBuild.cmake")
include(FetchContent)

add_subdirectory(src ${PROJECT_NAME})
add_subdirectory(example)

include("cmake/CompilerOptions.cmake")

if(CPPSTART_ENABLE_TOOLS)
  include("cmake/Tooling.cmake")
  include("cmake/Sanitizers.cmake")
endif()

if(PROJECT_IS_TOP_LEVEL)
  include("cmake/SymlinkCompileCommands.cmake")
  include(CTest)

  if(BUILD_TESTING)
    add_subdirectory(test)
  endif()

  add_subdirectory(docs)

  if(CPPSTART_ENABLE_COVERAGE)
    include("cmake/Coverage.cmake")
  endif()
endif()
