import argparse
import os
import re

# See: https://cmake.org/cmake/help/latest/policy/CMP0037.html
def is_valid(s: str) -> bool:
    pattern = re.compile(r"[^a-zA-Z0-9_\.\+\-]")
    return pattern.search(s) is not None

def main() -> None:
    parser = argparse.ArgumentParser(
        usage="%(prog)s NAME [DESCRIPTION] [HOMEPAGE] [-k]",
        description="""Renames all occurrences of \"cppstart\" to the specified
        name. Optionally sets a description and homepage."""
    )

    parser.add_argument(
        "name",
        type=str,
        help="name of the project"
    )

    parser.add_argument(
        "description",
        type=str,
        nargs="?",
        default="",
        help="description of the project"
    )

    parser.add_argument(
        "homepage",
        type=str,
        nargs="?",
        default="",
        help="homepage of the project"
    )

    parser.add_argument(
        "-k",
        "--keep",
        action="store_true",
        help="do not delete the script after running"
    )

    args = parser.parse_args()

    if is_valid(args.name):
        print("Error: Invalid project name. Project names set by this script " \
              "are limited to current CMake policies. (See: "\
              "https://cmake.org/cmake/help/latest/policy/CMP0037.html).\n" \
              "Allowed characters are: alphanumeric characters, underscores " \
              "(_), dot (.), plus (+) and minus (-). If you wish to use the " \
              "name provided and are sure that it is a valid name, please " \
              "set it manually.")
        return

    script_dir = os.path.dirname(__file__)
    root_dir = os.path.dirname(script_dir)

    print("Renaming include directory...")
    os.rename(
        os.path.join(root_dir, "include", "cppstart"),
        os.path.join(root_dir, "include", args.name)
    )

    files = [
        os.path.join("src", "some.cpp"),
        os.path.join("app", "main.cpp"),
        os.path.join("test", "some_test.cpp")
    ]

    for file in files:
        print(f"Updating {file}...")

        path = os.path.join(root_dir, file)
        with open(path, "r") as file:
            content = file.read()

        content = content.replace("cppstart", args.name)

        with open(path, "w") as file:
            if content != "":
                file.write(content)

    cmake_path = os.path.join(root_dir, "CMakeLists.txt")
    with open(cmake_path, "r") as file:
        content = file.read()
        content = content \
            .replace("cppstart template project.", args.description) \
            .replace("https://github.com/laurensnol/cppstart", args.homepage) \
            .replace("cppstart", args.name)

    with open(cmake_path, "w") as file:
        file.write(content)

    if not args.keep:
        print("Deleting script directory...")
        os.remove(__file__)

    print("Done.")

if __name__ == "__main__":
    main()
