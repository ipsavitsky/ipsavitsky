{ pkgs, ... }: {
  users = {
    users.ipsavitsky = {
      isNormalUser = true;
      packages = with pkgs; [];
    };
  };
}
