#include <cppstart/some.hpp>
#include <iostream>

auto main() -> int {
  const int result = cpp::add(1, 2);
  std::cout << result << "\n";

  return 0;
}
