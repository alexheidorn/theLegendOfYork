TitleScreen = Object:extend()

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
    self.options = {
        "Start Game",
        "View Map",
        "View Commands",
        "Exit :("
    }
    self.selectedOption = 1
end

function TitleScreen:update(dt) 
    if G.INPUT:inputPressed("confirm") then
        G.GAME_STATE = G.GAME_STATES.gameplay
    end
    -- fade out
end

    function TitleScreen:draw()
    if G.GAME_STATE == G.GAME_STATES.title_screen then
        -- intro text after selecting 'start'
        local fontSize = 20*G.scale
        local tempFont = love.graphics.newFont(fontSize)
        love.graphics.setFont(tempFont)
        love.graphics.setColor(1, 1, 1, 1)
        -- love.graphics.setFont(G.fonts.title)

        love.graphics.printf(self.text[1], 0, love.graphics.getHeight()/2 - 50*G.scale, love.graphics.getWidth(), "center")
        love.graphics.printf(self.text[2], 0, love.graphics.getHeight()/2 - 4*G.scale, love.graphics.getWidth(), "center")
        love.graphics.printf(self.text[3], 0, love.graphics.getHeight()/2 - 30*G.scale, love.graphics.getWidth(), "center")
    end
end 