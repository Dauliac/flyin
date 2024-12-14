{
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkOption mdDoc;
  inherit (inputs.flake-parts.lib) mkPerSystemOption;
in
{
  options.perSystem = mkPerSystemOption (
    {
      config,
      pkgs,
      ...
    }:
    {
      options = {
        buildPackages = mkOption {
          description = mdDoc "Packages used to generate build the project";
          default = with pkgs; [
            nodejs_22
          ];
        };
      };
    }
  );
  config.perSystem =
    {
      config,
      pkgs,
      ...
    }:
    {
      packages.landing = pkgs.buildNpmPackage {
        pname = "landing";
        version = "0.0.1"; # TODO: read from package.json
        src = ../.;
        # NOTE: Generate a new hash using:
        #   nix develop
        #   npm i --package-lock-only
        #   prefetch-npm-deps package-lock.json
        # npmDepsHash = "sha256-yy5KszdMYWxflTl6rJDdUUpaIPWsYP8Xa4DIpdWF3fo=";
        npmDepsHash = builtins.readFile ./npm-deps-hash.txt;
        installPhase = ''
          mkdir -p $out/
          cp -rv .svelte-kit/* $out/
        '';
      };
      packages.default = config.packages.landing;
    };
}
