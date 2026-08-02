

# nixos-dendritic

[![NixOS](https://img.shields.io/badge/NixOS-unstable-blue?logo=nixos&logoColor=white)](https://nixos.org)
[![flake-parts](https://img.shields.io/badge/built%20with-flake--parts-7a4c9d)](https://github.com/hercules-ci/flake-parts)

Configuración personal de NixOS de Adega que utiliza un patrón de descubrimiento de módulos **dendrítico** (basado en árbol) construido sobre [flake-parts](https://github.com/hercules-ci/flake-parts) y [import-tree](https://github.com/vic/import-tree).

Los módulos colocados en cualquier lugar dentro de `modules/` se descubren automáticamente y se hacen disponibles: no se necesitan listas de importación manuales.

## Hosts

| Host | Tipo | Hardware | Escritorio | Servicios |
|------|------|----------|------------|-----------|
| `sam` | Escritorio | AMD CPU/GPU | KDE | Docker, Podman, Bluetooth, Tailscale, Ollama, Plymouth, Wacom |
| `dean` | Portátil | Intel CPU/GPU | KDE | Podman, Bluetooth, Tailscale, Plymouth |
| `castiel` | Servidor | — | — | *Planificado* |

## Características

- **Descubrimiento dendrítico de módulos** — coloca un archivo `.nix` en cualquier lugar dentro de `modules/` y se importará automáticamente
- **Configuración por equipo** — archivos `configuration.nix` + `home.nix` + `hardware-configuration.nix` separados por máquina
- **Tematización declarativa** mediante [Stylix](https://github.com/danth/stylix) — tema oscuro, fuente Agave Nerd Font, cursor Bibata, objetivos de tema para Firefox/Librewolf
- **Home Manager** — gestión de paquetes y archivos de configuración (dotfiles) a nivel de usuario para cada equipo
- **Neovim (Nixvim)** — editor completamente personalizado con LSP, Telescope, Git, Copilot Chat y una interfaz pulida — ver [`nixvim`](./modules/home/dev/nixvim/README.md)
- **KDE Plasma** — configuración declarativa del escritorio mediante [plasma-manager](https://github.com/nix-community/plasma-manager)
- **Videojuegos** — Lutris, Heroic Games Launcher, Minecraft, FF14
- **Entornos de contenedores** — Docker y Podman sin privilegios de root
- **Flake-parts** — arquitectura de flakes modular y componible

## Configuración

Antes de implementar, establece tus valores personales en [`modules/hosts/variables.nix`](./modules/hosts/variables.nix):

| Variable | Descripción |
|---|---|
| `user.username` | Tu nombre de usuario de Unix |
| `user.email` | Tu dirección de correo electrónico (usada en la configuración de Git) |
| `user.hashedPassword` | Hash de tu contraseña de usuario (`mkpasswd -m sha-512`) |
| `rootHashedPassword` | Hash de la contraseña de root (`mkpasswd -m sha-512`) |

## Estructura

```
modules/
├── flake/              # Salidas a nivel de flake (integración de flake-parts, formateador, sistemas, variables)
│   ├── flake-parts.nix # Integración de flake-parts
│   ├── home.nix        # Generador de salidas de Home Manager
│   ├── nixos.nix       # Generador de configuración de NixOS
│   ├── stylix.nix      # Tematización declarativa
│   ├── formatter.nix   # nix fmt (nixfmt)
│   ├── systems.nix     # Sistemas compatibles
│   └── variables.nix   # Opciones compartidas (nombre de usuario, correo, stateVersion)
├── hosts/              # Configuraciones por máquina
│   ├── sam/            # Escritorio: configuration.nix, home.nix, hardware-configuration.nix
│   ├── dean/           # Portátil: configuration.nix, home.nix, hardware-configuration.nix
│   ├── castiel/        # Servidor (marcador de posición)
│   └── variables.nix   # Variables globales compartidas entre equipos
├── nixos/              # Módulos compartidos del sistema NixOS
│   ├── core/           # Arranque, configuración regional, SSH, cuentas de usuario
│   ├── desktop/        # Audio, red, energía, videojuegos, gestores de escritorio
│   ├── services/       # Tailscale, Ollama
│   ├── bluetooth.nix   # Soporte para hardware Bluetooth
│   ├── docker.nix      # Motor de contenedores Docker
│   ├── podman.nix      # Podman sin privilegios de root
│   ├── plymouth.nix    # Pantalla de arranque
│   ├── vm.nix          # Soporte de virtualización
│   └── wacom.nix       # Soporte para tabletas Wacom
└── home/               # Módulos de usuario de Home Manager
    ├── dev/            # Herramientas de desarrollo (Alacritty, Git, Zsh, Zoxide, Direnv, Nixvim)
    ├── games/          # Videojuegos (Lutris, Heroic, Minecraft, FF14)
    ├── office/         # Productividad (Obsidian, OnlyOffice)
    ├── bottles.nix     # Contenedores para software de Windows
    ├── discord.nix
    ├── firefox.nix
    ├── gtk.nix
    ├── librewolf.nix
    ├── opencode.nix
    ├── plasma-manager.nix
    └── udiskie.nix

wallpapers/             # Fondos de pantalla (5 imágenes) — ver wallpapers/README.md
```

## Requisitos previos

- NixOS con flakes habilitados
- Comando Nix configurado con `experimental-features = nix-command flakes` (ya es el valor predeterminado en NixOS)

## Uso

### Aplicar la configuración del sistema

```bash
# Reemplaza <host> por sam, dean o castiel
sudo nixos-rebuild switch --flake .#<host>
```

### Aplicar solo Home Manager

```bash
home-manager switch --flake .#<host>
```

### Actualizar entradas del flake

```bash
nix flake update
```

### Formatear todos los archivos Nix

```bash
nix fmt
```

### Verificar la integridad del flake

```bash
nix flake check
```

## Añadir un nuevo equipo

1. Crea un directorio dentro de `modules/hosts/<name>/`
2. Añade `configuration.nix`, `home.nix` y `hardware-configuration.nix`
3. La arquitectura dendrítica descubre automáticamente el nuevo equipo

## Añadir un nuevo módulo

Simplemente crea un archivo `.nix` en cualquier lugar dentro de `modules/` y estará disponible automáticamente mediante `config.flake.modules.nixos.<name>` (para `modules/nixos/`) o `config.flake.modules.homeManager.<name>` (para `modules/home/`).
