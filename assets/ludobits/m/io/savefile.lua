--- Save and load using the io.* functions
--
-- @usage
-- local savefile = require "ludobits.m.io.savefile"
--
-- local file = savefile.open("foobar")
-- file.save("something large to save")
-- local data = file.load()
-- print(data) -- "something large to save"

local file = require "assets/ludobits/m/io/file"

local M = {}

--- Open a file for reading and writing using the io.* functions
-- @param filename
-- @return file instance
function M.open(filename)
	local path = file.get_save_file_path(filename)
	local instance = {}

	--- Load the table stored in the file
	-- @param mode The read mode, defaults to "rb"
	-- @return contents File contents or nil if something went wrong
	-- @return error_message Error message if something went wrong while reading
	function instance.load(mode)
		local f, err = io.open(path, mode or "rb")
		if err then
			return nil, err
		end
		return f:read("*a")
	end

	--- Save string to the file
	-- @param s The string to save
	-- @param mode The write mode, defaults to "wb"
	-- @return success
	-- @return error_message
	function instance.save(s, mode)
		assert(s and type(s) == "string", "You must provide a string to save")
		local f, err = io.open(path, mode or "wb")
		if err then
			return nil, err
		end
		f:write(s)
		f:flush()
		f:close()
		return true
	end

	return instance
end



return M
