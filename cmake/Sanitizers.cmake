if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
  set(CPPSTART_SANITIZER_FLAGS
    "-fno-omit-frame-pointer"
    "-fsanitize=address,undefined,leak")
  target_compile_options(${PROJECT_NAME} PRIVATE ${CPPSTART_SANITIZER_FLAGS})
  target_compile_options(example PRIVATE ${CPPSTART_SANITIZER_FLAGS})

  target_link_options(${PROJECT_NAME} PRIVATE "-fsanitize=address,undefined,leak")
  target_link_options(example PRIVATE "-fsanitize=address,undefined,leak")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "GNU")
  if(APPLE)
    message(WARNING "Skipped enabling sanitizers\n"
      "GCC does not support sanitizers on MacOS Ventura\n"
      "See: https://github.com/orgs/Homebrew/discussions/3384#discussioncomment-6264292")
  endif()

  set(CPPSTART_SANITIZER_FLAGS
    "-fno-omit-frame-pointer"
    "-fsanitize=address,undefined,leak")
  target_compile_options(${PROJECT_NAME} PRIVATE ${CPPSTART_SANITIZER_FLAGS})
  target_compile_options(example PRIVATE ${CPPSTART_SANITIZER_FLAGS})

  target_link_options(${PROJECT_NAME} PRIVATE "-fsanitize=address,undefined,leak")
  target_link_options(example PRIVATE "-fsanitize=address,undefined,leak")
elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
  target_compile_options(${PROJECT_NAME} PRIVATE "/fsanitize=address")
  target_compile_options(example PRIVATE "/fsanitize=address")
else()
  message(WARNING "Skipped enabling sanitizers for unknown compiler ${CMAKE_CXX_COMPILER_ID}")
endif()
