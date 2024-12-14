{
  inputs,
  lib,
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
  config.perSystem =
    { config, ... }:
    {
      treefmt = {
        projectRootFile = "flake.nix";
        settings.global.excludes = [
          "*.png"
          "*.npmrc"
          "*.prettierignore"
          "*.prettierrc"
          "*.svg"
          "*.avif"
        ];
        programs = {
          prettier = {
            enable = true;
            includes = [
              "*.cjs"
              "*.css"
              "*.html"
              "*.js"
              "*.json"
              "*.json5"
              "*.jsx"
              "*.md"
              "*.mdx"
              "*.mjs"
              "*.scss"
              "*.ts"
              "*.tsx"
              "*.vue"
              "*.yaml"
              "*.yml"
              "*.svelte"
            ];
          };
          typos.enable = true;
          shellcheck.enable = true;
          nixfmt.enable = true;
          alejandra.enable = true;
          yamlfmt.enable = true;
          jsonfmt.enable = true;
          toml-sort.enable = true;
        };
      };
    };
}
