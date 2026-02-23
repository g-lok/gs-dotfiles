#!/usr/bin/env bash

export GSDOT_PATH="$HOME/.local/share/gsdotfiles"
export GSDOT_SCRIPTS="$GSDOT_PATH/install.d"
export GSDOT_DOTFILES="$GSDOT_PATH/install.d/dotfiles"

## Print logo
case $BASH_VERSION in
4.* | 5.* | 6.*)
  source "$GSDOT_SCRIPTS/ascii.sh"
  ;;
*)
  cat <<'EOF'
  ________                 ________          __    _____.__.__                 
 /  _____/  ______         \______ \   _____/  |__/ ____\__|  |   ____   ______
/   \  ___ /  ___/  ______  |    |  \ /  _ \   __\   __\|  |  | _/ __ \ /  ___/
\    \_\  \\___ \  /_____/  |    `   (  <_> )  |  |  |  |  |  |_\  ___/ \___ \ 
 \______  /____  >         /_______  /\____/|__|  |__|  |__|____/\___  >____  >
        \/     \/                  \/                                \/     \/
EOF
  ;;
esac

## Begin
echo -e "\nBegin installation (or abort with ctrl+c)..."
echo "Cloning GSDotfiles..."
rm -rf ~/.local/share/gsdotfiles
git clone https://github.com/g-lok/gs-dotfiles.git ~/.local/share/gsdotfiles >/dev/null
# if [[ $OMAKUB_REF != "master" ]]; then
# 	cd ~/.local/share/gsdotfiles || exit 0
# 	git fetch origin "${OMAKUB_REF:-stable}" && git checkout "${OMAKUB_REF:-stable}"
# 	cd -
# fi

echo "Installation starting..."
source ~/.local/share/gsdotfiles/install.sh
