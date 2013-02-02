local json = require('json')
local BoardActionTableComparer = require('BoardActionTableComparer')

print("is true : " .. tostring(BoardActionTableComparer.compare({}, {})))

function getJsonTable(filename)
	local f = assert(io.open(filename, "r"))
	local t = f:read("*all")
	f:close()

	return json.decode(t);
end

local baseJson = getJsonTable("../JsonData/ActionSetCard1/base.json")
print('baseJson is: ' .. json.encode(baseJson));

local inputJson = getJsonTable("../JsonData/ActionSetCard1/input.json")
-- print('inputJson[damage] is: ' .. inputJson["damage"]);

local outputJson = getJsonTable("../JsonData/ActionSetCard1/output.json")
-- print('outputJson[health] is: ' .. outputJson["health"]);
