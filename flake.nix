{
  description = "Nix flake for the kanban terminal board renderer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      lib = nixpkgs.lib;
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];
      forAllSystems = lib.genAttrs systems;
    in
    {
      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.stdenvNoCC.mkDerivation {
            pname = "kanban";
            version = "0.1.0";
            src = self;

            nativeBuildInputs = [ pkgs.python3 ];

            dontBuild = true;

            installPhase = ''
              install -Dm755 kanban $out/bin/kanban
              patchShebangs $out/bin/kanban
            '';
          };
        });

      apps = forAllSystems (system: {
        default = {
          type = "app";
          program = "${self.packages.${system}.default}/bin/kanban";
        };
      });

      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.mkShell {
            packages = [ pkgs.python3 ];
          };
        });

      checks = forAllSystems (system:
        let
          pkgs = import nixpkgs { inherit system; };
        in
        {
          default = pkgs.runCommand "kanban-py-compile" {
            buildInputs = [ pkgs.python3 ];
          } ''
            python -m py_compile ${self}/kanban
            touch $out
          '';
        });
    };
}
