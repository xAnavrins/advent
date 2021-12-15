local template
local insertions = {}
local elements = {}
for line in input do
    if not template then
        template = {}
        line:gsub("()(.)", function(c, e)
            local pair = line:sub(c, c+1)
            elements[e] = (elements[e] or 0) + 1
            if #pair == 2 then
                template[pair] = (template[pair] or 0) + 1
            end
        end)
    end
    line:gsub("(%a+) %-> (%a+)", function(a,b)
        insertions[a] = b
    end)
end

for step = 1, 40 do
    local template_step = {}
    for pair, freq in pairs(template) do
        for ipair, insert in pairs(insertions) do
            if pair == ipair then
                local left, right, mid = pair:sub(1, 1), pair:sub(2, 2), insert
                template_step[left..mid] = (template_step[left..mid] or 0) + freq
                template_step[mid..right] = (template_step[mid..right] or 0) + freq
                elements[mid] = (elements[mid] or 0) + freq
            end
        end
    end
    template = template_step
end

local min, max = math.huge, -1
for _, element in pairs(elements) do
    min = math.min(min, element)
    max = math.max(max, element)
end

return max - min
