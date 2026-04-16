local M = {}

local _cache = {}
-- pending callbacks waiting for a key to be resolved
local _pending = {}

--- Run fn asynchronously, cache the result, then call all pending callbacks.
--- fn receives a resolve(value) function it must call with the result (or nil).
local function async_cached(key, fn, cb)
	if _cache[key] ~= nil then
		cb(_cache[key] ~= false and _cache[key] or nil)
		return
	end
	if _pending[key] then
		table.insert(_pending[key], cb)
		return
	end
	_pending[key] = { cb }
	fn(function(value)
		_cache[key] = value ~= nil and value or false
		for _, pending_cb in ipairs(_pending[key]) do
			pending_cb(value)
		end
		_pending[key] = nil
	end)
end

local function run(cmd, cb)
	vim.system(vim.split(cmd, " "), { text = true }, function(result)
		if result.code == 0 then
			cb(result.stdout:gsub("\n", ""))
		else
			cb(nil)
		end
	end)
end

M.is_poetry_installed = function(cb)
	async_cached("is_poetry_installed", function(resolve)
		vim.system({ "poetry", "--version" }, { text = true }, function(result)
			resolve(result.code == 0 or nil)
		end)
	end, cb)
end

M.get_poetry_project_path = function(cb)
	async_cached("poetry_project_path", function(resolve)
		run("poetry env info --path", resolve)
	end, cb)
end

M.get_poetry_site_packages = function(cb)
	async_cached("poetry_site_packages", function(resolve)
		vim.system(
			{ "poetry", "run", "python", "-c", "import site; print(site.getsitepackages()[0])" },
			{ text = true },
			function(result)
				if result.code == 0 then
					resolve(result.stdout:gsub("\n", ""))
				else
					resolve(nil)
				end
			end
		)
	end, cb)
end

M.get_poetry_executable = function(cb)
	async_cached("poetry_executable", function(resolve)
		run("poetry env info --executable", resolve)
	end, cb)
end

return M
