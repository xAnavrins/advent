local year, day, part = ...

local isInit = year == "init"
if isInit then
	year, day = day, part
end

local setupPath = "/setup"
local dayPath = fs.combine(year, "day"..day)
local inputPath = fs.combine(dayPath, "input.txt")
local partPath = fs.combine(dayPath, "part"..part)
local codePath = fs.combine(partPath, "code.lua")
local answerPath = fs.combine(partPath, "answer.txt")

if isInit then
	local exists = fs.exists(dayPath)
	if not exists then
		fs.copy(setupPath, dayPath)
	end
	return print("Folder for AOC", year, "day", day, exists and "already exists" or "created")
end

_ENV.pause = function() os.pullEvent("key") end
_ENV.yield = function() os.pullEvent("yield", os.queueEvent("yield")) end
_ENV.input = io.lines(inputPath)
_ENV.split = function (s, p)
	local t = {}
	s:gsub("([^"..p.."]+)", function(v) t[#t + 1] = v end)
	return t
end

local loaded, err = loadfile(codePath, nil, _ENV)

if loaded then
	local result = loaded()
	local file = fs.open(answerPath, "w")
	file.write(tostring(result))
	file.close()

	term.setTextColor(colors.yellow)
	write("\nResult: ")
	term.setTextColor(colors.white)
	print(result)
else
	printError(err)
end
