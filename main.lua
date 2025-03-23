-- main.lua
Object = require 'lib/classic' 
require 'lib/map-functions'

require 'game'
require 'lib.input'
require 'lib.animation'
require 'resources.entity'
require 'resources.player'
require 'resources.enemy'
-- require 'lib.map'



local map
function love.load()
    -- LoadMap('assets/maps/map.lua')
    map = LoadMap('assets/maps/map.lua')

    Game:load()
end

function love.update(dt) 
    Game:update(dt)
end

function love.draw()
    DrawMap()
    Game:draw()
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