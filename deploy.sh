#!/usr/bin/env bash

# environment check
if ! command -v stow >/dev/null 2>&1; then
	echo "stow is not available"
	echo "Please install stow first"
	exit 1
fi

origin_dir=$(pwd)
work_dir=$(dirname "${BASH_SOURCE[0]}")

declare -A deploy_map
deploy_map=([common]="Linux Darwin FreeBSD" [unix]="Linux Darwin FreeBSD" [linux]="Linux" [macos]="Darwin")
declare -a order_list
order_list=("common" "unix" "linux" "macos")
ignorefiles=("YukiConfig.code-profile")
os_name=$(uname)

cd "$work_dir" || exit 1

for target in "${order_list[@]}"; do
	read -r -a support_os <<<"${deploy_map[$target]}"
	for support_os_item in "${support_os[@]}"; do
		if [[ "$support_os_item" == "$os_name" ]]; then
			ignore_command=""

			for ignore in "${ignorefiles[@]}"; do
				ignore_command="--ignore=$ignore $ignore_command"
			done
			command="stow --adopt --dotfiles $target $ignore_command -t $HOME"
			$command && echo "$target dotfiles deploy success." || echo "$target dotfiles deploy failed."
		fi
	done
done

# stow --adopt --dotfiles common --ignore=YukiConfig.code-profile -t ~
#
# # common config deploy
# echo "common dotfiles deploy success."
#
# #unix deplo
# if [[ "$os_name" == "Linux" || "$os_name" == "Darwin" || "$os_name" == "FreeBSD" ]]; then
# 	stow --adopt --dotfiles unix --ignore=YukiConfig.code-profile -t ~ && echo "unix dotfiles deploy success."
# fi
#
# if [[ "$os_name" == "Linux" ]]; then
# 	#linux deploy
# 	stow --adopt --dotfiles linux -t ~ && echo "linux dotfiles deploy success."
# elif [[ "$os_name" == "Darwin" ]]; then
# 	#MacOS deploy
# 	stow --adopt --dotfiles macos -t ~ && echo "macos dotfiles deploy success."
# fi

cd "$origin_dir" || exit 1
echo "All done, Ciallo ～(∠・ω< )⌒★"
