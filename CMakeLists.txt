cmake_minimum_required(VERSION 3.21)
project(
  cppstart
  VERSION 1.0
  DESCRIPTION "cppstart template project."
  HOMEPAGE_URL "https://github.com/laurensnol/cppstart"
  LANGUAGES C CXX)

include("cmake/PreventInSourceBuild.cmake")

if(PROJECT_IS_TOP_LEVEL)
  add_subdirectory(docs)

  include(CTest)
  if(MODERN_CMAKE_BUILD_TESTING AND BUILD_TESTING)
    add_subdirectory(test)
  endif()
endif()

include(FetchContent)

add_subdirectory(src ${PROJECT_NAME})
add_subdirectory(example)

target_compile_options(example PRIVATE ${COMPILER_FLAGS})
target_compile_options(${PROJECT_NAME} PRIVATE ${COMPILER_FLAGS}${COVERAGE_OPTIONS})
target_link_libraries(${PROJECT_NAME} PRIVATE ${COVERAGE_LIBRARIES})

include("cmake/SymlinkCompileCommands.cmake")
include("cmake/Tooling.cmake")
