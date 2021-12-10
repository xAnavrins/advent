local lines = {}
for line in input do
	local chars = {}
	line:gsub(".", function(c)
		table.insert(chars, c)
	end)
	table.insert(lines, chars)
end

local scores = {
    ["("] = 1,
    ["["] = 2,
    ["{"] = 3,
    ["<"] = 4,
}

local scoresList = {}
for _, line in ipairs(lines) do
	local stack = {}
	local score = 0
	local corrupted = false

	for _, char in ipairs(line) do
		if char == "(" or char == "[" or char == "{" or char == "<" then
			table.insert(stack, char)
		else
			local p = table.remove(stack)
			if math.abs(char:byte() - p:byte()) > 2 then
				corrupted = true
				break
			end
		end
	end

	if not corrupted then
		while #stack ~= 0 do
			score = score * 5
			score = score + scores[table.remove(stack)]
		end
		table.insert(scoresList, score)
	end
end

table.sort(scoresList)
return scoresList[ math.ceil(#scoresList/2) ]
