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
  imports = [
    inputs.treefmt-nix.flakeModule
  ];
  options.perSystem = mkPerSystemOption (
    {
      config,
      pkgs,
      ...
    }:
    {
      options = {
        checkPackages = mkOption {
          description = mdDoc "Packages used to check the project";
          default =
            with pkgs;
            [
              git
              typos
              config.treefmt.build.wrapper
            ]
            ++ config.buildPackages;
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
        check = pkgs.buildNpmPackage {
          pname = "check";
          version = (builtins.fromJSON (builtins.readFile ../package.json)).version;
          src = ../.;
          npmDeps = config.packages.npmDeps;
          npmConfigHook = pkgs.importNpmLock.npmConfigHook;
          npmBuildScript = "check";
        };
        test = pkgs.buildNpmPackage {
          pname = "test";
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
