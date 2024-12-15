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
      checks = {
        unit-tests = pkgs.buildNpmPackage {
          pname = "unit-tests";
          version = (builtins.fromJSON (builtins.readFile ../package.json)).version;
          src = ../.;
          npmDeps = config.packages.npmDeps;
          npmConfigHook = pkgs.importNpmLock.npmConfigHook;
          npmBuildScript = "test";
          installPhase = ''
            mkdir -p $out/
            cp -rv .svelte-kit $out/
            cp -rv * $out/
          '';
        };
      };
    };
}
