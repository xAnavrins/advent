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

local function timer()
	local e = os.epoch("utc")
	return function() return os.epoch("utc") - e end
end

local ccp = require("cc.pretty")
_ENV.pretty = function(a) ccp.print(ccp.pretty(a)) end
_ENV.timer = timer
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
	local t = timer()
	local result = loaded()
	term.setTextColor(colors.yellow)
	write("\nResult: ")
	term.setTextColor(colors.white)
	print(result)
	term.setTextColor(colors.yellow)
	write("Time: ")
	term.setTextColor(colors.white)
	print(tostring(t()/1000).."s")

	local file = fs.open(answerPath, "w")
	file.write(tostring(result))
	file.close()
else
	printError(err)
end
