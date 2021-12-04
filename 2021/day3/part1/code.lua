local bitLen
local gamma = {}
local epsilon = {}
local total = 0

for line in input do
	if not bitLen then bitLen = #line end
	line:gsub("()(.)", function(pos, num)
		gamma[pos] = (gamma[pos] or 0) + num
	end)
	total = total + 1
end

for i = 1, bitLen do
	local moreOnes = gamma[i] > (total - gamma[i])
	gamma[i] = moreOnes and 1 or 0
	epsilon[i] = moreOnes and 0 or 1
end

return tonumber(table.concat(gamma), 2) * tonumber(table.concat(epsilon), 2)
