_: {
  imports = [ ../../modules/full-stack.nix ];

  home = {
    stateVersion = "24.11";
    username = "ilyasavitsky";
    homeDirectory = "/home/ilyasavitsky";
  };

  programs.bash = {
    initExtra = ''
      source "$HOME/.cargo/env"
      source "$HOME/.ghcup/env"
      PS1="\[\033[1;32m\][\u@\h:\w]\$\[\033[0m\] "
    '';

    shellAliases = {
      ls = "ls --color=auto";
      grep = "grep --color=auto";
    };

    sessionVariables = {
      BUN_INSTALL = "$HOME/.bun";
      PATH = "$BUN_INSTALL/bin:/usr/local/go/bin:$PATH";
      GOPATH = "$HOME/go";
      GOBIN = "$GOPATH/bin";
    };
  };
}
