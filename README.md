I am creating a template that I want available on my github, and then I can create a script in my dotfiles that will clone one of these for me when I need it.

current plan of attack
- fix issue of creating both a build and a target?
- write the flake.nix so that you can run the commands from anywhere
- get repo on github listed as a template
- eventually once on github, create a script that will generate a directory and replace the project name with the desired name, and use the desired version of C++, and finally cd into it, build the flake, and build the repo


# Build

```bash
mkdir -p build
cd build
cmake ..
cmake --build .
```

# Run

```bash
./build/MyProject
```

# Test

```bash
cd build
ctest
```

# Clean

```bash
rm -rf build
```
