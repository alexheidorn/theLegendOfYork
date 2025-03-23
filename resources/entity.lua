Object = require 'lib/classic'
Entity = Object:extend()

function Entity:new(x, y, spriteSheet, frameWidth, frameHeight, frameDuration, frameCount)
    self.x = x
    self.y = y
    self.speed = 60 -- Default speed in pixels per second

    -- animation instance
    self.spriteSheet = love.graphics.newImage(spriteSheet)
    self.animation = Animation(self.spriteSheet, frameWidth, frameHeight, frameDuration, frameCount)
end

function Entity:update(dt)
    self.animation:update(dt)
end

function Entity:move(moveX, moveY, dt)
    local moveAmount = self.speed * dt
    local newX = self.x + moveX * moveAmount
    local newY = self.y + moveY * moveAmount
    self.x = newX
    self.y = newY
end

function Entity:draw() 
    self.animation:draw(self.x, self.y)
end