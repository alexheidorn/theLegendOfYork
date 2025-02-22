function love.load()
    LoadMap("assets/map.txt")

    -- lab tilset
    local labQuadInfo = {
        {' ', 0, 0},
        {'*', 0, 32},
        {'<', 32, 32},
        {'^', 64, 32}
    }
    CreateMap(32, 32, "assets/tilesets/lab.png", quadInfo, "assets/maps/map.txt")
end

function love.update(dt)
    
end

function love.draw()
    drawMap()
    love.graphics.print("Hello worlf!")
end

function love.quit()
    return false
end