local values = {}

for line in input do
	line = split(line, "|")
	local inputs = {}
	local outputs = {}
	line[1]:gsub("(%w+)", function(p) table.insert(inputs, p) end)
	line[2]:gsub("(%w+)", function(p) table.insert(outputs, p) end)
	table.insert(values, {inputs, outputs})
end

local function sumSegments(signals, segCount)
	local sum = 0
	signals:gsub(".", function(c)
		sum = sum + segCount[c]
	end)
	return sum
end

local function countSegments(digits)
	local segCount = {}
	for _, signals in ipairs(digits) do
		signals:gsub(".", function(c)
			segCount[c] = (segCount[c] or 0) + 1
		end)
	end
	return segCount
end

local seg = countSegments{
	"abcefg", "cf", "acdeg", "acdfg", "bcdf", "abdfg", "abdefg", "acf", "abcdefg", "abcdfg"
}
local decodedSums = {
	[seg.a + seg.b + seg.c + seg.e + seg.f + seg.g]			= 0,
	[seg.c + seg.f]											= 1,
	[seg.a + seg.c + seg.d + seg.e + seg.g]					= 2,
	[seg.a + seg.c + seg.d + seg.f + seg.g]					= 3,
	[seg.b + seg.c + seg.d + seg.f]							= 4,
	[seg.a + seg.b + seg.d + seg.f + seg.g]					= 5,
	[seg.a + seg.b + seg.d + seg.e + seg.f + seg.g]			= 6,
	[seg.a + seg.c + seg.f]									= 7,
	[seg.a + seg.b + seg.c + seg.d + seg.e + seg.f + seg.g]	= 8,
	[seg.a + seg.b + seg.c + seg.d + seg.f + seg.g]			= 9,
}

local sum = 0
for _, segments in ipairs(values) do
	local segCount = countSegments(segments[1])
	local num = 0
	for i, signals in ipairs(segments[2]) do
		num = num + ((10^(4-i)) * decodedSums[sumSegments(signals, segCount)])
	end
	sum = sum + num
end

return sum
