Object = require 'lib/classic'
Entity = Object:extend()

function Entity:new(x, y, spriteSheetPath, width, height, frameCount, frameDuration)
    self.x = x or 0
    self.y = y or 0
    self.width = width or 32
    self.height = height or 32
    self.speed = 60 -- Default speed in pixels per second

    -- animation instance
        -- codeium auto complete options from Balatro form
            -- self.sprite = Sprite(0, 0, 32, 32, G.ASSET_ATLAS['player'], {x = 0, y = 0})
            -- self.spriteSheet = love.graphics.newImage(G.ASSET_ATLAS['player'])
            -- self.spriteSheet = G.ASSET_ATLAS['player']
    self.spriteSheet = love.graphics.newImage(spriteSheetPath)
    self.animation = Animation(self.spriteSheet, self.width, self.height, frameCount, frameDuration)
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

return Entity