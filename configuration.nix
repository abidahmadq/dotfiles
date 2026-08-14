{ user, ... }:

{
  # Determinate already manages the Nix daemon, so nix-darwin shouldn't.
  nix.enable = false;

  nixpkgs.config.allowUnfree = true;
  nixpkgs.hostPlatform = "aarch64-darwin"; # use x86_64-darwin for Intel CPU

  system.primaryUser = user;
  users.users.${user} = {
    home = "/Users/${user}";
  };
  system.stateVersion = 6;
  # nix-darwin defaults promptInit to `prompt suse`, which renders
  # `user@host:~/ >` in every shell that reads /etc/zshrc - Terminal.app, VS
  # Code, ssh. Pin it to the stock macOS prompt instead. WezTerm still gets
  # Starship on top, because ~/.zshrc is sourced after /etc/zshrc.
  programs.zsh.promptInit = "PS1='%n@%m %1~ %% '";
  system.defaults = {
    NSGlobalDomain = {
      AppleInterfaceStyle = "Dark";
      KeyRepeat = 2;          # fast key repeat
      InitialKeyRepeat = 15;  # short delay before repeat
      _HIHideMenuBar = true;  # auto-hide the menu bar
      AppleShowAllExtensions = true;
    };
    dock.autohide = true;
    finder.FXPreferredViewStyle = "Nlsv";  # list view by default
    finder.CreateDesktop = false;          # clean desktop
    trackpad.Clicking = true;              # tap to click
  };
  nix-homebrew = {
    enable = true;
    inherit user;
    # Adopt the pre-existing /opt/homebrew instead of demanding a clean prefix.
    # Replaces the brew source tree with the nix-managed one; Cellar and
    # Caskroom (i.e. installed packages) are kept.
    autoMigrate = true;
  };
  homebrew = {
    enable = true;
    onActivation.cleanup = "none";  # keep undeclared packages ("zap" would remove them)
    onActivation.autoUpdate = true;
    onActivation.extraFlags = [ "--force" ];
    brews = [
      "herdr"
    ];
    casks = [
      "wezterm"
      "claude-code"
    ];
  };
}
