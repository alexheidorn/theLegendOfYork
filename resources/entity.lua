Object = require 'lib/classic'
Entity = Object:extend()

function Entity:new(x, y, spriteSheetPath, width, height, frameCount, frameDuration)
    self.x = x or 0
    self.y = y or 0
    self.width = width or 32
    self.height = height or 32
    self.speed = 60 -- Default speed in pixels per second

    self.showHitbox = false
    self.hitbox = {x = 0, y = 0, width = self.width, height = self.height}
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
    -- check for collisions
    if not G.map:collides(newX, newY, self.width, self.height) then
        self.x = newX
        self.y = newY
        -- update hitbox position
        self.hitbox.x = self.x + self.hitbox.offsetX
        self.hitbox.y = self.y + self.hitbox.offsetY
    end
end

function Entity:draw()
    -- draw the entity's sprite with animation
    self.animation:draw(self.x, self.y)

    -- draw the entity's collision box
    love.graphics.setColor(255, 0, 0, 128) -- Red with 50% transparency
    love.graphics.rectangle(
        "line", 
        self.hitbox.x,
        self.hitbox.y,
        self.hitbox.width,
        self.hitbox.height, 
        8, 8) -- Rounded corners with radius 8
    love.graphics.setColor(255, 255, 255, 255) -- Reset color
end

return Entity