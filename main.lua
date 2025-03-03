Object = require 'lib/object' 
require 'lib/map-functions'
require 'lib/sprite-functions'
require 'game'
require 'lib.input'

local map, chopper
function love.load()
    -- LoadMap('assets/maps/map.lua')
    map = LoadMap('assets/maps/map.lua')
    chopper = LoadSprite('assets/sprites/chopper.lua')

    Game:load()
end

function love.update(dt)
    updateSprite(dt)    
    Game:update(dt)
end

function love.draw()
    DrawMap()
    drawSprite()
    love.graphics.print("Hello worlf!")
end

function love.quit()
    return false
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    end
end