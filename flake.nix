{
  description = "C++ development environment (Linux + macOS)";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    systems = ["x86_64-linux" "aarch64-darwin"];
    forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
  in {
    devShells = forAllSystems (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      default = pkgs.mkShell {
        buildInputs = with pkgs; [
          cmake # build system
          gcc # GNU compiler (Linux)
          clang # Clang compiler (Linux/macOS)
          # gdb                # debugger
          # lldb               # debugger (better on macOS)
          ccache # optional: speeds up rebuilds
          pkg-config # helps find libraries
          (pkgs.writeShellScriptBin "cmake_test" ''
            echo "Running tests..."
            ctest --test-dir build
          '')
          (pkgs.writeShellScriptBin "cmake_build" ''
            echo "Building project..."
            mkdir -p build
            cd build
            cmake .. -DCMAKE_BUILD_TYPE=Debug
            make -j$(nproc 2>/dev/null || sysctl -n hw.ncpu 2>/dev/null || echo 4)
            echo "Build complete"
          '')
          (pkgs.writeShellScriptBin "cmake_run" ''
            echo "Running MyProject..."
            if [ -f "build/MyProject" ]; then
              ./build/MyProject
            else
              echo "Build not found. Run 'cmake_build' first."
              exit 1
            fi
          '')
          (pkgs.writeShellScriptBin "cmake_clean" ''
            echo "Cleaning build artifacts..."
            rm -rf build/
            echo "Clean complete"
          '')
        ];

        # Ensure PATH includes compilers, etc.
        shellHook = ''
          if [ -n "$ZSH_VERSION" ]; then
            : # already in zsh
          else
            exec zsh
          fi
        '';
      };
    });
  };
}
