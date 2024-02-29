file(GLOB_RECURSE CPPSTART_TESTS CONFIGURE_DEPENDS "${CPPSTART_TESTS_DIR}/*.cpp")
add_executable(tests ${CPPSTART_TESTS})

if(CPPSTART_ENABLE_TOOLS)
  include("${PROJECT_SOURCE_DIR}/cmake/Sanitizers.cmake")
  cppstart_enable_sanitizers(tests)
endif()

FetchContent_Declare(
  Catch2
  GIT_REPOSITORY https://github.com/catchorg/Catch2.git
  GIT_TAG        v3.5.2)
FetchContent_MakeAvailable(Catch2)

target_link_libraries(tests PRIVATE cppstart Catch2::Catch2WithMain)

include(Catch)
catch_discover_tests(tests)
