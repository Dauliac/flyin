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
            git
            prefetch-npm-deps
          ]
          ++ config.buildPackages;
        shellHook = ''
          ${pkgs.go-task}/bin/task --verbose --output prefixed
          ${pkgs.go-task}/bin/task --list
        '';
      };
    };
}
