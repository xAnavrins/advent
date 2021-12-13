local year, day, part = ...

local isInit = year == "init"
local isAll = year == "all"
if isInit or isAll then
	year, day, part = day, part or "", ""
end

local setupPath = "/setup"

local ccp = require("cc.pretty")
_ENV.pretty = function(a) ccp.print(ccp.pretty(a)) end
_ENV.pause = function() os.pullEvent("key") end
_ENV.yield = function() os.pullEvent("yield", os.queueEvent("yield")) end
_ENV.timer = function()
	local e = os.epoch("utc")
	return function() return os.epoch("utc") - e end
end
_ENV.split = function (s, p)
	local t = {}
	s:gsub("([^" .. p .. "]+)", function(v) t[#t + 1] = v end)
	return t
end

local function run(cpath, ipath)
	_ENV.input = io.lines(ipath)
	local loaded, err = loadfile(cpath, nil, _ENV)
	local t, result = timer()
	if loaded then
		result = loaded()
	else
		printError(err)
	end
	return result, t()
end

local function getPaths(year, day, part)
	local paths = {}
	paths.day = fs.combine(tostring(year), "day" .. tostring(day))
	paths.input = fs.combine(paths.day, "input.txt")
	paths.part = part and fs.combine(paths.day, "part" .. tostring(part))
	paths.code = part and fs.combine(paths.part, "code.lua")
	paths.answer = part and fs.combine(paths.part, "answer.txt")
	return paths
end
_G.paths = getPaths
if isInit then
	local paths = getPaths(year, day)
	local exists = fs.exists(paths.day)
	if not exists then
		fs.copy(setupPath, paths.day)
	end
	print("Folder for AOC", year, "day", day, exists and "already exists" or "created")

elseif isAll then
	local sum = 0
	for day = 1, 25 do
		local paths = getPaths(year, day)
		if fs.exists(paths.day) then
			term.setTextColor(colors.orange) print("Day " .. day)
			for part = 1, 2 do
				local paths = getPaths(year, day, part)
				if fs.exists(paths.part) then
					term.setTextColor(colors.orange) print("  Part " .. part)
					local result, time = run(paths.code, paths.input)
					sum = sum + time
					term.setTextColor(colors.yellow) write("    Result: ")
					term.setTextColor(colors.white) write(result)
					term.setTextColor(colors.yellow) write(" Time: ")
					term.setTextColor(colors.white) print(tostring(time/1000) .. "s")
				end
			end
			_ENV.pause()
			print()
		end
	end
	term.setTextColor(colors.yellow) write("Sum: ")
	term.setTextColor(colors.white) print(tostring(sum/1000) .. "s")

else
	local paths = getPaths(year, day, part)
	local result, time = run(paths.code, paths.input)
	term.setTextColor(colors.yellow)
	write("\nResult: ")
	term.setTextColor(colors.white)
	print(result)
	term.setTextColor(colors.yellow)
	write("Time  : ")
	term.setTextColor(colors.white)
	print(tostring(time/1000) .. "s")

	local file = fs.open(paths.answer, "w")
	file.write(tostring(result))
	file.close()
end
