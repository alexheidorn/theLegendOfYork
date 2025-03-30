-- Class
Game = Object:extend()

function Game:new()
    G = self

    self:setGlobals()
end

function Game:load()
    -- The game's graphics scale up, this method finds the right ratio
    self.CAM = Camera()
    self:setScale()
    -- initialize game componenets
    
    local testMap = Map("lab")
    self.MAP = testMap

    self.PLAYER = Player(64, 64) --starting positon
    self.PAUSE = Pause()
    self.TITLE_SCREEN = TitleScreen()
    self.INPUT = Input() -- instance of Input class
    self.ENEMIES = { Enemy(200, 100, "log"), Enemy(300, 200, "log") }

    -- controller detection
    self.joystick = nil
    local joysticks = love.joystick.getJoysticks()
    if #joysticks > 0 then
        print("Found " .. #joysticks .. " joystick(s)")
        self.joystick = joysticks[1]
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
    self.PLAYER:update(dt)
    
    for _, enemy in ipairs(self.ENEMIES) do
        enemy:update(dt)
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

