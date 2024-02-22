if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  target_compile_options(${PROJECT_NAME} PRIVATE
    "-fprofile-instr-generate"
    "-fcoverage-mapping")
  target_link_libraries(${PROJECT_NAME} PRIVATE "-fprofile-instr-generate")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  target_compile_options(${PROJECT_NAME} PRIVATE "--coverage")
  target_link_libraries(${PROJECT_NAME} PRIVATE "--coverage")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  message(STATUS "Skipped setting up coverage for MSVC")
else()
  message(WARNING "Skipped setting up coverage for unknown compiler ${CMAKE_CXX_COMPILER_ID}")
endif()
