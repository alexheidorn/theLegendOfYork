Pause = Object:extend()

--[[
    Pause Menu Class
    This class handles the pause menu functionality in the game.
    It allows the player to pause the game, navigate through options, and resume or quit the game.
--]]

function Pause:new()
    self.paused = false
    -- self.alpha = 0
    self.menuOptions = {
        "Resume",
        "Options",
        "Quit"
    }
    self.selectedOption = 1
end

function Pause:toggle()
    if not self.paused then
        self:open()
    else
        self:close()
    end
end

function Pause:open()
    self.paused = true
    G.GAME_STATE = G.GAME_STATES.paused
end

function Pause:close()
    self.paused = false
    G.GAME_STATE = G.GAME_STATES.gameplay
end

function Pause:selectOption()
    self.selectedOption = self.selectedOption + 1
    if self.selectedOption > #self.menuOptions then
        self.selectedOption = 1
    end
end

function Pause:deselectOption()
    self.selectedOption = self.selectedOption - 1
    if self.selectedOption < 1 then
        self.selectedOption = #self.menuOptions
    end
end

function Pause:confirmOption()
    if self.selectedOption == 1 then
        self:close()
    elseif self.selectedOption == 2 then
        -- open options menu
    elseif self.selectedOption == 3 then
        love.event.quit()
    end
end

function Pause:update(dt)
    if self.paused then
        if G.INPUT:inputPressed("up") then
            self:deselectOption()
        elseif G.INPUT:inputPressed("down") then
            self:selectOption()
        elseif G.INPUT:inputPressed("confirm") then
            self:confirmOption()
        end
    end
    G.INPUT:update(dt)
end

function Pause:draw()
    love.graphics.setFont(G.fonts.temp3)
    if self.paused then
        love.graphics.setColor(0, 0, 0, 0.7 * --[[self.alpha]] 1)
        love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, self.alpha)
        love.graphics.printf('PAUSE', 0,100, love.graphics.getWidth(), 'center')

        for i, option in ipairs(self.menuOptions) do
            if i == self.selectedOption then
                love.graphics.setColor(1, 1, 1)
            else
                love.graphics.setColor(0.5, 0.5, 0.5)
            end
            love.graphics.printf(option, 0, 200 + (i - 1) * 50, love.graphics.getWidth(), 'center')
        end
    end
end

