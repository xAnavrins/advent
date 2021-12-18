local inpath, outpath = ...

local paper = {}
local folds = {}
local maxX, maxY = -1, -1

for line in io.lines(shell.resolve(inpath)) do
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

local function pause() os.pullEvent("key") end

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

local function render(p, d)
    if d.clear then d.clear() end
    for y = 0, paper.y do
        for x = 0, paper.x do
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

print(paper.x, paper.y) pause()
render(paper, term) pause()

for i = 1, #folds do
    fold(paper, folds[i])
    render(paper, term) pause()
end

render(paper, term)
if outpath then
    render(paper, fs.open(shell.resolve(outpath), "w"))
end
