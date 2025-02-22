function love.load()
    LoadMap("assets/map.txt")
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