{
  description = "try-ai-agent";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in {
        devShell = pkgs.mkShell {
          buildInputs = [
            pkgs.nodejs
            pkgs.pnpm_10
            pkgs.docker-client
            pkgs.sqldef
            pkgs.sqlc
            pkgs.postgresql
            pkgs.sqlfluff
          ];
          shellHook = ''
            pnpm install --frozen-lockfile
          '';
        };
        formatter = pkgs.alejandra;
      }
    );
}
