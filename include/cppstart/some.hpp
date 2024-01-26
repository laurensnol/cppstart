#ifndef SOME_H
#define SOME_H

namespace cpp {
/// \brief Adds two numbers.
///
/// This method adds two integers and returns it's result.
///
/// \param x The first number to add.
/// \param y The second number to add.
/// \return The result of adding the two values.
constexpr auto add(int first, int second) noexcept -> int;
}  // namespace cpp

#endif
