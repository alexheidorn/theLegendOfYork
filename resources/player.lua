Entity = require 'entity'

Player = Entity:extend()

-- function Player:constructor(x, y)
--     self.x = x
--     self.y = y
--     self.health = 100
--     self.maxHealth = 100
--     self.attack = 10
--     self.defense = 10
-- end

function Player:new(x, y)
    Player.super.new(self, x, y, 32, 32)
    self.speed = 100
    self.state = 'idle'
    -- self.sprite = Sprite(0, 0, 32, 32, G.ASSET_ATLAS['player'], {x = 0, y = 0})
    -- self.spriteSheet = love.graphics.newImage(G.ASSET_ATLAS['player'])
    -- self.spriteSheet = G.ASSET_ATLAS['player']
    self.spriteSheet = love.graphics.newImage("player.png")

end

function Player:move(moveX, moveY, dt)
    local moveAmount = self.speed * dt
    local newX = self.x + moveX * moveAmount
    local newY = self.y + moveY * moveAmount

    -- Collision detection
    -- if not G.Map:collides(newX, newY) then
    --     self.x = newX
    --     self.y = newY
    -- end
    if Map:isWalkable(newX, self.Y) then self.x = newX end
    if Map:isWalkable(self.x, newY) then self.y = newY end
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
end

function Player:draw()

end