Object = require 'lib/classic'
Entity = Object:extend()

function Entity:new(x, y, spriteSheetPath, width, height, animations)
    self.hitbox = {
        x = x or 0,
        y = y or 0,
        width = width or 16,
        height = height or 16,
        show = true
    }

    self.speed = 60 -- Default speed in pixels per second
    self.animations = animations
    self.state = 'idle'
    
    self.sprite = {}
    self.sprite.width = animations[self.state]['pixelWidth'] or 16
    self.sprite.height = animations[self.state]['pixelHeight'] or 16
    self.sprite.offsetTop = (self.sprite.height - self.hitbox.x) or 0
    self.sprite.offsetLeft = (self.sprite.width - self.hitbox.y) or 0
    -- self.sprite.offsetWidth = (self.sprite.width / 2 - self.hitbox.width / 2) or 0
    -- self.sprite.offsetHeight = (self.sprite.height / 2 - self.hitbox.height / 2) or 0
    

    -- animation instance
        -- codeium auto complete options from Balatro form
            -- self.sprite = Sprite(0, 0, 32, 32, G.ASSET_ATLAS['player'], {x = 0, y = 0})
            -- self.spriteSheet = love.graphics.newImage(G.ASSET_ATLAS['player'])
            -- self.spriteSheet = G.ASSET_ATLAS['player']
    self.spriteSheet = love.graphics.newImage(spriteSheetPath)
    self.animation = Animation(self.spriteSheet, self.sprite.width, self.sprite.height, self.animations[self.state])
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
    local newX = self.hitbox.x + moveX * moveAmount
    if not G.map:collides(newX, self.hitbox.y, self.hitbox.width, self.hitbox.height) then
        self.hitbox.x = newX
    end

    -- Check Y movement
    local newY = self.hitbox.y + moveY * moveAmount
    if not G.map:collides(self.hitbox.x, newY, self.hitbox.width, self.hitbox.height) then
        self.hitbox.y = newY
    end
end

function Entity:draw()
    -- draw the entity's collision box
    if self.hitbox.show then
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

    -- draw the entity's sprite on top
    self.animation:draw(self.hitbox.x, self.hitbox.y) 

    end

return Entity