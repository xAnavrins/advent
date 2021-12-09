local map = {}
for line in input do
	local row = {}
	line:gsub("%d", function(p)
		table.insert(row, tonumber(p))
	end)
	table.insert(map, row)
end

local dirs = {
	{ 1, 0}, -- right
	{ 0, 1}, -- down
	{-1, 0}, -- left
	{ 0,-1}, -- up
}

local sum = 0
for y, row in ipairs(map) do
	for x, pt in ipairs(row) do
		local low = true
		for _, dir in ipairs(dirs) do
			local tx, ty = x + dir[1], y + dir[2]
			if (map[ty] and map[ty][tx]) and (pt >= map[ty][tx]) then
				low = false
			end
		end

		if low then
			sum = sum + (pt + 1)
		end
	end
end

return sum
