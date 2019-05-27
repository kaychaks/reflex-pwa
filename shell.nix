let
  ghc = (import ./. {}).shells.ghc;
  shells = (import ./. {}).shells;
in
{
  inherit ghc;
  inherit shells;
}
