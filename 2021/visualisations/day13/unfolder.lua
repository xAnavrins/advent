local foldcount, inpath, outpath = ...
outpath = outpath or inpath

local folded = {}
local j = 0
for line in io.lines(shell.resolve(inpath)) do
    local row = {}
    local i = 0
    line:gsub(".", function(c)
        row[i] = c == "#"
        folded.x = i
        i=i+1
    end)
    folded[j] = row
    folded.y = j
    j=j+1
end

local function render(p, d)
    if d.clear then d.clear() end
    for y = 0, p.y do
        for x = 0, p.x do
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

local function unfold(p)
    local axis = math.max(p.y, p.x) == p.y and "x" or "y"
    local half = axis == "y" and p.y+1 or p.x+1
    if axis == "x" then
        for y = 0, p.y do
            for x = 1, half do
                if not p[y] then p[y] = {} end
                if p[y][half-x] then
                    local r = math.random(0, 1)
                    p[y][half-x] = bit32.band(r, 1) ~= 0
                    p[y][half+x] = bit32.band(r, 1) == 0
                end
            end
        end
        p.x = (p.x * 2) + 1

    elseif axis == "y" then
        for x = 0, p.x do
            for y = 1, half do
                if not p[half+y] then p[half+y] = {} end
                if not p[half-y] then p[half-y] = {} end
                if p[half-y][x] then
                    local r = math.random(0, 1)
                    p[half-y][x] = bit32.band(r, 1) ~= 0
                    p[half+y][x] = bit32.band(r, 1) == 0
                end
            end
        end
        p.y = (p.y * 2) + 1
    end
    return {axis, half}
end

local function makeInput(p, ifolds, f)
    for y = 0, p.y do
        for x = 0, p.x do
            if p[y] and p[y][x] then
                f.writeLine(tostring(x)..","..tostring(y))
            end
        end
    end
    f.writeLine()
    for i = #ifolds, 1, -1 do
        f.writeLine("fold along "..ifolds[i][1].."="..ifolds[i][2])
    end
    f.close()
end

render(folded, term)
local folds = {}
for i = 1, foldcount do
    table.insert(folds, unfold(folded))
end
print("Size: ", folded.x, folded.y)
print("Write to file? Y/n")
while true do
    local _, k = os.pullEvent("key")
    if k == keys.n then print("Cancelled") return
    elseif k == keys.y or k == keys.enter then break end
end
print("Done")
makeInput(folded, folds, fs.open(shell.resolve(outpath), "w"))
