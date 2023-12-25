set(HEADERS "${PROJECT_SOURCE_DIR}/include/${PROJECT_NAME}/some.hpp")

add_library(${PROJECT_NAME} some.cpp ${HEADERS})
target_include_directories(${PROJECT_NAME} PUBLIC ../include)
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_20)

source_group(
  TREE "${PROJECT_SOURCE_DIR}/include"
  PREFIX "Headers"
  FILES ${HEADERS})
