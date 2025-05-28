# Nix Darwin setup for my work mac book.

This repo contains my system level configuration and packages for my MacBook Pro.

Used in tandem with my [mac home manager setup](https://github.com/palani-johnson/mac-home-manager), which provides user level configuration.

## Rebuild

```sh
darwin-rebuild switch --flake ~/.config/nix-darwin
```
