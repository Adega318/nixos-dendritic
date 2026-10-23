# Wallpapers

Wallpapers used by [Stylix](https://github.com/danth/stylix) for system theming.

## Available Wallpapers

- `cat.png`
- `gigant_cat.png`
- `hail_mary.png`
- `lighthouse.png`
- `linux_atari.png` - Used by host `sam`
- `lucifer.png`
- `nix.png`
- `pragmata.png`

## Usage

Wallpapers are referenced in host configurations:

```nix
wallpaper = ../../../wallpapers/linux_atari.png;
```

Stylix uses the wallpaper to generate color schemes when using base16 schemes or can extract colors automatically.

## Adding Wallpapers

Simply add image files to this directory and reference them in your host configuration.
