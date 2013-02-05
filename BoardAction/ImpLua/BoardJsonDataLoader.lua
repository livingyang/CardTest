local json = require("json")
local io = require("io")
local assert = assert

module("BoardJsonDataLoader")

function getJsonTable( filename )
	local f = assert(io.open(filename, "r"))
	local t = f:read("*all")
	f:close()

	return json.decode(t);
end

function getJsonString( jsonTable )
	return json.encode(jsonTable)
end
