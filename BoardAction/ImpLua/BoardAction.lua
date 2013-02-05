local BoardDataComparer = require('BoardDataComparer')
local BoardJsonDataLoader = require("BoardJsonDataLoader")
local tonumber = tonumber
local ipairs = ipairs
local print = print

module("BoardAction")

function getCardSupportPosition( cardSlotPosition )

	local cardSupportPositionArray =
	{
		{2, 4},
		{1, 3, 5},
		{2, 6},
		{1, 5},
		{2, 4, 6},
		{3, 5}
	}

	return cardSupportPositionArray[cardSlotPosition]
end

local MaxSlotCount = 6

function addSupportToOtherSlot( slotList, slotPosition )
	if slotList == nil or slotPosition <= 0 or slotPosition > MaxSlotCount then return end

	if slotList[slotPosition].card == nil then return end

	local cardSupport = slotList[slotPosition].card.support

	for i,v in ipairs(getCardSupportPosition(slotPosition)) do
		slotList[v].support = slotList[v].support + cardSupport
	end
end

function removeCardSupport( slotList, slotPosition )
	if slotList == nil or slotPosition <= 0 or slotPosition > MaxSlotCount then return end

	if slotList[slotPosition].card == nil then return end

	local cardSupport = slotList[slotPosition].card.support

	for i,v in ipairs(getCardSupportPosition(slotPosition)) do
		slotList[v].support = slotList[v].support - cardSupport
	end
end

function actionSetCard( board, action )
	
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

end

function actionMoveCard( board, action )
	if board == nil or action == nil then return end

	local teamList = board["team-list"]
	if teamList == nil then return end

	local team = teamList[tonumber(action["team-position"])]
	if team == nil then return end

	local slotList = team["slot-list"]
	if slotList == nil then return end

	local oldCardPosition = tonumber(action["old-card-position"])
	local newCardPosition = tonumber(action["new-card-position"])

	if slotList[oldCardPosition].card ~= nil and slotList[newCardPosition].card == nil then

		removeCardSupport(slotList, oldCardPosition)
		slotList[newCardPosition].card = slotList[oldCardPosition].card
		slotList[oldCardPosition].card = nil
		addSupportToOtherSlot(slotList, newCardPosition);

	end
end

function boardDoAction( board, action )

	if board == nil or action == nil then return end

	if action.command == "set-card" then
		actionSetCard(board, action)
	elseif action.command == "move-card" then
		actionMoveCard(board, action)
	end

end
