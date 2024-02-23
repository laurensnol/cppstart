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
  if(BUILD_TESTING)
    add_subdirectory(test)
  endif()

  add_subdirectory(docs)

  if(CPPSTART_ENABLE_COVERAGE)
    include("cmake/Coverage.cmake")
    cppstart_enable_coverage(${PROJECT_NAME})
  endif()
endif()
