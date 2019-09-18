{ obelisk ? import ./.obelisk/impl {
    system = builtins.currentSystem;
    iosSdkVersion = "10.2";
    # You must accept the Android Software Development Kit License Agreement at
    # https://developer.android.com/studio/terms in order to build Android apps.
    # Uncomment and set this to `true` to indicate your acceptance:
    # config.android_sdk.accept_license = false;
  }
}:
with obelisk;
project ./. ({ pkgs, ... }: {
  # android.applicationId = "systems.obsidian.obelisk.examples.minimal";
  # android.displayName = "Obelisk Minimal Example";
  # ios.bundleIdentifier = "systems.obsidian.obelisk.examples.minimal";
  # ios.bundleName = "Obelisk Minimal Example";

  withHoogle = true;

  overrides = self: super:
  with pkgs.haskell.lib;
  let reflex-dom-contrib-src = pkgs.fetchFromGitHub {
    owner = "reflex-frp";
    repo = "reflex-dom-contrib";
    rev = "796a3f0fa1ff59cbad97c918983355b46c3b6aa0";
    sha256 = "0aqj7xm97mwxhhpcrx58bbg3hhn12jrzk13lf4zhpk2rrjw6yvmc";
  }; in
  {
    reflex-dom-contrib = dontCheck (self.callCabal2nix "reflex-dom-contri" reflex-dom-contrib-src {});
  };
})
