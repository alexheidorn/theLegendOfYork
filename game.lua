-- Class
Game = Object:extend()

function Game:new()
    G = self

    self:setGlobals()
end

function Game:load()
    -- initialize game componenets
    self.CAM = Camera(0, 0, G.scale)
    self:loadCam()
    local testMap = Map("lab")
    self.MAP = testMap

    self.TITLE_SCREEN = TitleScreen()
    self.FILE_SELECT_MENU = FileSelectMenu()
    self.PAUSE = Pause()
    self.INPUT = Input() -- instance of Input class
    self.DATA = Data()

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
    if G.GAME_STATE == G.GAME_STATES.file_select then
        G.FILE_SELECT_MENU:update(dt)
        return
    end
    
    for _, entity in ipairs(self.ENTITIES) do
        entity:update(dt)
    end
    
    self.updateCam(dt)    
    self.INPUT:update(dt)
end


function Game:draw()
    -- If file select is open, only draw file select menu
    if G.GAME_STATE == G.GAME_STATES.file_select and G.FILE_SELECT_MENU then
        G.FILE_SELECT_MENU:draw()
        return
    end

    -- Draw title screen if in title state
    if G.GAME_STATE == G.GAME_STATES.title_screen then
        G.TITLE_SCREEN:draw()
        return
    end

    -- Draw overworld/gameplay
    self.CAM:attach()
        self.MAP:draw()
        self.PLAYER:draw()
        for _, enemy in ipairs(self.ENEMIES) do
            enemy:draw()
        end
    self.CAM:detach()
    -- HUD
    love.graphics.print("Hello worlf!")
    G.PAUSE:draw()
end

