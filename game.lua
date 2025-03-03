function Game()
end

function Game.load()
    Joysticks = love.joystick.getJoysticks()
    if #Joysticks > 0 then
        Joystick = Joysticks[1]
    end
end

function love.gamepadpressed(joystick, button)
    print("Gamepad button " .. button .. " was pressed on " .. joystick:getGamepadName(
        joystick
    ))
end

function love.gamepadreleased(joystick, button)
    print("Gamepad button released:", button)
end

function love.gamepadaxis(joystick, axis, value)
    if math.abs(value) > 0.2 then -- Deadzone to ignore small movements
        print("Gamepad axis " .. axis .. " moved to " .. value)
    end
end

function Game:update(dt)
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