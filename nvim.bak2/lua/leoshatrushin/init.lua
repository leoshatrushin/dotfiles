local req = _G.ReloadMode and Reload or require

local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    print("Installing packer.nvim...")
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    print("Installed packer.nvim.")
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

if packer_bootstrap then
  require("leoshatrushin.packer")
end

req("leoshatrushin.remap")
req("leoshatrushin.set")
req("leoshatrushin.autocommand")
