local players = {}
local boardSize = 10
for line in input do
    line:gsub("Player (%d+) starting position: (%d+)", function(pl, pos)
        players[tonumber(pl)] = {
            pos = tonumber(pos),
            score = 0
        }
    end)
end

local function makeDie(faces)
    local c = 1
    local f = faces
    return function(t)
        local r = 0
        for i = 1, t do
            r = r + c
            c = c + 1
            if c > 10 then c = 1 end
        end
        return r, c
    end
end

local function movePlayer(player, spaces)
    player.pos = player.pos + spaces
    while player.pos > boardSize do
        player.pos = player.pos - boardSize
    end
    player.score = player.score + player.pos
end

local die = makeDie(100)
local rolls = 0
local p1turn = true
local loser
while true do
    local roll = die(3); rolls = rolls + 3
    local turnPlayer = p1turn and players[1] or players[2]
    movePlayer(turnPlayer, roll)
    if turnPlayer.score >= 1000 then
        loser = p1turn and players[2] or players[1]
        break
    end
    p1turn = not p1turn
end

return loser.score * rolls
