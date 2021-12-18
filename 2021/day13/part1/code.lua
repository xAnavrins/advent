local paper = {}
local folds = {}
local maxX, maxY = -1, -1
for line in input do
    line:gsub("(%d+),(%d+)", function(x, y)
        x, y = tonumber(x), tonumber(y)
        if not paper[y] then paper[y] = {} end
        paper[y][x] = true
        maxX = math.max(maxX, x)
        maxY = math.max(maxY, y)
    end)
    line:gsub("fold along (%a)=(%d+)", function(axis, pos)
        table.insert(folds, {axis, tonumber(pos)})
    end)
end

paper.x = maxX + ((maxX%2==1) and 1 or 0)
paper.y = maxY + ((maxY%2==1) and 1 or 0)

local function fold(paper, inst)
    local axis, pos = inst[1], inst[2]
    if axis == "x" then
        for y = 0, paper.y do
            for x = 1, pos do
                if not paper[y] then paper[y] = {} end
                if paper[y][pos+x] then
                    paper[y][pos-x] = true
                end
                paper[y][pos+x] = false
            end
        end
        paper.x = pos-1

    elseif axis == "y" then
        for x = 0, paper.x do
            for y = 1, pos do
                if not paper[pos+y] then paper[pos+y] = {} end
                if not paper[pos-y] then paper[pos-y] = {} end
                if paper[pos+y][x] then
                    paper[pos-y][x] = true
                end
                paper[pos+y][x] = false
            end
        end
        paper.y = pos-1
    end
    return paper
end

local function count(paper)
    local sum = 0
    for y = 0, paper.y do
        for x = 0, paper.x do
            sum = sum + (paper[y][x] and 1 or 0)
        end
    end
    return sum
end

return count(fold(paper, folds[1]))
