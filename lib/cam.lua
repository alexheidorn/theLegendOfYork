Camera = require 'lib/camera'

function Game:loadCam()
    -- 3 parameters: fullscreen, width, height
    -- width and height are ignored if fullscreen is true
    self.CAM.smoother = Camera.smooth.damped(8)
    G.fullscreen = true
    G.testWindow = false
    Game.vertical = false
    G:setWindowSize(G.fullscreen, 1920, 1080)

    if G.vertical then
        G.fullscreen = false
        G.testWindow = true
        G:setWindowSize(G.fullscreen, 1360, 1920)
    end
    -- The game's graphics scale up, this method finds the right ratio
    G:setScale()
end

function Game:updateCam(dt)
    -- camera logic
    G.CAM.x, G.CAM.y = G.PLAYER.hitbox.x, G.PLAYER.hitbox.y
    local screenWidth = love.graphics.getWidth() / G.scale
    local screenHeight = love.graphics.getHeight() / G.scale
    local mapWidth = G.MAP.width * G.MAP.tileSize
    local mapHeight = G.MAP.height * G.MAP.tileSize

    local playerCenterX = G.PLAYER.hitbox.x + G.PLAYER.hitbox.width / 2
    local playerCenterY = G.PLAYER.hitbox.y + G.PLAYER.hitbox.height / 2
    G.CAM:lookAt(playerCenterX, playerCenterY)
    
    
    -- Camera boundaries
    -- Left Boundary
    if G.CAM.x < screenWidth / 2 then
        G.CAM.x = screenWidth / 2
    end
    -- Top Boundary
    if G.CAM.y < screenHeight / 2 then
        G.CAM.y = screenHeight / 2
    end
    -- Right Boundary
    if G.CAM.x > mapWidth - screenWidth / 2 then
        G.CAM.x = mapWidth - screenWidth / 2
    end
    -- Bottom Boundary
    if G.CAM.y > mapHeight - screenHeight / 2 then
        G.CAM.y = mapHeight - screenHeight / 2
    end

    G.CAM:lockPosition(G.CAM.x, G.CAM.y)
    G.CAM.x, G.CAM.y = G.CAM:position()
end

function Game:setWindowSize(full, width, height)
    if full then
        G.CAM.fullscreen = true
        love.window.setFullscreen(true)
        windowWidth = love.graphics.getWidth()
        windowHeight = love.graphics.getHeight()
    else
        G.CAM.fullscreen = false
        if width == nil or height == nil then
            windowWidth = 1920
            windowHeight = 1080
        else
            windowWidth = width
            windowHeight = height
        end
        love.window.setMode( windowWidth, windowHeight, {resizable = not testWindow} )
    end
end

function Game:setScale(input)
    local windowHeight = love.graphics.getHeight()
    G.scale = (7.3 / 1200) * windowHeight

    if G.CAM.vertical then
        G.scale = (7 / 1200) * windowHeight
    end

    if G.CAM then
        G.CAM:zoomTo(G.scale)
    end
end

function Game:checkWindowSize()
    local width = love.graphics.getWidth()
    local height = love.graphics.getHeight()
    if width ~= windowWidth or height ~= windowHeight then
        self:reinitSize()
    end
end

function Game:reinitSize()
    -- Reinitialize everything
    windowWidth = love.graphics.getWidth()
    windowHeight = love.graphics.getHeight()
    G:setScale()
    -- pause:init()
    -- initFonts()
end