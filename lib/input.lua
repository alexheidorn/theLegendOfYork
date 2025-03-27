-- Class
Input = Object:extend()

function Input:new()
    self.keybinds = {
        left = {{key = "a"}, {key = "left"}, {button = "dpleft"}, {axis = "leftx-",}},
        right = {{key = "d"}, {key = "right"}, {button = "dpright"}, {axis = "leftx+",}},
        up = {{key = "w"}, {key = "up"}, {button = "dpup"}, {axis = "lefty-",}},
        down = {{key = "s"}, {key = "down"}, {button = "dpdown"}, {axis = "lefty+",}},
        
        start = {{key = "return"}, {button = "button_start"}},
        select = {{key = "space"}, {button = "button_select"}},
        pause = {{key = "escape"}},
        confirm = {{key = "return"}, {key = "z"}, {button = "button_a"}},
        cancel = {{key = "escape"}, {key = "x"}, {button = "button_b"}},
        attack = {{key = "space"}, {key = "x"}, {button = "button_y"}},
        inventory = {{key = "e"}, {button = "button_x"}},
        map = {{key = "m"}, {button = "button_start"}},
    }
end

function Input:handleInput(dt, joystick)
    local moveX, moveY = 0, 0

    local function _pressed(action)
        for _, input in ipairs(self.keybinds[action] or {}) do
            -- check keyboard input
            if input.key and love.keyboard.isDown(input.key) then
                return true
            end

            -- check controller button input
            if input.button and joystick and joystick:isGamepadDown(input.button) then
                return true
            end

            -- check gamepad axis input
            if input.axis == "leftx-" and joystick and joystick:getGamepadAxis("leftx") < -0.2 then
                return true
            end
            if input.axis == "leftx+" and joystick and joystick:getGamepadAxis("leftx") > 0.2 then
                return true
            end
            if input.axis == "lefty-" and joystick and joystick:getGamepadAxis("lefty") < -0.2 then
                return true
            end
            if input.axis == "lefty+" and joystick and joystick:getGamepadAxis("lefty") > 0.2 then
                return true
            end
        end
        return false
    end

    -- check for movement input
    if _pressed("left") then moveX = moveX - 1 end
    if _pressed("right") then moveX = moveX + 1 end
    if _pressed("up") then moveY = moveY - 1 end
    if _pressed("down") then moveY = moveY + 1 end
    

    -- normalize diagonal movement
    if moveX ~= 0 and moveY ~= 0 then
        local length = math.sqrt(moveX * moveX + moveY * moveY)
        moveX, moveY = moveX / length, moveY / length
    end

    -- apply movement
    G.PLAYER:move(moveX, moveY, dt)
end