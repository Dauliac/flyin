{ ... }:
{
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
            go-task
            lefthook
            convco
            typos
            trufflehog
            fd
            yamlfmt
            typos
            treefmt
          ]
          ++ config.buildPackages;
        shellHook = ''
          ${pkgs.go-task}/bin/task init --verbose --output prefixed
        '';
      };
    };
}
