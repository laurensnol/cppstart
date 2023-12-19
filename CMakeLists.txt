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
endif()

add_subdirectory(src)
add_subdirectory(app)
