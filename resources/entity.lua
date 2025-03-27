Object = require 'lib/classic'
Entity = Object:extend()

function Entity:new(x, y, name)
    self.entity = G.animation_atli[name]
    self.spriteSheet = love.graphics.newImage(self.entity.path)
    self.animations = self.entity.animations
    self.x = x or 0
    self.y = y or 0
    self.width = self.entity.pixelWidth or 32
    self.height = self.entity.pixelHeight or 32
    self.speed = 60 -- Default speed in pixels per second

    self.state = 'idle'
    
    self.showHitbox = false
    self.hitbox = {x = 0, y = 0, width = self.width, height = self.height}
    -- animation instance
        -- codeium auto complete options from Balatro form
            -- self.sprite = Sprite(0, 0, 32, 32, G.ASSET_ATLAS['player'], {x = 0, y = 0})
            -- self.spriteSheet = love.graphics.newImage(G.ASSET_ATLAS['player'])
            -- self.spriteSheet = G.ASSET_ATLAS['player']
    self.animation = Animation(self.spriteSheet, self.width, self.height, self.animations[self.state])
end

function Entity:setState(newState)
    if self.state ~= newState and self.animations[newState] then
        self.state = newState
        self.animation:setFrames(self.animations[self.state]) -- update the animation frames
    end
end

function Entity:update(dt)
    self.animation:update(dt)
end

function Entity:move(moveX, moveY, dt)
    local moveAmount = self.speed * dt

    -- Check X movement
    local newX = self.x + moveX * moveAmount
    if not G.MAP:collides(newX, self.y, self.width, self.height) then
        self.hitbox.x = newX
        self.x = self.hitbox.x
    end

    -- Check Y movement
    local newY = self.y + moveY * moveAmount
    if not G.MAP:collides(self.x, newY, self.width, self.height) then
        self.hitbox.y = newY
        self.y = self.hitbox.y
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
        8, 8 -- Rounded corners with radius 8
    ) 
    love.graphics.setColor(255, 255, 255, 255) -- Reset color
end

return Entity