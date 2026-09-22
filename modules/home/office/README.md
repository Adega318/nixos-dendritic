# Office & Productivity Modules

This directory contains Home Manager modules for productivity and document handling. Each file exposes `flake.modules.homeManager.<name>` — import individually (no aggregator).

## Modules

| Module | File | Description |
|--------|------|-------------|
| `calibre` | `calibre.nix` | Calibre e-book manager |
| `obsidian` | `obsidian.nix` | Obsidian knowledge base / markdown notes |
| `onlyoffice` | `onlyoffice.nix` | OnlyOffice document suite |

## Usage

```nix
# modules/hosts/sam/home.nix — all three
imports = with config.flake.modules.homeManager; [
  calibre
  obsidian
  onlyoffice
];

# modules/hosts/dean/home.nix — subset
imports = with config.flake.modules.homeManager; [
  obsidian
  onlyoffice
];
```

To add a new office tool: create `modules/home/office/my-tool.nix` with `flake.modules.homeManager.my-tool = { pkgs, ... }: { home.packages = with pkgs; [ my-tool ]; };` — auto-discovered via `import-tree`.
