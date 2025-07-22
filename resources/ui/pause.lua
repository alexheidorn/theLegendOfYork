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
        "Save",
        "Load",
        "Save & Quit",
        "Return to Title Screen",
        "Quit without Saving"
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
        -- save
        G.FILE_SELECT_MENU = FileSelectMenu("save")
        G.FILE_SELECT_MENU.returnState = G.GAME_STATES.paused
        G.GAME_STATE = G.GAME_STATES.file_select
    -- If accessed from gameplay and slot is empty, create new file and start game
    elseif self.selectedOption == 4 then
        -- load
        G.FILE_SELECT_MENU = FileSelectMenu("load")
        G.FILE_SELECT_MENU.returnState = G.GAME_STATES.paused
        G.GAME_STATE = G.GAME_STATES.file_select
    elseif self.selectedOption == 5 then
        -- save and quit
        self:close()
        G.DATA:save()
        G.GAME_STATE = G.GAME_STATES.title_screen 
        -- G.TITLE_SCREEN:open()
    elseif self.selectedOption == 6 then
        -- return to title screen
        G.GAME_STATE = G.GAME_STATES.title_screen
        -- G.TITLE_SCREEN:open()
    elseif self.selectedOption == 7 then
        -- quit
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
        love.graphics.printf('PAUSE', 0, love.graphics.getHeight() / 2 - 20 * G.scale, love.graphics.getWidth(), 'center')
        
        love.graphics.setFont(G.fonts.temp2)
        for i, option in ipairs(self.menuOptions) do
            if i == self.selectedOption then
                love.graphics.setColor(1, 1, 1)
            else
                love.graphics.setColor(0.5, 0.5, 0.5)
            end
            love.graphics.printf(option, 0, love.graphics.getHeight() / 2 + (i - 1) * 10 * G.scale, love.graphics.getWidth(), 'center')
        end
    end
end

