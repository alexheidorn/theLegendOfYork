require 'lib/map-functions'

function love.load()
    -- LoadMap('/assets/maps/map.txt')

    -- lab tilset
    local labQuadInfo = {
        {' ', 0, 0},
        {'*', 0, 32},
        {'<', 32, 32},
        {'^', 64, 32}
    }
    CreateMap(32, 32, 'assets/tilesets/lab.png', labQuadInfo, 'assets/maps/map.txt')
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