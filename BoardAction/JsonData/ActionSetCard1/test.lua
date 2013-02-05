package.path = package.path .. ";../../ImpLua/?.lua"

local BoardDataComparer = require("BoardDataComparer")
local BoardJsonDataLoader = require("BoardJsonDataLoader")
local BoardAction = require("BoardAction")

local baseJson = BoardJsonDataLoader.getJsonTable("base.json")
-- print('baseJson is: ' .. BoardJsonDataLoader.getJsonString(baseJson))

local inputJson = BoardJsonDataLoader.getJsonTable("input.json")
-- print('inputJson is: ' .. BoardJsonDataLoader.getJsonString(inputJson))

local outputJson = BoardJsonDataLoader.getJsonTable("output.json")
-- print('outputJson is: ' .. BoardJsonDataLoader.getJsonString(outputJson))

assert(BoardDataComparer.compare(baseJson, outputJson) == false)

print("assert base output not equal true");

BoardAction.boardDoAction(baseJson, inputJson)

assert(BoardDataComparer.compare(baseJson, outputJson) == true)

print("assert base output is equal true");
