{ pkgs, lib, ... }:

{
  vim = {
    theme = {
    enable = true;
    name = "gruvbox";
    style = "dark";
    };

    statusLine.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;

    languages = {
      enableLSP = true;
      enableTreesitter = true;

      nix.enable = true;
      ts.enable = true;
      python.enable = true;
      rust.enable = true;
    };
  };
}
