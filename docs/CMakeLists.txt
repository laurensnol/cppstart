set(DOXYGEN_EXTRACT_ALL YES)
set(DOXYGEN_BUILTIN_STL_SUPPORT YES)
set(DOXYGEN_OUTPUT_DIRECTORY "${PROJECT_SOURCE_DIR}/docs")

doxygen_add_docs(docs cppstart/some.hpp
                 WORKING_DIRECTORY "${PROJECT_SOURCE_DIR}/include")
