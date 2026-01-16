{ pkgs, inputs, ... }:
{
  imports = [
    ./mcp.nix
  ];

  programs.opencode = {
    enable = true;
    package = inputs.nix-ai-tools.packages.${pkgs.system}.opencode;
    enableMcpIntegration = true;
  };
}
