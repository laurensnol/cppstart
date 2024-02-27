import argparse
import os
import re

ROOT_DIR = os.path.dirname(__file__)
INCLUDE_DIR = os.path.join(ROOT_DIR, "include")
README_PATH = os.path.join(ROOT_DIR, "README.md")
INIT_PATH = os.path.join(ROOT_DIR, ".github", "workflows", "initialize.yml")
DEFAULT_PROJECT_NAME = "cppstart"
FILES = [
    "CMakeLists.txt",
    "CMakePresets.json",
    os.path.join("cmake", "CompilerOptions.cmake"),
    os.path.join("cmake", "Coverage.cmake"),
    os.path.join("cmake", "Sanitizers.cmake"),
    os.path.join("cmake", "Tooling.cmake"),
    os.path.join("docs", "CMakeLists.txt"),
    os.path.join("example", "CMakeLists.txt"),
    os.path.join("example", "main.cpp"),
    os.path.join("src", "CMakeLists.txt"),
    os.path.join("src", "some.cpp"),
    os.path.join("test", "CMakeLists.txt"),
    os.path.join("test", "some_test.cpp"),
]

def is_valid(s: str) -> bool:
    # See: https://cmake.org/cmake/help/latest/policy/CMP0037.html
    pattern = re.compile(r"[^a-zA-Z0-9_\.\+\-]")
    return pattern.search(s) is None

def replace_project_name(file: str, new: str) -> None:
    with open(file, "r") as f:
        content = f.read()
        content = content.replace(DEFAULT_PROJECT_NAME, new.lower())
        content = content.replace(DEFAULT_PROJECT_NAME.upper(), new.upper())

    with open(file, "w") as f:
        f.write(content)

def main() -> None:
    parser = argparse.ArgumentParser(
        usage="%(prog)s [-k] NAME",
        description="""Renames all occurrences of \"cppstart\" to the specified
        name. Optionally sets a description and homepage."""
    )

    parser.add_argument("-k", "--keep", action="store_true")
    parser.add_argument("name", type=str)
    args = parser.parse_args()

    if not is_valid(args.name):
        print("Error: Invalid project name. Project names set by this script " \
              "are limited to current CMake policies. (See: "                  \
              "https://cmake.org/cmake/help/latest/policy/CMP0037.html).\n"    \
              "Allowed characters are: alphanumeric characters, underscores "  \
              "(_), dot (.), plus (+) and minus (-). If you wish to use the "  \
              "name provided and are sure that it is a valid name, please "    \
              "set it manually.")
        return

    print(f"Changing occurrences of cppstart/CPPSTART to {args.name}/" \
          f"{args.name.upper()}... ")
    for file in FILES:
        path = os.path.join(ROOT_DIR, file)
        print(f"Updating {path}...")
        replace_project_name(path, args.name)

    print("Renaming include directory... ")
    os.rename(
        os.path.join(INCLUDE_DIR, DEFAULT_PROJECT_NAME),
        os.path.join(INCLUDE_DIR, args.name)
    )

    print("Clearing README.md...")
    with open(README_PATH, "w") as f:
        f.write(f"# {args.name}\n")

    if not args.keep:
        print("Deleting script and initialize workflow...")
        os.remove(__file__)
        os.remove(INIT_PATH)
    else:
        print("Skipped deleting script and initialize workflow.")

if __name__ == "__main__":
    main()
