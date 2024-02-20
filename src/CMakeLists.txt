file(GLOB HEADERS CONFIGURE_DEPENDS "${PROJECT_SOURCE_DIR}/include/${PROJECT_NAME}/*.hpp")
add_library(${PROJECT_NAME} some.cpp ${HEADERS})
target_include_directories(${PROJECT_NAME} PUBLIC ../include)
target_compile_features(${PROJECT_NAME} PUBLIC cxx_std_20)
