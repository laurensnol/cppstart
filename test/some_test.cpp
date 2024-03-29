#include <catch2/catch_test_macros.hpp>
#include <cppstart/some.hpp>

TEST_CASE("Correct", "[add]") { REQUIRE(cpp::add(1, 2) == 3); }
TEST_CASE("Incorrect", "[add]") { REQUIRE_FALSE(cpp::add(1, 2) == 4); }
