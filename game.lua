-- Class
Game = Object:extend()

function Game:load()
    -- initialize game componenets
    cam = Camera()

    --Map creation logic
    -- lab tileset
    local labQuadInfo = {
        {' ', 0, 0},
        {'*', 0, 32},
        {'<', 32, 32},
        {'^', 64, 32},
        {'~', 128, 0},
    }
    local mapTxtFile = love.filesystem.read('assets/maps/map.txt')
    self.map = Map(32, 32, 'assets/tilesets/Untitled.png', labQuadInfo, mapTxtFile)
    self.player = Player(64, 64) --starting positon
    self.input = Input() -- instance of Input class
    self.enemies = { Enemy(200, 100), Enemy(300, 150)}

    -- controller detection
    self.joystick = nil
    local joysticks = love.joystick.getJoysticks()
    if #joysticks > 0 then
        print("Found " .. #joysticks .. " joystick(s)")
        self.joystick = joysticks[1]
    end
end


function Game:update(dt)
    self.input:handleInput(self.player, dt, self.joystick)
    self.player:update(dt)

    for _, enemy in ipairs(self.enemies) do
        enemy:update(dt)
    end
    
    cam:lookAt(self.player.x, self.player.y)
end

function Game:draw()
    cam:attach()
        self.map:draw()
        self.player:draw()

        for _, enemy in ipairs(self.enemies) do
            enemy:draw()
        end
    cam:detach()
end

function Game:keypressed(key)
    self.input:handleKeyboard(key, self.player)
    if key == "escape" then
        love.event.quit()
    end
end

function Game:gamepadpressed(joystick, button)
    print("Gamepad button " .. button .. " was pressed on " .. joystick:getGamepadName(
        joystick
    ))
    self.input:handleGamepad(button, self.player, joystick)
end

function love.gamepadreleased(joystick, button)
    print("Gamepad button released:", button)
end

function love.gamepadaxis(joystick, axis, value)
    if math.abs(value) > 0.2 then -- Deadzone to ignore small movements
        print("Gamepad axis " .. axis .. " moved to " .. value)
    end
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