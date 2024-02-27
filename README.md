# cppstart

[![Build](https://github.com/laurensnol/cppstart/actions/workflows/build.yml/badge.svg)](https://github.com/laurensnol/cppstart/actions/workflows/build.yml)
[![CodeQL](https://github.com/laurensnol/cppstart/actions/workflows/github-code-scanning/codeql/badge.svg)](https://github.com/laurensnol/cppstart/actions/workflows/github-code-scanning/codeql)

A simple C++ project entry point for libraries with CMake, tests, analysis,
documentation and more.

## Features

- Simple structure
  - Headers in `include/`, sources in `src/`
  - Tests in `test/`
  - Documentation in `docs/`
  - Example in `example/`
- Modern [CMake](https://cmake.org/)
- Testing using [Catch2](https://github.com/catchorg/Catch2)
- Documentation using [Doxygen](https://doxygen.nl/)
- Static code analysis and linting using
  - [clang-tidy](https://clang.llvm.org/extra/clang-tidy/)
  - [cppcheck](https://cppcheck.sourceforge.io/)
- Formatting using [clang-format](https://clang.llvm.org/docs/ClangFormat.html)
- Include checking using
[include-what-you-use](https://include-what-you-use.org/)
- Compiler cache using [Ccache](https://ccache.dev/)
- GitHub Action for CI

## Dependencies

**Necessary**

- [CMake](https://cmake.org/)
- [Ninja](https://ninja-build.org/)
- A C++ compiler:
  - [clang](https://clang.llvm.org/)
  - [gcc](https://gcc.gnu.org/) (on Windows, see: https://www.msys2.org/)
  - [MSVC](https://visualstudio.microsoft.com/vs/features/cplusplus/)

**Optional (but recommended)**

- [Doxygen](https://doxygen.nl/)
- [clang-tidy](https://clang.llvm.org/extra/clang-tidy/)
- [cppcheck](https://cppcheck.sourceforge.io/)
- [clang-format](https://clang.llvm.org/docs/ClangFormat.html)
- [include-what-you-use](https://include-what-you-use.org/)
- [Ccache](https://ccache.dev/)

## Getting Started

There are two ways to use this repository as a template for a new C++ project.

### GitHub Template

Click the `Use this template` button at the top of this page and enter a
repository name. Then, wait for the GitHub Actions to finish.

*Note that this will mark your repository as* 
`generated from laurensnol/cppstart` *which can **not** be removed.*

### Cloning

This method will not create a `generated from laurensnol/cppstart` tag.
[Python](https://www.python.org/) is *highly* recommended to be installed as it
simplifies the renaming process.

First, clone cppstart locally into a directory of your choice:
`git clone https://github.com/laurensnol/cppstart <project_name>`. Inside the
new directory, remove the `.git` directory: `rm -rf .git`. You may now run the
rename script using `python rename.py [-k] NAME`, which will automatically
rename all relevant occurrences of `cppstart` to `NAME` and clear the README.
Adding `-k` will prevent the script from deleting itself after running.

After the script is finished, create a new Git repository: `git init`, stage the
changes with `git add .` and commit them: `git commit -m "initial commit"`.

You may now optionally add your new project to GitHub:

1. `git remote add origin https://github.com/USERNAME/REPOSITORY.git`
2. `git push -u origin main`

## Building, Running & Testing

*This project is using
[CMake Presets](https://cmake.org/cmake/help/latest/manual/cmake-presets.7.html)
for configuring, building and testing.*

### Configuration

Before building any target(s), the project has to be configured using any of the
available presets, which can be listed with `cmake --list-presets`.

To configure, run `cmake --preset <name>`.

### Building

After configuring the project, you can build one or more targets by using a
preset listed by `cmake --build --list-presets` with
`cmake --build --preset <name>`.

**Note that some presets rely on specific configure presets. E.g. building**
`lib-debug` **requires a** `<compiler>-debug(-no-tools)` **configuration**.

### Testing

Building and running tests is possible with any configuration preset but
requires any `tests-<configuration>` build preset to be built.

Running tests is then possible by using `ctest --preset <name>` with any test
preset listed by `ctest --list-presets`

### Documentation

*Building documentation requires [Doxygen](https://doxygen.nl/).*

To build the documentation, configure your project with the `docs` preset:
`cmake --preset docs` and build it with `cmake --build --preset docs`. The
output Doxygen HTML files can be found in `build/docs/docs/html`.

Refer to the [CMake FindDoxygen documentation](https://cmake.org/cmake/help/latest/module/FindDoxygen.html)
for further information.
