local crabs = {}
local max = -1
local fuelNeed = math.huge

for line in input do
	line:gsub("(%d+)", function(pos)
		pos = tonumber(pos)
		max = math.max(max, pos)
		table.insert(crabs, pos)
	end)
end

local function triangle(n)
	return (n*(n+1))/2
end

for target = 0, max do
	local sum = 0
	for _, pos in ipairs(crabs) do
		sum = sum + triangle(math.abs(target - pos))
	end
	fuelNeed = math.min(fuelNeed, sum)
end

return fuelNeed
