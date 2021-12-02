local inc = 0
local lastNum

for line in input do
  local num = tonumber(line)
  if lastNum then
    if num > lastNum then inc = inc + 1 end
  end
  lastNum = num
end

return inc