origin_dir=$(pwd)
work_dir=$(dirname "${BASH_SOURCE[0]}")

cd "$work_dir" || exit 1
# stow --adopt -t ~ . --ignore deploy.sh --ignore readme.md --ignore LICENSE

os_name=$(uname)
stow --adopt --dotfiles common -t ~

echo "common dotfiles deploy success."

if [[ "$os_name" == "Linux" || "$os_name" == "Darwin" || "$os_name" == "FreeBSD" ]]; then
  stow --adopt --dotfiles unix -t ~
  echo "unix dotfiles deploy success."
fi

if [[ "$os_name" == "Linux" ]]; then
  stow --adopt --dotfiles linux -t ~
  echo "linux dotfiles deploy success."
elif [[ "$os_name" == "Darwin" ]]; then
  stow --adopt --dotfiles macos -t ~
  echo "macos dotfiles deploy success."
fi
cd "$origin_dir" || exit 1
echo "All done, Ciallo ～(∠・ω< )⌒★"
