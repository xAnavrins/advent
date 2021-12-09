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

local function findBassin(map, x, y)
	local c = 0
	local crawled = {}

	local function crawl(map, x, y)
		local pt = map[y][x]
		c = c + 1
		for _, dir in ipairs(dirs) do
			local tx, ty = x + dir[1], y + dir[2]
			local cs = tx..","..ty

			if (map[ty] and map[ty][tx]) then
				if not crawled[cs] and (map[ty][tx] < 9) and (map[ty][tx] > pt) then
					crawled[cs] = true
					crawl(map, tx, ty)
				end
			end
		end
	end

	crawl(map, x, y)
	return c
end

local sums = {}
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
			table.insert(sums, findBassin(map, x, y))
		end
	end
end

table.sort(sums)

return sums[#sums] * sums[#sums-1] * sums[#sums-2]
