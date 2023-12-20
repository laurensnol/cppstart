#define CATCH_CONFIG_MAIN

#include <catch2/catch_test_macros.hpp>
#include <cppstart/some.hpp>

TEST_CASE("Correct", "[add]") {
  REQUIRE(cpp::add(1, 2) == 3);
}
