local BoardDataComparer = require("BoardDataComparer")
local BoardJsonDataLoader = require("BoardJsonDataLoader")
local table = require("table")
local tonumber = tonumber
local tostring = tostring
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
local MaxTeamCount = 2

function isValidSlotPosition( slotPosition )
	return slotPosition > 0 and slotPosition <= MaxSlotCount
end

function isValidTeamPosition( teamPosition )
	return teamPosition > 0 and teamPosition <= MaxSlotCount
end

function addCardSupportToSlotList( slotList, slotPosition, cardSupport )
	if slotList == nil or isValidSlotPosition(slotPosition) == false then return end

	for i,v in ipairs(getCardSupportPosition(slotPosition)) do
		slotList[v].support = slotList[v].support + cardSupport
	end
end

function getSlotFromList( slotList, slotPosition )
	if slotList == nil or isValidSlotPosition(slotPosition) == false then return end

	if table.getn(slotList) ~= MaxSlotCount then
		print("getSlotFromList slot count is invalid: " .. table.getn(slotList))
		return nil
	end

	return slotList[slotPosition]
end

function setCardToSlot( slotList, slotPosition, card )

	local slot = getSlotFromList(slotList, slotPosition)

	if slot.card ~= nil then
		print("setCardToSlot slot.card ~= nil")
		return
	end

	slot.card = card
	addCardSupportToSlotList(slotList, slotPosition, card.support)
end

function removeSlotCard( slotList, slotPosition )
	
	local slot = getSlotFromList(slotList, slotPosition)

	if slot.card == nil then
		print("removeSlotCard slot.card == nil")
		return
	end

	addCardSupportToSlotList(slotList, slotPosition, -slot.card.support)
	slot.card = nil
end

function getTeamSlotList( board, teamPosition )
	
	local teamList = board and board["team-list"]
	local team = teamList and teamList[teamPosition]

	return team and team["slot-list"]
end

function actionSetCard( board, action )
	if board == nil or action == nil then return end

	setCardToSlot(getTeamSlotList(board, action["team-position"]), action["slot-position"], action.card)

	if action.card["skill-list"] ~= nil then

		local skillList = action.card["skill-list"]
	end
end

function actionMoveCard( board, action )
	if board == nil or action == nil then return end

	local slotList = getTeamSlotList(board, action["team-position"])

	local oldCardPosition = action["old-card-position"]
	local newCardPosition = action["new-card-position"]

	local moveCard = slotList[oldCardPosition].card
	if moveCard ~= nil and slotList[newCardPosition].card == nil then

		removeSlotCard(slotList, oldCardPosition)
		setCardToSlot(slotList, newCardPosition, moveCard)
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
