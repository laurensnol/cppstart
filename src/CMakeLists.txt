set(HEADERS "${cppstart_SOURCE_DIR}/include/cppstart/some.hpp")

add_library(cppstart some.cpp ${HEADERS})
target_include_directories(cppstart PUBLIC ../include)
target_compile_features(cppstart PUBLIC cxx_std_20)

source_group(
  TREE "${PROJECT_SOURCE_DIR}/include"
  PREFIX "Headers"
  FILES ${HEADERS})
