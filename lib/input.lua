-- Class
Input = Object:extend()

function Input:handleInput(player, dt, joystick)
    local moveX, moveY = 0, 0

    -- gamepad input
    if joystick then
        local joyX = joystick:getGamepadAxis("leftx")
        local joyY = joystick:getGamepadAxis("lefty")

        if math.abs(joyX) > 0.2 then moveX = joyX end
        if math.abs(joyY) > 0.2 then moveY = joyY end
    end

    -- keyboard input
    if love.keyboard.isDown("a") or love.keyboard.isDown("left") then moveX = moveX - 1 end
    if love.keyboard.isDown("d") or love.keyboard.isDown("right") then moveX = moveX + 1 end
    if love.keyboard.isDown("w") or love.keyboard.isDown("up") then moveY = moveY - 1 end
    if love.keyboard.isDown("s") or love.keyboard.isDown("down") then moveY = moveY + 1 end
    

    -- normalize diagonal movement
    if moveX ~= 0 and moveY ~= 0 then
        local length = math.sqrt(moveX * moveX + moveY * moveY)
        moveX, moveY = moveX / length, moveY / length
    end

    -- apply movement
    player:move(moveX, moveY, dt)
end