TitleScreen = Object:extend()
 --[[
        TitleScreen Class
        This class handles the title screen functionality in the game.
        It displays the title, options, and handles user input for navigation.
    --]]

function TitleScreen:new()
    self.text = {
                     "Welcome to", 
    "~*~*~*~*~*~*~*~*The Legend of York™*~*~*~*~*~*~*~",
    [[
    You take on the role of John Hero, the CEO
    of the heroes' guild York Industries. Your 
    Your quest is to become the greatest hero of 
    all time. You have been hired to enter a secret
    lab to find the legendary battle axe of York 
    and take out the vile troll Gretchen!
    ~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~*~
    ]]
}
    self.menuOptions = {
        "Start Game",
        "View Map",
        "View Commands",
        "Exit :("
    }
    self.cursor = nil --love.graphics.newImage("assets/sprites/cursor.png")
    self.cursorScale = 0.5
    self.selectedOption = 1
end

function TitleScreen:selectOption()
    if self.selectedOption < #self.menuOptions then
        self.selectedOption = self.selectedOption + 1
    else
        self.selectedOption = 1
    end
end

function TitleScreen:deselectOption()
    if self.selectedOption > 1 then
        self.selectedOption = self.selectedOption - 1
    else
        self.selectedOption = #self.menuOptions
    end
end

function TitleScreen:confirmOption()
    if self.selectedOption == 1 then
        G.GAME_STATE = G.GAME_STATES.gameplay
    elseif self.selectedOption == 2 then
        G.GAME_STATE = G.GAME_STATES.map
    elseif self.selectedOption == 3 then
        G.GAME_STATE = G.GAME_STATES.commands
    elseif self.selectedOption == 4 then
        love.event.quit()
         -- fade out
    end
end

function TitleScreen:update(dt) 
    if G.INPUT:inputPressed("up") then
        self:deselectOption()
    elseif G.INPUT:inputPressed("down") then
        self:selectOption()
    elseif G.INPUT:inputPressed("confirm") then
        self:confirmOption()
    elseif G.INPUT:inputPressed("select") then
        if G.fullscreen then
            local newWidth = 1920
            local newHeight = 1080
            local fractionW = love.graphics.getWidth()*0.9
            local fractionH = love.graphics.getHeight()*0.9
            if fractionW < newWidth then
                newWidth = fractionW
            end
            if fractionH < newHeight then
                newHeight = fractionH
            end

            G:setWindowSize(false, newWidth, newHeight)
        else
            G:setWindowSize(true)
        end
        G:reinitSize()
    end

   G.INPUT:update(dt)
end

    function TitleScreen:draw()
    if G.GAME_STATE == G.GAME_STATES.title_screen then
        -- intro text after selecting 'start'
        love.graphics.setFont(G.fonts.temp)
        love.graphics.setColor(1, 1, 1, 1)
        -- love.graphics.setFont(G.fonts.title)

        love.graphics.printf(self.text[1], 0, love.graphics.getHeight()/2 - 50 * G.scale, love.graphics.getWidth(), "center")
        love.graphics.printf(self.text[2], 0, love.graphics.getHeight()/2 - 40 * G.scale, love.graphics.getWidth(), "center")
        love.graphics.printf(self.text[3], 0, love.graphics.getHeight()/2 - 30 * G.scale, love.graphics.getWidth(), "center")


        love.graphics.setFont(G.fonts.temp)
        for i, option in ipairs(self.menuOptions) do
            if i == self.selectedOption then
                love.graphics.setColor(1, 1, 1)
            else
                love.graphics.setColor(0.5, 0.5, 0.5)
            end
            love.graphics.printf(option, 0, love.graphics.getHeight()/2 + 100 + (i - 1) * 10 * G.scale, love.graphics.getWidth(), 'center')
        end
    end
end 