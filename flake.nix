{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
  };

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      formatter.${system} = pkgs.nixfmt-rfc-style;
      devShells.${system} = {
        default = pkgs.mkShell {
          packages = with pkgs; [
            nil
            terraform-ls
            terraform
          ];
        };
      };
    };
}
