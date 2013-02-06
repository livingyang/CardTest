local BoardDataComparer = require("BoardDataComparer")
local BoardJsonDataLoader = require("BoardJsonDataLoader")
local BoardAction = require("BoardAction")

function getJsonTotalFileDir(  )
	
	local totalDir = {
		"ActionSetCard1/",
		-- "ActionSetCardWithUpSkill/",
		"ActionMoveCard1/",
	}

	local totalJsonFileDir = {}

	for i,v in ipairs(totalDir) do
		
		local filePath = "../JsonData/" .. v
		totalJsonFileDir[i] = filePath

	end

	return totalJsonFileDir
end

local table1 = {a=5}
local table2 = {a=5}

function isTableContainedTable( table1, table2 )

	if type(table1) ~= "table" or type(table2) ~= "table" then return false end

	for k,v in pairs(table1) do
		if type(v) == "table" then
			if isSameTable(v, table2[k]) == false then
				return false
			end
		elseif v ~= table2[k] then
			return false
		end
	end

	return true
end

function isSameTable( table1, table2 )
	return isTableContainedTable(table1, table2) and isTableContainedTable(table2, table1)
end

print("isContainedTable: " .. tostring(isTableContainedTable(table1, table2)))
print("isSameTable: " .. tostring(isSameTable(table1, table2)))

for i,v in ipairs(getJsonTotalFileDir()) do
	
	print(i,v)
	local baseJson = BoardJsonDataLoader.getJsonTable(v .. "base.json")
	-- print('baseJson is: ' .. BoardJsonDataLoader.getJsonString(baseJson))

	local inputJson = BoardJsonDataLoader.getJsonTable(v .. "input.json")
	-- print('inputJson is: ' .. BoardJsonDataLoader.getJsonString(inputJson))

	local outputJson = BoardJsonDataLoader.getJsonTable(v .. "output.json")
	-- print('outputJson is: ' .. BoardJsonDataLoader.getJsonString(outputJson))

	-- assert(BoardDataComparer.compare(baseJson, outputJson) == false)

	assert(isSameTable(baseJson, outputJson) == false)
	print("assert base output not equal true");

	BoardAction.boardDoAction(baseJson, inputJson)

	-- assert(BoardDataComparer.compare(baseJson, outputJson) == true)

	assert(isSameTable(baseJson, outputJson) == true)
	print("assert base output is equal true");
end


