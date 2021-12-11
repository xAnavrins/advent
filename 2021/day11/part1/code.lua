local octos = {}
local flashes = 0

for line in input do
	local row = {}
	line:gsub("%d", function(n)
		n = tonumber(n)
		table.insert(row, n)
	end)
	table.insert(octos, row)
end

local dirs = {
	{ 1, 0}, -- right
	{ 0, 1}, -- down
	{-1, 0}, -- left
	{ 0,-1}, -- up

	{ 1, 1}, -- down-right
	{ 1,-1}, -- up-right
	{-1, 1}, -- down-left
	{-1,-1}, -- up-left
}


local function flash(octos, x, y)
	flashes = flashes + 1
	octos[y][x] = -1
	for _, dir in ipairs(dirs) do
		local tx, ty = x + dir[1], y + dir[2]
		if (octos[ty] and octos[ty][tx]) and octos[ty][tx] ~= -1 then
			octos[ty][tx] = octos[ty][tx] + 1
			if octos[ty][tx] > 9 then
				flash(octos, tx, ty)
			end
		end
	end
end

for step = 1, 100 do
	for y, row in ipairs(octos) do
		for x in ipairs(row) do
			octos[y][x] = octos[y][x] + 1
		end
	end
	for y, row in ipairs(octos) do
		for x in ipairs(row) do
			if octos[y][x] == 10 then
				flash(octos, x, y)
			end
		end
	end
	for y, row in ipairs(octos) do
		for x in ipairs(row) do
			if octos[y][x] == -1 then
				octos[y][x] = 0
			end
		end
	end
end

return flashes
