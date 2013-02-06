local BoardDataComparer = require("BoardDataComparer")
local BoardJsonDataLoader = require("BoardJsonDataLoader")
local BoardAction = require("BoardAction")

function getJsonTotalFileDir(  )
	
	local totalDir = {
		"ActionSetCard1/",
		"ActionMoveCard1/",
	}

	local totalJsonFileDir = {}

	for i,v in ipairs(totalDir) do
		
		local filePath = "../JsonData/" .. v
		totalJsonFileDir[i] = filePath

	end

	return totalJsonFileDir
end

for i,v in ipairs(getJsonTotalFileDir()) do
	
	print(i,v)
	local baseJson = BoardJsonDataLoader.getJsonTable(v .. "base.json")
	-- print('baseJson is: ' .. BoardJsonDataLoader.getJsonString(baseJson))

	local inputJson = BoardJsonDataLoader.getJsonTable(v .. "input.json")
	-- print('inputJson is: ' .. BoardJsonDataLoader.getJsonString(inputJson))

	local outputJson = BoardJsonDataLoader.getJsonTable(v .. "output.json")
	-- print('outputJson is: ' .. BoardJsonDataLoader.getJsonString(outputJson))

	assert(BoardDataComparer.compare(baseJson, outputJson) == false)

	print("assert base output not equal true");

	BoardAction.boardDoAction(baseJson, inputJson)

	assert(BoardDataComparer.compare(baseJson, outputJson) == true)

	print("assert base output is equal true");
end


