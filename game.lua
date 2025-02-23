function Game()
end

function Game:load()
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