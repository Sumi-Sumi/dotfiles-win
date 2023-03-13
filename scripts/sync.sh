#! /usr/bin/env bash
CONFIG_PATH=${1:-$XDG_CONFIG_HOME}
TARGET_CONFIGS=(
	nvim
	alacritty
	git
	lazygit
	navi
	oh-my-posh
)

if [[ $CONFIG_PATH ]]; then
	for conf in "${TARGET_CONFIGS[@]}"; do
		cp -Tfr "$CONFIG_PATH"/"$conf" ../.config
	done
	chmod 755 ../.config/*/*
else
	echo "Not exist CONFIG_PATH ($CONFIG_PATH)"
fi
