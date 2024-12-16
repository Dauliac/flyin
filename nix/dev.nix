{ ... }:
{
  imports = [
    ./checks.nix
  ];
  perSystem =
    {
      pkgs,
      config,
      ...
    }:
    {
      devShells.default = pkgs.mkShell {
        nativeBuildInputs =
          with pkgs;
          [
            lefthook
            convco
            typos
            trufflehog
          ]
          ++ config.buildPackages
          ++ config.checkPackages;
        shellHook = ''
          ${pkgs.go-task}/bin/task --verbose --output prefixed
          printf "You can run project tasks using cli:\n  task\n\n"
          ${pkgs.go-task}/bin/task --list
        '';
      };
    };
}
