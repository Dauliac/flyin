{
  lib,
  inputs,
  ...
}:
let
  inherit (lib) mkOption mdDoc types;
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
    };
}
