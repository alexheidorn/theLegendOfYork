require 'lib/map-functions'
require 'lib/sprite-functions'

local map, chopper
function love.load()
    -- LoadMap('assets/maps/map.lua')
    map = LoadMap('assets/maps/map.lua')
    chopper = LoadSprite('assets/sprites/chopper.lua')
end

function love.update(dt)
    updateSprite(dt)    
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