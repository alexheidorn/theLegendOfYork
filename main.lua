require 'lib/map-functions'

function love.load()
    -- lab tileset
    local labQuadInfo = {
        {' ', 0, 0},
        {'*', 0, 32},
        {'<', 32, 32},
        {'^', 64, 32},
        {'~', 128, 0},
    }
    local mapTxtFile = love.filesystem.read('assets/maps/map.txt')
    CreateMap(32, 32, 'assets/tilesets/Untitled.png', labQuadInfo, mapTxtFile)
    -- LoadMap('assets/maps/map.lua')
end

function love.update(dt)
    
end

function love.draw()
    DrawMap()
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