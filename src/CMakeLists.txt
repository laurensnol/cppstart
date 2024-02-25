file(GLOB CPPSTART_HEADERS CONFIGURE_DEPENDS "${CMAKE_CURRENT_SOURCE_DIR}/include/cppstart/*.hpp")
add_library(cppstart some.cpp ${CPPSTART_HEADERS})
target_include_directories(cppstart PUBLIC ../include)
target_compile_features(cppstart PUBLIC cxx_std_20)
