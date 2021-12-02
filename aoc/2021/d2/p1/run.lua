local pos = 0
local depth = 0

local command = {
  forward = function(x)
    pos = pos + x
  end,
  down = function(x)
    depth = depth + x
  end,
  up = function(x)
    depth = depth - x
  end,
}

for line in input do
  local action, amount = line:gmatch("(%a+)%s(%d+)")()
  command[action](amount)
end
print("Position", pos)
print("Depth", depth)

return pos * depth