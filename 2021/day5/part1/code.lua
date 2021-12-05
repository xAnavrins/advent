local vents = {}
local map = {}
local maxX = -1
local maxY = -1
local overlaps = 0

for line in input do
	line:gsub("(%d+),(%d+) %-> (%d+),(%d+)", function(x1, y1, x2, y2)
		table.insert(vents, {
			{x = tonumber(x1), y = tonumber(y1)},
			{x = tonumber(x2), y = tonumber(y2)}
		})
	end)
end

local function addPoint(map, point)
	local x, y = point.x, point.y
	if not map[y] then map[y] = {} end
	map[y][x] = (map[y][x] or 0) + 1
end

for _, point in ipairs(vents) do
	if point[1].x == point[2].x or point[1].y == point[2].y then
		for y = point[1].y, point[2].y, point[1].y<point[2].y and 1 or -1 do
			maxY = math.max(maxY, y)
			for x = point[1].x, point[2].x, point[1].x<point[2].x and 1 or -1 do
				maxX = math.max(maxX, x)
				addPoint(map, {x = x, y = y})
			end
		end
	end
end

for y = 0, maxY do
	for x = 0, maxX do
		if map[y] and (map[y][x] or 0) >= 2 then
			overlaps = overlaps + 1
		end
	end
end

return overlaps
