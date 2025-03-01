require 'lib/map-functions'
require 'lib/sprite-functions'

function love.load()
    -- LoadMap('assets/maps/map.lua')
    LoadMap('assets/maps/map.lua')
    chopper = require 'assets.sprites.chopper'
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