#!/bin/bash
set -e

# Necessário para copiar dotfiles ocultos de home/ (ex.: .bashrc)
shopt -s dotglob nullglob

DOTFILES="${DOTFILES:-$HOME/dotfiles}"
THEMES_DIR="$DOTFILES/themes"
ACTIVE_FILE="$THEMES_DIR/.active"
DEFAULT_THEME="purple-blue"

usage() {
  cat <<EOF
Uso: $(basename "$0") [opções]

Opções:
  -t, --theme <nome>   Instala um tema específico (sem perguntar)
      --list-themes    Lista os temas disponíveis
  -h, --help           Mostra esta ajuda

Variáveis de ambiente:
  DOTFILES             Caminho do repositório (padrão: \$HOME/dotfiles)
  DOTFILES_THEME       Mesmo efeito de --theme
EOF
}

theme_description() {
  local dir="$1"
  local name desc
  name="$(basename "$dir")"
  desc=""
  THEME_NAME=""
  THEME_DESCRIPTION=""
  # shellcheck disable=SC1090
  if [ -f "$dir/theme.conf" ]; then
    source "$dir/theme.conf"
    name="${THEME_NAME:-$name}"
    desc="${THEME_DESCRIPTION:-}"
  fi
  if [ -n "$desc" ]; then
    printf '%s - %s' "$name" "$desc"
  else
    printf '%s' "$name"
  fi
}

list_themes() {
  local dir
  for dir in "$THEMES_DIR"/*/; do
    [ -f "$dir/theme.conf" ] || continue
    printf '  %s\n' "$(theme_description "${dir%/}")"
  done
}

select_theme() {
  local -a dirs=()
  local dir choice i

  for dir in "$THEMES_DIR"/*/; do
    [ -f "$dir/theme.conf" ] || continue
    dirs+=("${dir%/}")
  done

  if [ "${#dirs[@]}" -eq 0 ]; then
    echo "Nenhum tema encontrado em $THEMES_DIR" >&2
    exit 1
  fi

  echo "Temas disponíveis:" >&2
  for i in "${!dirs[@]}"; do
    printf '  %d) %s\n' "$((i + 1))" "$(theme_description "${dirs[$i]}")" >&2
  done

  while true; do
    read -rp "Escolha o tema [1]: " choice
    choice="${choice:-1}"
    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#dirs[@]}" ]; then
      basename "${dirs[$((choice - 1))]}"
      return 0
    fi
    echo "Opção inválida." >&2
  done
}

THEME="${DOTFILES_THEME:-}"

while [ $# -gt 0 ]; do
  case "$1" in
    -t|--theme)
      if [ -z "${2:-}" ]; then
        echo "Faltou o nome do tema depois de $1" >&2
        exit 1
      fi
      THEME="$2"
      shift 2
      ;;
    --list-themes)
      list_themes
      exit 0
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Opção desconhecida: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [ -z "$THEME" ]; then
  if [ -t 0 ]; then
    THEME="$(select_theme)"
  elif [ -f "$ACTIVE_FILE" ]; then
    THEME="$(tr -d '[:space:]' < "$ACTIVE_FILE")"
  else
    THEME="$DEFAULT_THEME"
  fi
fi

if [ ! -d "$THEMES_DIR/$THEME" ]; then
  echo "Tema '$THEME' não encontrado." >&2
  echo "Temas disponíveis:" >&2
  list_themes >&2
  exit 1
fi

# Estes arquivos não existem na config base: cada tema precisa fornecê-los.
THEME_REQUIRED_FILES=(
  "hypr/theme.conf"
  "eww/eww.scss"
  "hyprlock/colors.conf"
  "waybar/style.css"
)

missing=0
for rel in "${THEME_REQUIRED_FILES[@]}"; do
  if [ ! -f "$THEMES_DIR/$THEME/.config/$rel" ]; then
    echo "Tema '$THEME' não possui o arquivo obrigatório: .config/$rel" >&2
    missing=1
  fi
done
if [ "$missing" -eq 1 ]; then
  echo "Instalação cancelada." >&2
  exit 1
fi

mkdir -p "$HOME/.config"
echo "$THEME" > "$ACTIVE_FILE"
echo "Tema selecionado: $THEME"

# .config/ -> ~/.config/
if [ -d "$DOTFILES/.config" ]; then
  for item in "$DOTFILES"/.config/*; do
    name=$(basename "$item")
    target="$HOME/.config/$name"
    if [ -e "$target" ] || [ -L "$target" ]; then
      rm -rf "$target"
    fi
    cp -a "$item" "$target"
    echo "copy ~/.config/$name OK"
  done
fi

# Tema -> ~/.config/ (sobrescreve os arquivos do tema)
if [ -d "$THEMES_DIR/$THEME/.config" ]; then
  cp -a "$THEMES_DIR/$THEME/.config/." "$HOME/.config/"
  echo "theme $THEME applied OK"
fi

# home/ -> $HOME/
if [ -d "$DOTFILES/home" ]; then
  for item in "$DOTFILES"/home/*; do
    name=$(basename "$item")
    target="$HOME/$name"
    if [ -e "$target" ] || [ -L "$target" ]; then
      rm -rf "$target"
    fi
    cp -a "$item" "$target"
    echo "copy ~/$name OK"
  done
fi
