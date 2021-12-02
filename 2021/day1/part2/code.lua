local inc = 0
local nums = {}
local lastSum
local i = 1

for line in input do
	nums[i] = tonumber(line)
	if nums[i] and nums[i-1] and nums[i-2] then
		local sum = nums[i] + nums[i-1] + nums[i-2]
		if lastSum and sum > lastSum then inc = inc + 1 end
		lastSum = sum
	end
	i = i + 1
end

return inc
