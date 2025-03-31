-- Class
Game = Object:extend()

function Game:new()
    G = self

    self:setGlobals()
end

function Game:load()
    -- The game's graphics scale up, this method finds the right ratio
    self.CAM = Camera()
    -- 3 parameters: fullscreen, width, height
    -- width and height are ignored if fullscreen is true
    self.fullscreen = true
    self.testWindow = false
    self.vertical = false
    self:setWindowSize(self.fullscreen, 1920, 1080)

    if self.vertical then
        self.fullscreen = false
        self.testWindow = true
        self:setWindowSize(self.fullscreen, 1360, 1920)
    end

    self:setScale()
    -- initialize game componenets
    
    local testMap = Map("lab")
    self.MAP = testMap

    self.TITLE_SCREEN = TitleScreen()
    self.PAUSE = Pause()
    self.INPUT = Input() -- instance of Input class

    self.PLAYER = Player(64, 64) --starting positon
    self.ENEMIES = { Enemy(200, 100, "log"), Enemy(300, 200, "log") }
    self.ITEMS = {} -- { Item("health_potion", 1), Item("mana_potion", 2) } -- example items
    self.ENTITIES = {
        self.PLAYER,
    }
    for _, enemy in ipairs(self.ENEMIES) do
        table.insert(self.ENTITIES, enemy)
    end
    for _, item in ipairs(self.ITEMS) do
        table.insert(self.ENTITIES, item)
    end

    -- controller detection
    self.joystick = nil
    local joysticks = love.joystick.getJoysticks()
    if #joysticks > 0 then
        print("Found " .. #joysticks .. " joystick(s)")
        self.joystick = joysticks[1]
    end
end

function Game:setWindowSize(full, width, height)
    if full then
        self.fullscreen = true
        love.window.setFullscreen(true)
        windowWidth = love.graphics.getWidth()
        windowHeight = love.graphics.getHeight()
    else
        self.fullscreen = false
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
    self.scale = (7.3 / 1200) * windowHeight

    if self.vertical then
        self.scale = (7 / 1200) * windowHeight
    end

    if self.CAM then
        self.CAM:zoomTo(self.scale)
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

function Game:update(dt)
    if G.GAME_STATE == G.GAME_STATES.title_screen then
        -- Main menu logic here
        -- For example, you can check for key presses to navigate the menu
        self.TITLE_SCREEN:update(dt)
        return
    end
    if G.GAME_STATE == G.GAME_STATES.paused then 
        G.PAUSE:update(dt) 
        return
    end
    
    for _, entity in ipairs(self.ENTITIES) do
        entity:update(dt)
    end
    
    -- camera logic
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local playerCenterX = self.PLAYER.hitbox.x + self.PLAYER.hitbox.width / 2
    local playerCenterY = self.PLAYER.hitbox.y + self.PLAYER.hitbox.height / 2
    self.CAM:lookAt(playerCenterX, playerCenterY)
    
    
    -- Camera boundaries
    -- Left Boundary
    -- if Cam.x < screenWidth / 2 then
    --     Cam.x = screenWidth / 2
    -- end
    -- -- Top Boundary
    -- if Cam.y < screenHeight / 2 then
    --     Cam.y = screenHeight / 2
    -- end
    -- -- Right Boundary
    -- if Cam.x > self.map.width * self.map.tileSize - screenWidth / 2 then
    --     Cam.x = self.map.width * self.map.tileSize - screenWidth / 2
    -- end
    -- -- Bottom Boundary
    -- if Cam.y > self.map.height * self.map.tileSize - screenHeight / 2 then
    --     Cam.y = self.map.height * self.map.tileSize - screenHeight / 2
    -- end
    
    self.INPUT:update(dt)
end


function Game:draw()
    G.TITLE_SCREEN:draw()
    if G.GAME_STATE == G.GAME_STATES.title_screen then return end
    --camera view
    self.CAM:attach()
        self.MAP:draw()
        self.PLAYER:draw()

        for _, enemy in ipairs(self.ENEMIES) do
            enemy:draw()
        end
    self.CAM:detach()
    --HUD
    love.graphics.print("Hello worlf!")
    G.PAUSE:draw()
end

