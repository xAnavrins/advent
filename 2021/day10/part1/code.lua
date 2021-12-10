local lines = {}
for line in input do
	local chars = {}
	line:gsub(".", function(c)
		table.insert(chars, c)
	end)
	table.insert(lines, chars)
end

local scores = {
    [")"] = 3,
    ["]"] = 57,
    ["}"] = 1197,
    [">"] = 25137,
}

local score = 0
for _, line in ipairs(lines) do
	local stack = {}
	for _, char in ipairs(line) do
		if char == "(" or char == "[" or char == "{" or char == "<" then
			table.insert(stack, char)
		else
			local p = table.remove(stack)
			if math.abs(char:byte() - p:byte()) > 2 then
				score = score + scores[char]
				break
			end
		end
	end
end

return score
