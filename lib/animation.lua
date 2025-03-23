-- keep files at powers of 2
-- keep files at 2048 pixels max for maximum compatibility

Animation = Object:extend()

function Animation:new(spriteSheet, frameWidth, frameHeight, frameInfo, frameCount, frameDuration)
    self.spriteSheet = spriteSheet
    self.spritesheetWidth, self.spritesheetHeight = self.spriteSheet:getWidth(), self.spriteSheet:getHeight()
    self.frameWidth, self.frameHeight = frameWidth, frameHeight

    -- -- Generate the frames (newQuads) based on spriteSheet dimensions and frame size
    -- self.frames = {}
    -- for i = 1, self.frameCount do
    --     local x = (i - 1) * self.frameWidth
    --     local y = 0
    --     local quad = love.graphics.newQuad(x, y, self.frameWidth, self.frameHeight, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
    --     table.insert(self.frames, quad)
    -- end

    self.frames = {}
    for __, info in ipairs(frameInfo) do
        local x, y = info[2], info[3]
        local quad = love.graphics.newQuad(x, y, self.frameWidth, self.frameHeight, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
        table.insert(self.frames, quad)
    end

    self.frameDuration = frameDuration or 0.1 -- default to 0.1s per frame
    self.frameCount = frameCount or #frameInfo or #self.frames
    self.currentFrame = 1
    self.activeFrame = self.frames[self.currentFrame]
    self.elapsedTime = 0
    self.loop = true
end

function Animation:update(dt)
    self.elapsedTime = self.elapsedTime + dt
    if self.elapsedTime > self.frameDuration then
        self.currentFrame = self.currentFrame + 1
        if self.currentFrame > #self.frames then
            if self.loop then self.currentFrame = 1 
            else self.currentFrame = #self.frames end -- stop on last frame if not looping
        end
        self.activeFrame = self.frames[self.currentFrame]
        self.elapsedTime = 0
    end
end

function Animation:draw(x, y)
    love.graphics.draw(self.spriteSheet, self.activeFrame, x, y)
end

return Animation