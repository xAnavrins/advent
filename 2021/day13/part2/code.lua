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

local function fold(paper, inst)
    local axis, pos = inst[1], inst[2]
    if axis == "x" then
        local half = maxX - pos
        for y = 0, maxY do
            for x = 1, half do
                if not paper[y] then paper[y] = {} end
                if paper[y][half+x] then
                    paper[y][half-x] = true
                end
                paper[y][half+x] = false
            end
        end
        maxX = pos-1

    elseif axis == "y" then
        local half = maxY - pos
        for x = 0, maxX do
            for y = 1, half do
                if not paper[half+y] then paper[half+y] = {} end
                if not paper[half-y] then paper[half-y] = {} end
                if paper[half+y][x] then
                    paper[half-y][x] = true
                end
                paper[half+y][x] = false
            end
        end
        maxY = pos-1
    end
    return paper
end

local function render(p, d)
    if d.clear then d.clear() end
    for y = 0, maxY do
        for x = 0, maxX do
            if d.setCursorPos then d.setCursorPos(x+1, y+1) end
            if p[y] and p[y][x] then
                d.write("#")
            else
                d.write(".")
            end
        end
        d.write("\n")
    end
    if d.close then d.close() end
end

for i = 1, #folds do
    fold(paper, folds[i])
end

render(paper, fs.open(fs.combine(filepaths.day, "/folded.txt"), "w"))

return "See folded.txt"
