{ pkgs ? import <nixpkgs> { } }:
let
  local-shell = if builtins.pathExists ./local-shell.nix then
    (import ./local-shell.nix { inherit pkgs; })
  else
    null;
  NPM_CONFIG_PREFIX = toString ./.npm_config_prefix;
in with pkgs;
mkShell {
#   if we have default.nix
#   inputsFrom = [ (import ./default.nix { inherit pkgs; }) ]
#     ++ lib.optionals (!isNull local-shell) [ local-shell ];
  buildInputs = [ zsh nixfmt nixpkgs-fmt act ];
  shellHook = ''
    echo ""
    echo "---------------------------------------------------------------"
    echo "You are using default Nix-shell in this project."
    echo "Use: \"direnv status\" to check if you are using correct direnv"
    echo "Use: \"printenv\" to print current environment variable"
    echo "---------------------------------------------------------------"
    echo ""
  '';
}
