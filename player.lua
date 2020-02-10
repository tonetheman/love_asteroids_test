
local Object = require("classic")

local Player = Object:extend()
function Player:new(x,y)
    Player.super.new(self)
    self.x = x
    self.y = y
    self.velx = 0
    self.vely = 0
    self.rotation = 0
    self.angle_radians = math.rad(self.rotation)
    self.rotate_speed = 170
    self.thrust = 100
    self.img = love.graphics.newImage("imgs/DarkOliveGreen.png")

    local ab = love.graphics.newImage("imgs/AliceBlue2x2.png")
    self.ps = love.graphics.newParticleSystem(ab,32)
    self.ps:setParticleLifetime(1,5)
    self.ps:setLinearAcceleration(-20,-20,20,20)

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
        self.ps:emit(32)
    end
    if love.keyboard.isDown("down") then
        self.angle_radians = math.rad(self.rotation)
        local forcex = math.cos(self.angle_radians)*self.thrust*dt
        local forcey = math.sin(self.angle_radians)*self.thrust*dt
        self.velx = self.velx - forcex
        self.vely = self.vely - forcey
    end

    self.ps:update(dt)
end
function Player:draw()
    love.graphics.draw(self.img,self.x,self.y,self.angle_radians,1,1,16,16)
    
    -- TODO:
    -- figure out where your butt is
    -- will depend on rotation
    love.graphics.draw(self.ps,self.x,self.y,self.angle_radians)
end

return Player