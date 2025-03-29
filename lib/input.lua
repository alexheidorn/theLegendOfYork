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
        pause = {"key:escape"},
        confirm = {"key:return", "key:z", "button:a"},
        cancel = {"key:escape", "key:x", "button:b"},
        attack = {"key:space", "key:x", "button:y"},
        inventory = {"key:e", "button:x"},
        map = {"key:m", "button:start"},
        deadzone = 0.3,
    }
end

function Input:pressed(action, joystick)
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


