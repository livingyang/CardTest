local table = require("table")
local print = print
local tostring = tostring

module("BoardDataComparer")

local MaxSlotCount = 6
local MaxTeamCount = 2

function is_same_card( card1, card2 )
	
	if card1 == nil or card2 == nil then return false end

	return card1.health == card2.health 
	and card1.attack == card2.attack
	and card1.support == card2.support

end

function is_same_slot( slot1, slot2 )

	if slot1.support == nil or slot2.support == nil then return false end

	if slot1.support ~= slot2.support then return false end

	if slot1.card == nil and slot2.card == nil then
		return true
	elseif slot1.card ~= nil and slot2.card ~= nil then
		return is_same_card(slot1.card, slot2.card)
	else
		return false
	end
end

function is_same_team( team1, team2 )
	
	if team1 == nil or team2 == nil then return false end

	local slotList1 = team1["slot-list"]
	local slotList2 = team2["slot-list"]

	if table.getn(slotList1) ~= MaxSlotCount or table.getn(slotList2) ~= MaxSlotCount then return false end	

	for i=1,MaxSlotCount do
		if is_same_slot(slotList1[i], slotList2[i]) == false then return false end
	end

	return true
end

function is_same_teamList( teamList1, teamList2 )
	
	if teamList1 == nil or teamList2 == nil then return false end

	if table.getn(teamList1) ~= MaxTeamCount or table.getn(teamList2) ~= MaxTeamCount then return false end

	for i=1,MaxTeamCount do
		if is_same_team(teamList1[i], teamList2[i]) == false then return false end
	end

	return true
end

function compare( board1, board2 )

	if board1 == nil or board2 == nil then return false end

	local teamList1 = board1["team-list"]
	local teamList2 = board2["team-list"]

	if teamList1 == nil or teamList2 == nil then return false end

	return is_same_teamList(teamList1, teamList2)

end
