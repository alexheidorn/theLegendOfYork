-- Class
Input = Object:extend()

function Input:new()
    self.keybinds = {
        left = {"key:a", "key:left", "button:dpleft", "axis:leftx-"},
        right = {"key:d", "key:right", "button:dpright", "axis:leftx+"},
        up = {"key:w", "key:up", "button:dpup", "axis:lefty-"},
        down = {"key:s", "key:down", "button:dpdown", "axis:lefty+"},

        start = {"key:return", "button:start"},
        select = {"key:space", "button:select"},
        pause = {"key:escape", "key:p", "button:start"},
        confirm = {"key:return", "key:z", "button:a"},
        cancel = {"key:escape", "key:x", "button:b"},
        attack = {"key:space", "key:x", "button:y"},
        inventory = {"key:e", "button:x"},
        map = {"key:m", "button:start"},
    }
    self.keybinds.deadzone = 0.3 -- Deadzone for joystick axis input
    self.pressedInputs = {}
    self.heldInputs = {}
    self.releasedInputs = {}
end

function Input:bind(action, input)
    if not self.keybinds[action] then
        self.keybinds[action] = {}
    end

    table.insert(self.keybinds[action], input)
end

function love.keypressed(key)
    G.INPUT.pressedInputs[key] = true
    G.INPUT.heldInputs[key] = true
end

function love.keyreleased(key)
    G.INPUT.releasedInputs[key] = true
    G.INPUT.heldInputs[key] = nil
end

function love.gamepadpressed(joystick, button)
    G.INPUT.pressedInputs[button] = true
    G.INPUT.heldInputs[button] = true
end

function love.gamepadreleased(joystick, button) 
    G.INPUT.heldInputs[button] = nil
    G.INPUT.releasedInputs[button] = true 
end


function love.gamepadaxis(joystick, axis, value)
    if math.abs(value) > G.INPUT.keybinds.deadzone then
        local direction = value > 0 and "+" or "-"
        local axisKey = axis .. direction

        G.INPUT.pressedInputs[axisKey] = true
        G.INPUT.heldInputs[axisKey] = true
    else
        G.INPUT.releasedInputs[axis .. "+"] = true
        G.INPUT.releasedInputs[axis .. "-"] = true
        G.INPUT.heldInputs[axis .. "+"] = nil
        G.INPUT.heldInputs[axis .. "-"] = nil
    end
end

function Input:inputPressed(action)
    if self.keybinds[action] then
        for _, input in ipairs(self.keybinds[action]) do
            local inputType, inputValue = input:match("([^:]+):([^:]+)")
            -- bug: pressing 'a' on keyboard will trigger 'confirm' action
            if self.pressedInputs[inputValue] then
                return true
            end
        end
    end
    return false
end


function Input:handleInput(action)
    for _, input in ipairs(self.keybinds[action] or {}) do
        local inputType, inputValue = input:match("([^:]+):([^:]+)")

        if inputType == "key" and love.keyboard.isDown(inputValue) then
            return true
        end

        if inputType == "button" and G.joystick and G.joystick:isGamepadDown(inputValue) then
            return true
        end

        if inputType == "axis" and G.joystick then
            local axis, direction = inputValue:match("([^+-]+)([+-])")
            local axisValue = G.joystick:getGamepadAxis(axis)
            if (direction == "+" and axisValue > self.keybinds.deadzone) or (direction == "-" and axisValue < -self.keybinds.deadzone) then
                return true
            end
        end
    end
    return false
end

function Input:update(dt)
    -- Update input state if needed
    -- For example, you can check for key presses or joystick movements here
    -- and update the input state accordingly.
    if self:inputPressed("pause") then
        -- Pause the game or perform any other action
        G.PAUSE:toggle()
    end

    self.pressedInputs = {}
    self.releasedInputs = {}
end

function Game:gamepadpressed(joystick, button)
    print("Gamepad button " .. button .. " was pressed on " .. joystick:getGamepadName(
        joystick
    ))
end

function love.gamepadreleased(joystick, button)
    print("Gamepad button released:", button)
end

-- function love.gamepadaxis(joystick, axis, value)
--     if math.abs(value) > 0.2 then -- Deadzone to ignore small movements
--         print("Gamepad axis " .. axis .. " moved to " .. value)
--     end
-- end
