cmake_minimum_required(VERSION 3.21)
project(
  cppstart
  VERSION 1.0
  DESCRIPTION "cppstart template project."
  HOMEPAGE_URL "https://github.com/laurensnol/cppstart"
  LANGUAGES CXX)

if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
  set(CMAKE_CXX_EXTENSIONS OFF)
  set(CMAKE_CXX_STANDARD 20)
  set(CMAKE_CXX_STANDARD_REQUIRED ON)

  set_property(GLOBAL PROPERTY USE_FOLDERS ON)

  include(CTest)

  find_package(Doxygen)
  if(Doxygen_FOUND)
    add_subdirectory(docs)
  else()
    message(STATUS "Doxygen not found. Not building docs.")
  endif()
endif()

include(FetchContent)

add_subdirectory(src)
add_subdirectory(app)

if((CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME OR MODERN_CMAKE_BUILD_TESTING)
   AND BUILD_TESTING)
    add_subdirectory(tests)
endif()
