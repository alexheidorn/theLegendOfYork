Pause = Object:extend()

function Pause:new()
    self.paused = false
    self.alpha = 0
    self.menuOptions = {
        "Resume",
        "Options",
        "Quit"
    }
    self.selectedOption = 1
end

function Pause:toggle()
    self.paused = not self.paused
end

function Pause:update(dt)
    if self.paused then
        love.event.quit()
    end
end

function Pause:draw()
    if self.paused then
        love.graphics.setColor(0, 0, 0, 0.5)
        love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.printf('PAUSE', 0, 0, love.graphics.getWidth(), 'center')
    end
end