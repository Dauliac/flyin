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
            go-task
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
      packages.npmDeps = pkgs.importNpmLock {
        npmRoot = ../.;
      };
      packages.all = pkgs.buildNpmPackage {
        pname = "all";
        version = (builtins.fromJSON (builtins.readFile ../package.json)).version;
        src = ../.;
        npmDeps = config.packages.npmDeps;
        npmConfigHook = pkgs.importNpmLock.npmConfigHook;
        installPhase = ''
          mkdir -p $out/
          cp -rv * $out/
          cp -rv .svelte-kit $out/
        '';
      };
      packages.storybook = pkgs.buildNpmPackage {
        pname = "storybook";
        version = (builtins.fromJSON (builtins.readFile ../package.json)).version;
        src = ../.;
        npmDeps = config.packages.npmDeps;
        npmConfigHook = pkgs.importNpmLock.npmConfigHook;
        npmBuildScript = "build-storybook";
        installPhase = ''
          mkdir -p $out/
          cp -rv storybook-static/* $out/
        '';
      };
      packages.landing = pkgs.buildNpmPackage {
        pname = "landing";
        version = (builtins.fromJSON (builtins.readFile ../package.json)).version;
        src = ../.;
        npmDeps = config.packages.npmDeps;
        npmConfigHook = pkgs.importNpmLock.npmConfigHook;
        installPhase = ''
          mkdir -p $out/
          cp -rv .svelte-kit/* $out/
        '';
      };
      packages.default = config.packages.landing;
    };
}
