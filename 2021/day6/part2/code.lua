local fishes = {}
for age = 0, 8 do fishes[age] = 0 end

for line in input do
	line:gsub("(%d+)", function(age)
		age = tonumber(age)
		fishes[age] = fishes[age] + 1
	end)
end

local function sum(t)
	local s = 0
	for _, a in pairs(t) do s = s + a end
	return s
end

for day = 1, 256 do
	local new = fishes[0]
	for age = 1, 8 do
		fishes[age - 1] = fishes[age]
	end
	fishes[6] = fishes[6] + new
	fishes[8] = new
end

return sum(fishes)
