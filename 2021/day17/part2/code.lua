local target = {}
for line in input do
    line:gsub("target area: x=(.+), y=(.+)", function(x, y)
        local x, y = split(x, ".."), split(y, "..")
        target.x1, target.x2 = tonumber(x[1]), tonumber(x[2])
        target.y1, target.y2 = tonumber(y[1]), tonumber(y[2])
    end)
end

local function sign(n)
    if n == 0 then return 0 end
    return n/math.abs(n)
end

local seekX, seekY = target.x2, math.abs(target.y1)
local goodVels = {}

for idy = -seekY, seekY do
    for idx = 0, seekX+1 do
        local height = 0
        local probe_x, probe_y = 0, 0
        local dx, dy = idx, idy
        for i = 0, 300 do
            probe_x, probe_y = probe_x + dx, probe_y + dy
            dx, dy = dx - sign(dx), dy - 1

            if probe_y > height then height = probe_y end
            if probe_x >= target.x1 and probe_x <= target.x2 and probe_y >= target.y1 and probe_y <= target.y2 then
                table.insert(goodVels, {idx, idy})
                break
            end
        end
    end
end

return #goodVels
