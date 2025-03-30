-- Class
Game = Object:extend()

function Game:new()
    G = self

    self:setGlobals()
end

function Game:load()
    -- The game's graphics scale up, this method finds the right ratio
    setScale()
    -- initialize game componenets

    local testMap = Map("lab")
    self.MAP = testMap

    self.PLAYER = Player(64, 64) --starting positon
    self.PAUSE = Pause()
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

function Game:update(dt)
    self.INPUT:update(dt)

    if G.GAME_STATE == G.GAME_STATES.title_screen then
        -- Main menu logic here
        -- For example, you can check for key presses to navigate the menu
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
    Cam:lookAt(playerCenterX, playerCenterY)
    
    
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
end

function setScale(input)
    local windowHeight = love.graphics.getHeight()
    scale = (7.3 / 1200) * windowHeight

    if vertical then
        scale = (7 / 1200) * windowHeight
    end

    if Cam then
        Cam:zoomTo(scale)
    end
end

function Game:draw()
    --camera view
    Cam:attach()
        self.MAP:draw()
        self.PLAYER:draw()

        for _, enemy in ipairs(self.ENEMIES) do
            enemy:draw()
        end
    Cam:detach()
    --HUD
    love.graphics.print("Hello worlf!")
    G.PAUSE:draw()
end

function TitleScreen()
    -- intro text after selecting 'start'
    love.graphics.print([[
                     Welcome to 
    ~*~*~*~*~*~*~*The Legend of York™*~*~*~*~*~*~*~
    You take on the role of John Hero, the CEO
    of the heroes' guild York Industries. Your 
    Your quest is to become the greatest hero of 
    all time. You have been hired to enter a secret
    lab to find the legendary battle axe of York 
    and take out the vile troll Gretchen!
    ~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~
    ]]
    )
end

function TitleScreenOptions()
    love.graphics.print("1) Start Game", 100, 100)
    love.graphics.print("2) View Map", 100, 200)
    love.graphics.print("3) View Commands", 100, 300)
    love.graphics.print("4) Exit :(", 100, 400)

end