local vector = require("vector")
local Object = require("classic")

local player = nil
local actors = nil
local ps = nil

local Player = Object:extend()
function Player:new(x,y)
    Player.super.new(self)
    self.x = x
    self.y = y
    self.velx = 0
    self.vely = 0
    self.rotation = 0
    self.angle_radians = math.rad(self.rotation)
    self.rotate_speed = 100
    self.thrust = 100
    self.img = love.graphics.newImage("imgs/DarkOliveGreen.png")
end
function Player:update(dt)
    
    self.x = self.x + self.velx*dt
    self.y = self.y + self.vely*dt

    if self.x<0 then
        self.x = 800
    end
    if self.x>800 then
        self.x = 0
    end
    if self.y<0 then
        self.y=600
    end
    if self.y>600 then
        self.y = 0
    end
    if love.keyboard.isDown("left") then
        self.rotation = self.rotation - self.rotate_speed*dt
        self.angle_radians = math.rad(self.rotation)
    end
    if love.keyboard.isDown("right") then
        self.rotation = self.rotation + self.rotate_speed * dt
        self.angle_radians = math.rad(self.rotation)
    end
    if love.keyboard.isDown("up") then
        self.angle_radians = math.rad(self.rotation)
        local forcex = math.cos(self.angle_radians)*self.thrust*dt
        local forcey = math.sin(self.angle_radians)*self.thrust*dt
        self.velx = self.velx + forcex
        self.vely = self.vely + forcey
        ps:emit(32)
    end
    if love.keyboard.isDown("down") then
        self.angle_radians = math.rad(self.rotation)
        local forcex = math.cos(self.angle_radians)*self.thrust*dt
        local forcey = math.sin(self.angle_radians)*self.thrust*dt
        self.velx = self.velx - forcex
        self.vely = self.vely - forcey
    end

    ps:update(dt)
end
function Player:draw()
    love.graphics.draw(self.img,self.x,self.y,self.angle_radians,1,1,16,16)
    
    -- TODO:
    -- figure out where your butt is
    -- will depend on rotation
    love.graphics.draw(ps,self.x,self.y,self.angle_radians)
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

function load_particles()
    local ab = love.graphics.newImage("imgs/AliceBlue2x2.png")
    ps = love.graphics.newParticleSystem(ab,32)
    ps:setParticleLifetime(1,5)
    ps:setLinearAcceleration(-20,-20,20,20)
    -- ps:setEmissionRate(32)
end

function load_players()
    player = Player(100,100)
    actors = List()
    actors:add(player)
end

function love.load()
    load_particles()
    load_players()
end


function love.update(dt)
    for i=1,actors.pos-1 do
        local a = actors:get(i)
        a:update(dt)
    end

    ps:update(dt)

end

function love.draw()
    for i=1,actors.pos-1 do
        local a = actors:get(i)
        a:draw()
    end
end