-- keep files at powers of 2
-- keep files at 2048 pixels max for maximum compatibility

Animation = Object:extend()

function Animation:new(spriteSheet, frameWidth, frameHeight, animationInfo)
    self.spriteSheet = spriteSheet
    self.spritesheetWidth, self.spritesheetHeight = self.spriteSheet:getWidth(), self.spriteSheet:getHeight()
    self.frameWidth, self.frameHeight = frameWidth, frameHeight
    self.playing = true
    self.elapsedTime = 0
    
    -- Generate the frames (newQuads) based on spriteSheet dimensions and frame size
    self:setFrames(animationInfo)

    self.currentFrame = 1
    self.activeFrame = self.frames[self.currentFrame]

    -- self.frames = {}
    -- for __, info in ipairs(frameInfo) do
    --     local x, y = info[2], info[3]
    --     local quad = love.graphics.newQuad(x, y, self.frameWidth, self.frameHeight, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
    --     table.insert(self.frames, quad)
    -- end

    -- self.state = animationInfo['state'] or ''
end

function Animation:setFrames(animationInfo)
    self.frameCount = animationInfo['frameCount'] or 1
    self.frameDuration = animationInfo['frameDuration'] or 0.1
    self.loop = animationInfo['loop'] or true

    -- Regenerate the frames
    self.frames = {}
    for i = 1, self.frameCount do
        local x = (i - 1) * self.frameWidth
        local y = (animationInfo['row'] - 1) * self.frameHeight
        local quad = love.graphics.newQuad(x, y, self.frameWidth, self.frameHeight, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
        table.insert(self.frames, quad)
    end

    -- Reset the animation
    self:reset()
end

function Animation:update(dt)
    if not self.playing then return end
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

function Animation:play()
    self.playing = true
end

function Animation:pause()
    self.playing = false
end

function Animation:reset()
    self.currentFrame = 1
    self.activeFrame = self.frames[self.currentFrame]
    self.elapsedTime = 0
    self.playing = true
end

return Animation