Entity = require 'entity'

Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y)
end