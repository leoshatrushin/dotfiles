pkill Dock
sudo nvram boot-args=-arm64e_preview_abi
echo "reboot required"
sudo yabai --uninstall-sa
sudo yabai --install-sa
sudo yabai --load-sa
