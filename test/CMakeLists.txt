FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG        v3.5.0)
FetchContent_MakeAvailable(Catch2)

set (TARGET_NAME tests)

add_executable(${TARGET_NAME} some_test.cpp)
target_compile_features(${TARGET_NAME} PRIVATE cxx_std_20)
target_link_libraries(
  ${TARGET_NAME}
  PRIVATE ${PROJECT_NAME}
  Catch2::Catch2WithMain)

include(Catch)
catch_discover_tests(${TARGET_NAME})
