-- Class
Game = Object:extend()

function Game:new()
    G = self

    self:setGlobals()
end

function Game:load()
    -- initialize game componenets
    self.CAM = Camera(0, 0, G.scale)
    G.CAM.smoother = Camera.smooth.damped(8)
    self:loadCam()
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
    
    self.updateCam(dt)    
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

