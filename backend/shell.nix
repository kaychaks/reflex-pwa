# let
#   ghc = (import ./default.nix {}).shells.ghc;
#   shells = (import ./default.nix {}).shells;
# in
# {
#   inherit ghc;
#   inherit shells;
# }

(import ../default.nix {}).shells.ghc
