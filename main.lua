-- main.lua
Object = require 'lib/classic'
Camera = require 'lib/camera' 

require 'game'
require 'globals'
require 'assets/sprites'
require 'lib/input'
require 'lib/animation'
require 'resources/map'
require 'resources/entity'
require 'resources/player'
require 'resources/enemy'

function love.load()
    Game:load()
end

function love.update(dt) 
    Game:update(dt)
end

function love.draw()
    Game:draw()
end

function love.quit()
    return false
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end