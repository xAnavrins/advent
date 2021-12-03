local bitLen
local gamma = {}
local epsilon = {}
local total = 0

for line in input do
	if not bitLen then bitLen = #line end
	for i = 1, bitLen do
		gamma[i] = (gamma[i] or 0) + line:sub(i,i)
	end
	total = total + 1
end

for i = 1, bitLen do
	gamma[i] = (math.floor((gamma[i]/total) + 0.5))
	epsilon[i] = gamma[i] == 1 and 0 or 1
end

return tonumber(table.concat(gamma), 2) * tonumber(table.concat(epsilon), 2)
