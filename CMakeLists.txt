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
target_compile_options(${PROJECT_NAME} PRIVATE "${DEBUG_FLAGS}${RELEASE_FLAGS}${COVERAGE_OPTIONS}")
target_link_libraries(${PROJECT_NAME} PRIVATE "${COVERAGE_LIBRARIES}")

if(ENABLE_TOOLS)
  message(STATUS "Enabling tools")

  # TODO: Add clang-tidy
  # TODO: Add cppcheck
  # TODO: Add ccache
  # TODO: Add iwyu
endif()
