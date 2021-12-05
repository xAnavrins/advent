local boards = {}
local b = 0

for line in input do
	if #line == 0 then
		b = b + 1
	else
		if b == 0 then
			boards[b] = {}
			line:gsub("(%d+)", function(num)
				table.insert(boards[b], tonumber(num))
			end)
		else
			if not boards[b] then boards[b] = {} end
			local row = #boards[b]+1
			boards[b][row] = {}
			line:gsub("(%d+)", function(num)
				table.insert(boards[b][row], {tonumber(num), false})
			end)
		end
	end
end

local winner
local winDraw
(function()
	for _, draw in ipairs(boards[0]) do
		print("Draw", draw)
		for nB, board in ipairs(boards) do
			for nR, row in ipairs(board) do
				for nC, column in ipairs(row) do
					if not column[2] then
						column[2] = column[1] == draw
					end
				end
			end
		end

		for nB, board in ipairs(boards) do
			for i = 1, 5 do
				if (board[i][1][2] and board[i][2][2] and board[i][3][2] and board[i][4][2] and board[i][5][2])
				or (board[1][i][2] and board[2][i][2] and board[3][i][2] and board[4][i][2] and board[5][i][2]) then
					print("Winner, board", nB, "draw", draw)
					winner = board
					winDraw = draw
					return
				end
			end
		end
	end
end)()

local sum = 0
for _, row in ipairs(winner) do
	for _, column in ipairs(row) do
		sum = sum + (column[2] == true and 0 or column[1])
	end
end

return sum * winDraw
