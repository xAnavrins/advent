local bitLen
local oxValues = {}
local coValues = {}

for line in input do
	if not bitLen then bitLen = #line end
	table.insert(oxValues, line)
	table.insert(coValues, line)
end

for i = 1, bitLen do
	local oxOnes = {}
	local oxZeros = {}

	for _, num in ipairs(oxValues) do
		if num:sub(i, i) == "1" then
			table.insert(oxOnes, num)
		else
			table.insert(oxZeros, num)
		end
	end

	oxValues = #oxOnes >= #oxZeros and oxOnes or oxZeros
	if #oxValues == 1 then break end
end

for i = 1, bitLen do
	local coOnes = {}
	local coZeros = {}
	for _, num in ipairs(coValues) do
		if num:sub(i, i) == "1" then
			table.insert(coOnes, num)
		else
			table.insert(coZeros, num)
		end
	end

	coValues = #coOnes >= #coZeros and coZeros or coOnes
	if #coValues == 1 then break end
end

local oxy = tonumber(oxValues[1], 2)
local co = tonumber(coValues[1], 2)

return oxy * co
