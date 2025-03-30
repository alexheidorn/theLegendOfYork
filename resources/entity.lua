Object = require 'lib/classic'
Entity = Object:extend()

function Entity:new(x, y, name)
    self.entity = G.animation_atli[name]
    self.spriteSheet = love.graphics.newImage(self.entity.path)
    self.animations = self.entity.animations
    self.hitbox = {
        x = x or 0,
        y = y or 0,
        width = self.entity.hitboxWidth or 32,  -- refactor with new field in atlas
        height = self.entity.hitboxHeight or 32, -- refactor with new field in atlas
        show = true
    }

    self.speed = 60 -- Default speed in pixels per second
    self.stunTimer = 0
    self.stunDuration = 0.5 -- Duration of stun in seconds
    self.state = 'idle'
    
    self.sprite = {}
    self.sprite.width = self.entity.spriteWidth or 32
    self.sprite.height = self.entity.spriteHeight or 32
    self.sprite.offsetTop = (self.sprite.height / 2 - self.hitbox.height / 2) or 0
    self.sprite.offsetLeft = (self.sprite.width / 2 - self.hitbox.width / 2) or 0
    -- self.sprite.offsetWidth = (self.sprite.width / 2 - self.hitbox.width / 2) or 0
    -- self.sprite.offsetHeight = (self.sprite.height / 2 - self.hitbox.height / 2) or 0
    

    -- animation instance
        -- codeium auto complete options from Balatro form
            -- self.sprite = Sprite(0, 0, 32, 32, G.ASSET_ATLAS['player'], {x = 0, y = 0})
            -- self.spriteSheet = love.graphics.newImage(G.ASSET_ATLAS['player'])
            -- self.spriteSheet = G.ASSET_ATLAS['player']

    self.animation = Animation(self.spriteSheet, self.sprite.width, self.sprite.height, self.animations[self.state])
end

function Entity:collides(otherHitbox)
    return self.hitbox.x < otherHitbox.x + otherHitbox.width and
           self.hitbox.x + self.hitbox.width > otherHitbox.x and
           self.hitbox.y < otherHitbox.y + otherHitbox.height and
           self.hitbox.y + self.hitbox.height > otherHitbox.y
end

function Entity:collidesWithEntity()
    -- Check for collision with enemies or other entities
    for _, entity in ipairs(G.ENTITIES) do
        if entity ~= self and entity:collides(self.hitbox) then
            return true
        end
    end
    return false
end

function Entity:setState(newState)
    if self.state ~= newState and self.animations[newState] then
        self.state = newState
        self.animation:setFrames(self.animations[self.state]) -- update the animation frames
    end
end

function Entity:update(dt)
    self.animation:update(dt)

    -- Update the stun timer
    if self.stunTimer > 0 then
        self.stunTimer = self.stunTimer - dt
    end
end

function Entity:move(moveX, moveY, dt)
    if self.stunTimer > 0 then return end -- Prevent movement while stunned

    local moveAmount = self.speed * dt

    -- Check X movement
    local newX = self.hitbox.x + moveX * moveAmount
    if not G.MAP:collides(newX, self.hitbox.y, self.hitbox.width, self.hitbox.height) then
        self.hitbox.x = newX
    end

    -- Check Y movement
    local newY = self.hitbox.y + moveY * moveAmount
    if not G.MAP:collides(self.hitbox.x, newY, self.hitbox.width, self.hitbox.height) then
        self.hitbox.y = newY
    end
end

function Entity:draw()
    -- draw the entity's collision box
    if self.hitbox.show then
        love.graphics.setColor(255, 0, 0, 128) -- Red with 50% transparency
        if self:collidesWithEntity() then
            love.graphics.setColor(0, 255, 0, .5) -- green
        end
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

    -- draw the entity's sprite on top
    self.animation:draw(self.hitbox.x - self.sprite.offsetLeft, self.hitbox.y - self.sprite.offsetTop) 

    end

return Entity