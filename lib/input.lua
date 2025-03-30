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
        deadzone = 0.3,
    }
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

function Input:gamepadpressed(joystick, button)
    self.pressedInputs[button] = true
    self.heldInputs[button] = true
end

function Input:gamepadreleased(joystick, button) 
    self.releasedInputs[button] = true 
    self.heldInputs[button] = nil
end


function Input:inputPressed(action)
    if self.keybinds[action] then
        for _, input in ipairs(self.keybinds[action]) do
            if self.pressedInputs[input] then
                return true
            end
        end
    end
    return false
end


function Input:handleInput(action, joystick)
    for _, input in ipairs(self.keybinds[action] or {}) do
        local inputType, inputValue = input:match("([^:]+):([^:]+)")

        if inputType == "key" and love.keyboard.isDown(inputValue) then
            return true
        end

        if inputType == "button" and joystick and joystick:isGamepadDown(inputValue) then
            return true
        end

        if inputType == "axis" and joystick then
            local axis, direction = inputValue:match("([^+-]+)([+-])")
            local axisValue = joystick:getGamepadAxis(axis)
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
    if self:handleInput("pause") then
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

function love.gamepadaxis(joystick, axis, value)
    if math.abs(value) > 0.2 then -- Deadzone to ignore small movements
        print("Gamepad axis " .. axis .. " moved to " .. value)
    end
end
