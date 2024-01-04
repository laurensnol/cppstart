# cppstart

[![Build](https://github.com/laurensnol/cppstart/actions/workflows/build.yml/badge.svg)](https://github.com/laurensnol/cppstart/actions/workflows/build.yml)

A simple C++ project entry point for libraries with CMake, tests, analysis,
documentation and more.

## Features

- Simple structure
  - Headers in `include/`, sources in `src/`
  - Tests in `test/`
  - Documentation in `docs/`
  - App in `app/`
- Modern [CMake](https://cmake.org/)
- Testing using [Catch2](https://github.com/catchorg/Catch2)
- Documentation using [Doxygen](https://doxygen.nl/)
- Static code analysis and linting using
  - [clang-tidy](https://clang.llvm.org/extra/clang-tidy/)
  - [cppcheck](https://cppcheck.sourceforge.io/)
- Formatting using [clang-format](https://clang.llvm.org/docs/ClangFormat.html)
- Include checking using [include-what-you-use](https://include-what-you-use.org/)
- Compiler cache using [Ccache](https://ccache.dev/)
- GitHub Action for CI

## Dependencies

**Necessary**

- [CMake](https://cmake.org/)
- A C++ compiler:
  - [clang](https://clang.llvm.org/)
  - [gcc](https://gcc.gnu.org/)
  - [MSVC (Visual Studio)](https://visualstudio.microsoft.com/)

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

*Note that this will mark your repository as *`generated from laurensnol/cppstart`
*which, as of December 2023 can **not** be removed.*

### Cloning

This method will not create a `generated from laurensnol/cppstart` tag.
[Python](https://www.python.org/) is highly recommended to be installed as it
simplifies the renaming process.

First, clone cppstart locally into a directory of your choice:
`git clone https://github.com/laurensnol/cppstart PROJECT_NAME`. Inside the new
directory, remove the `.git` directory: `rm -rf .git`. You may now run the
rename script using
`python scripts/rename.py PROJECT_NAME [DESCRIPTION] [HOMEPAGE] [-k]`, which
will automatically rename all relevant occurrences of `cppstart` to
`PROJECT_NAME`. You can optionally specify a description and a homepage (ensure
to specify these as strings, i.e. sorrounded by quotes). Adding `-k` will
prevent the script from deleting itself after running.

After the script is finished, create a new Git repository: `git init`, stage the
changes with `git add .` and commit them: `git commit -m "initial commit"`.

You may now optionally add your new project to GitHub:

1. `git remote add origin https://github.com/USERNAME/REPOSITORY.git`
2. `git push -u origin main`

## Building, Running & Testing

Before building any target, the build has to be configured using
`cmake -S . -B build`.

### Library

To build the library, run `cmake --build build -t cppstart` *(replace with your
library's name)*. The built library can then be found in `/build/src/`.

### App

To build and run the app:

```sh
cmake --build build -t app
./build/app/app
```

### Testing

You can build and run tests using `ctest`:

```sh
cmake --build build -t tests
cd build/
ctest
```

### Documentation

Building documentation requires [Doxygen](https://doxygen.nl/).

To build the documentation, run `cmake --build build -t docs`. The generated
documentation can then be found in `build/docs/html`.

Refer to the [CMake FindDoxygen documentation](https://cmake.org/cmake/help/latest/module/FindDoxygen.html)
for further information.
