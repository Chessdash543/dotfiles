My Arch Linux dotfiles featuring switchable desktop themes (purple-blue and sunset), based on monasm's dotfiles but recolored
# Preview
<img width="1366" height="768" alt="20261021_205157" src="https://github.com/user-attachments/assets/6973626d-962a-4acb-9880-1b4faf8debc5" />
<img width="1366" height="768" alt="20261021_205300" src="https://github.com/user-attachments/assets/345703c4-4ed8-4785-8c00-293bda4f4ed0" />
<img width="1366" height="768" alt="20261021_205316" src="https://github.com/user-attachments/assets/20cb82d7-1a4b-4716-a763-773cee78e3a7" />

# Installation

You just need to clone the repository and run the install.sh script.
copy and paste this comands:

```bash
git clone https://github.com/Chessdash543/dotfiles.git
cd dotfiles
./install.sh
```

# Themes

The desktop colors are split into themes. The base `.config/` keeps everything
that is not theme-specific, and each theme only overrides the files it needs.
The themed apps are `hypr`, `eww`, `hyprlock` and `waybar`.

```text
themes/
├── .active                 # active theme (managed by install-dotfiles.sh)
├── purple-blue/
│   ├── theme.conf          # name, description and accent colors
│   └── .config/
│       ├── hypr/theme.conf
│       ├── eww/eww.scss
│       ├── hyprlock/colors.conf
│       └── waybar/style.css
└── sunset/
    ├── theme.conf
    └── .config/
        └── ...
```

## Install a theme

Interactive (asks which theme to use):

```bash
./install-dotfiles.sh
```

Non-interactive:

```bash
./install-dotfiles.sh --theme sunset
./install-dotfiles.sh --list-themes
```

`install.sh` also accepts the same options:

```bash
./install.sh --theme sunset
```

## Edit a theme with `dots`

The `dots` script reads the active theme from `themes/.active`. To choose which
theme you are editing, apply it to `~/.config` and make it active:

```bash
./dots theme sunset       # apply sunset and make it the active theme
./dots theme              # interactive menu
./dots themes             # list themes
./dots current            # show the active theme
```

After editing files in `~/.config`, run `./dots` normally. It syncs the changes
back to `themes/<active-theme>/.config/` instead of the base `.config/`.

If `~/.config` has unsynced changes for the current theme, `dots theme` refuses
to switch. Run `./dots` first to save them, or use `--force` to discard them:

```bash
./dots theme purple-blue --force
```

## Add a new theme

1. Create the theme directory:

   ```bash
   mkdir -p themes/my-theme/.config/{hypr,eww,hyprlock,waybar}
   ```

2. Copy the files you want to override from `themes/purple-blue/.config/`.

3. Create `themes/my-theme/theme.conf`:

   ```bash
   THEME_NAME="my-theme"
   THEME_DESCRIPTION="My custom colors"
   THEME_ACCENT="#FF7A3D"
   THEME_ACCENT_ALT="#FF3D8A"
   ```

4. Install it with `./install-dotfiles.sh --theme my-theme`.

The `dots` script detects the active theme and syncs changes from the live
config back to that theme's files, keeping the base `.config/` clean.

# Additional Information

The repository is open to pull requests; if you encounter any issues with the dotfiles or the script, feel free to open an issue.
