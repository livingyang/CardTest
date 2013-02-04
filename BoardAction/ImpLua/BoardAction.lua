local json = require('json')
local BoardDataComparer = require('BoardDataComparer')

function getJsonTable(filename)
	local f = assert(io.open(filename, "r"))
	local t = f:read("*all")
	f:close()

	return json.decode(t);
end

local baseJson = getJsonTable("../JsonData/ActionSetCard1/base.json")
-- print('baseJson is: ' .. json.encode(baseJson));

local inputJson = getJsonTable("../JsonData/ActionSetCard1/input.json")
-- print('inputJson is: ' .. json.encode(inputJson));

local outputJson = getJsonTable("../JsonData/ActionSetCard1/output.json")
-- print('outputJson[health] is: ' .. outputJson["health"]);

local supportUpArray =
{
	{2, 4},
	{1, 3, 5},
	{2, 6},
	{1, 5},
	{2, 4, 6},
	{3, 5}
}

local MaxSlotCount = 6

function addSupportToOtherSlot( slotList, slotPosition )
	if slotList == nil or slotPosition <= 0 or slotPosition > MaxSlotCount then return end

	if slotList[slotPosition].card == nil then return end

	local cardSupport = slotList[slotPosition].card.support

	for i,v in ipairs(supportUpArray[slotPosition]) do
		slotList[v].support = slotList[v].support + cardSupport
	end
end

function boardDoAction( board, action )

	if board == nil or action == nil then return end

	local teamList = board["team-list"]
	if teamList == nil then return end

	local team = teamList[tonumber(action["team-position"])]
	if team == nil then return end

	local slotList = team["slot-list"]
	if slotList == nil then return end

	local slotPosition = tonumber(action["slot-position"])
	local slot = slotList[slotPosition]
	if slot == nil then return end

	slot.card = action.card

	addSupportToOtherSlot(slotList, slotPosition)

	-- for i,v in ipairs(supportUpArray[slotPosition]) do
	-- 	slotList[i].support = slotList[i].support + tonumber(action.card.support)
	-- 	print(i,v.support)
	-- end
end

assert(BoardDataComparer.compare(baseJson, outputJson) == false)

boardDoAction(baseJson, inputJson)

assert(BoardDataComparer.compare(baseJson, outputJson) == true)
