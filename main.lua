local vector = require("vector")
local Object = require("classic")
local Player = Object:extend()
function Player:new(x,y)
    Player.super.new(self)
    self.x = x
    self.y = y
end
function Player:update(dt)
    local delta = vector(0,0)
end

local List = Object:extend()
function List:new()
    List.super.new(self)
    self.pos = 1
end
function List:add(val)
    self[self.pos] = val
    self.pos = self.pos + 1
end
function List:get(i)
    return self[i]
end
function List:remove(val)
    for i=1,self.pos do
        if self[i] == val then
            -- remove the item
            table.remove(self,i)
        end
    end
end

local player = nil
local actors = nil

function love.load()
    player = Player(100,100)
    actors = List()
    actors:add(player)
end


function love.update(dt)
    for i=1,actors.pos-1 do
        local a = actors:get(i)
        a:update(dt)
    end
end
