local year, day, part = ...

local isInit = year == "init"
if isInit then
    year, day = day, part
end

local setupPath = fs.combine("aoc", "setup")
local dayPath = fs.combine("aoc", year, "d"..day)
local partPath = fs.combine(dayPath, "p"..part, "run.lua")
local inputPath = fs.combine(dayPath, "input.txt")

if isInit then
    local exists = fs.exists(dayPath)
    if not exists then
        fs.copy(setupPath, dayPath)
    end
    return print("Folder for AOC", year, "day", day, exists and "already exists" or "created")
end

_ENV.input = io.lines(inputPath)
_ENV.split = function (s, p)
	local t = {}
	s:gsub("([^"..p.."]+)", function(v) t[#t + 1] = v end)
	return t
end

local loaded, err = loadfile(partPath, nil, _ENV)

if loaded then
    local result = loaded()
    term.setTextColor(colors.yellow)
    write("\nResult: ")
    term.setTextColor(colors.white)
    print(result)
else
    printError(err)
end
