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
    Player.super.new(self, x, y, self.spriteSheetPath, 172, 332, 4)
    self.speed = 100
    self.state = 'idle'
    
    self.animations = {
        -- frame info for each animation
        idle = {
            {1, 0, 0},
            {2, 172, 0},
            {3, 344, 0},
            {4, 516, 0},
        }
        -- walk
        -- attack
    }
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
    Player.super.move(self, moveX, moveY, dt)
end

function Player:attack(target)
    -- Perform attack logic here
    print("Attacking " .. target.name)
end

function Player:interact()
    -- Perform interaction logic here
    print("Interacting with something")
    
end

return Player