local table = require("table")
local print = print
local tostring = tostring
-- local _G = _G

module("BoardActionTableComparer")

local MaxSlotCount = 6
local MaxTeamCount = 2

function is_valid_team_data( team )
	
	local slotList = team["slot-list"]
	
	if table.getn(slotList) ~= MaxSlotCount then
		return false
	end

end

function is_valid_board_data( board )
	
	local teamList = board["team-list"]

	if teamList == nil or table.getn(teamList) ~= MaxTeamCount then
		
		print("is_valid_board_data error teamList = " .. tostring(teamList))

		return false
	end

	-- for

end

function compare( table1, table2 )
	-- if table.getn(table1)
	return is_valid_board_data(table1) and is_valid_board_data(table2)
end
