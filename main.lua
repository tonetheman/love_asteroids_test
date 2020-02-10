
local Object = require("classic")
local Player = require("player")
local List = require("list")

local player = nil
local actors = nil

function load_players()
    player = Player(100,100)
    actors = List()
    actors:add(player)
end

function love.load()
    load_players()
end

function love.update(dt)
    for i=1,actors.pos-1 do
        local a = actors:get(i)
        a:update(dt)
    end
end

function love.draw()
    for i=1,actors.pos-1 do
        local a = actors:get(i)
        a:draw()
    end
end