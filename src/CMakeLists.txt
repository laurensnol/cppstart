set(HEADERS "${cppstart_SOURCE_DIR}/include/cppstart/some.hpp")
set(TARGET_NAME cppstart)

add_library(${TARGET_NAME} some.cpp ${HEADERS})
target_include_directories(${TARGET_NAME} PUBLIC ../include)
target_compile_features(${TARGET_NAME} PUBLIC cxx_std_20)

source_group(
  TREE "${PROJECT_SOURCE_DIR}/include"
  PREFIX "Headers"
  FILES ${HEADERS})
