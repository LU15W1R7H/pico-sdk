{
  description = "pico-sdk";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    lwirth-nixpkgs.url = "github:lu15w1r7h/nixpkgs/openocd-rp2040";
  };

  outputs = { self, nixpkgs, lwirth-nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
      };
      lwirth-pkgs = import lwirth-nixpkgs {
        inherit system;
      };
    in
    {
      formatter.${system} = pkgs.nixpkgs-fmt;

      devShell.${system} = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [
          cmake
          clang-tools
          cmake-language-server

          lwirth-pkgs.openocd-rp2040
          gcc-arm-embedded
          gdb
          minicom
        ];
      };
    };
}
