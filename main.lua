function love.load()
    -- LoadMap('/assets/maps/map.txt')

    -- CreateMap(32, 32, '/assets/tilesets/lab.png', labQuadInfo, 'assets/maps/map.txt')
    LoadMap('/assets/maps/map.lua')
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