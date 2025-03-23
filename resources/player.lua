Entity = require 'resources/entity'

Player = Entity:extend()
-- Player = Object:extend()

-- function Player:constructor(x, y)
--     self.x = x
--     self.y = y
--     self.health = 100
--     self.maxHealth = 100
--     self.attack = 10
--     self.defense = 10
-- end

function Player:new(x, y)
    self.spriteSheetPath = "assets/spritesheets/funny-pixelated-character/preview.jpg"
    self.spriteSheet = love.graphics.newImage(self.spriteSheetPath)
    self.animations = {
        -- frame info for each animation
        idle = {
            {1, 0, 0},
            {2, 128, 0},
            {3, 0, 64},
            {4, 128, 64},
        }
        -- walk
        -- attack
    }
    self.currentAnimation = self.animations.idle

    Player.super.new(self, x, y, 32, 32, self.currentAnimation)
    self.speed = 100
    self.state = 'idle'

end

function Player:move(moveX, moveY, dt)
    -- local moveAmount = self.speed * dt
    -- local newX = self.x + moveX * moveAmount
    -- local newY = self.y + moveY * moveAmount

    -- -- Collision detection
    -- -- if not G.Map:collides(newX, newY) then
    -- --     self.x = newX
    -- --     self.y = newY
    -- -- end
    -- -- if Map:isWalkable(newX, self.Y) then self.x = newX end
    -- -- if Map:isWalkable(self.x, newY) then self.y = newY end

    -- self.x = newX
    -- self.y = newY
end

function Player:attack(target)
    -- Perform attack logic here
    print("Attacking " .. target.name)
end

function Player:interact()
    -- Perform interaction logic here
    print("Interacting with something")
    
end

function Player:update(dt)
    self.animation:update(dt)
end

function Player:draw()
    self.animation:draw(self.x, self.y)
end

return Player