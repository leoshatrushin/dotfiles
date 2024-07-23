_G.ReloadMode = false

function Reload(module)
	_G.ReloadMode = true
	local status, err = pcall(function()
		package.loaded[module] = nil
		require(module)
	end)
	_G.ReloadMode = false -- Reset ReloadMode even if an error occurred
	if not status then
		error(err) -- Rethrow the error
	end
end

require("leoshatrushin")
