function(cppstart_enable_coverage)
  message(STATUS "Enabling coverage for target(s) ${ARGN}")

  set(CPPSTART_COVERAGE_COMPILER_FLAGS "")
  set(CPPSTART_COVERAGE_LINK_LIBRARIES "")

  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    set(CPPSTART_COVERAGE_COMPILER_FLAGS
      "-fprofile-instr-generate"
      "-fcoverage-mapping")
    set(CPPSTART_COVERAGE_LINK_LIBRARIES  "-fprofile-instr-generate")
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
    set(CPPSTART_COVERAGE_COMPILER_FLAGS "--coverage")
    set(CPPSTART_COVERAGE_LINK_LIBRARIES "--coverage")
  elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
    message(STATUS "Skipped setting up coverage for MSVC")
    return()
  else()
    message(WARNING "Skipped setting up coverage for unknown compiler ${CMAKE_CXX_COMPILER_ID}")
    return()
  endif()

  foreach(target ${ARGN})
    target_compile_options(${target} PRIVATE ${CPPSTART_COVERAGE_COMPILER_FLAGS})
    target_link_libraries(${target} PRIVATE ${CPPSTART_COVERAGE_LINK_LIBRARIES})
  endforeach()
endfunction()
