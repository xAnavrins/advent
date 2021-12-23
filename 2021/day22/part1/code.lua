local steps = {}
local reactor = {}
for line in input do
    line:gsub("(%a+) x=(%p?%d+)..(%p?%d+),y=(%p?%d+)..(%p?%d+),z=(%p?%d+)..(%p?%d+)", function(state, x1, x2, y1, y2, z1, z2)
        table.insert(steps, {
            state = state == "on",
            x = {min = tonumber(x1), max = tonumber(x2)},
            y = {min = tonumber(y1), max = tonumber(y2)},
            z = {min = tonumber(z1), max = tonumber(z2)},
        })
    end)
end

local count = 0
for _, step in ipairs(steps) do
    if step.x.min >= -50 and step.x.max <= 50 and step.y.min >= -50 and step.y.max <= 50 and step.z.min >= -50 and step.z.max <= 50 then
        for z = step.z.min, step.z.max do
            for y = step.y.min, step.y.max do
                for x = step.x.min, step.x.max do
                    if not reactor[z] then reactor[z] = {} end
                    if not reactor[z][y] then reactor[z][y] = {} end
                    local prev = reactor[z][y][x]
                    reactor[z][y][x] = step.state
                    if not prev and step.state then
                        count = count + 1
                    elseif prev and not step.state then
                        count = count - 1
                    end
                end
            end
        end
    end
end

return count
