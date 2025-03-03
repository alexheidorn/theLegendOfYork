Entity = require 'entity'

Player = Entity:extend()

function Player:constructor(x, y)
    self.x = x
    self.y = y
    self.health = 100
    self.maxHealth = 100
    self.attack = 10
    self.defense = 10
end

function Player:new(x, y)
    Player.super.new(self, x, y)
end

function Player:update(dt)
end

function Player:draw()

end