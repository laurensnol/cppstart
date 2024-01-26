add_executable(example main.cpp)
target_compile_features(example PRIVATE cxx_std_20)
target_link_libraries(example PRIVATE ${PROJECT_NAME})
