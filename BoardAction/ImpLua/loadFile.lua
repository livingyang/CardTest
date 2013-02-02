local json = require('json')

function getJsonTable(filename)
	local f = assert(io.open(filename, "r"))
	local t = f:read("*all")
	f:close()

	return json.decode(t);
end

local baseJson = getJsonTable("../base.json")
-- print('baseJson[health] is: ' .. baseJson["health"]);

local inputJson = getJsonTable("../input.json")
-- print('inputJson[damage] is: ' .. inputJson["damage"]);

local outputJson = getJsonTable("../output.json")
-- print('outputJson[health] is: ' .. outputJson["health"]);

assert(baseJson.health - inputJson.damage == outputJson.health)

-- print('test success!!')