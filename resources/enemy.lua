Enemy = Entity:extend()

function Enemy:new(x, y)
    self.spriteSheetPath = "assets/spritesheets/funny-pixelated-character/preview.jpg"
    Enemy.super.new(self, x, y, self.spriteSheetPath, 172, 332, 4)

    self.state = "patrolling"
    self.direction = 1 -- 1 = right, -1 = left
end

function Enemy:update(dt)
    -- simple AI movement: move back & forth
    self:move(self.direction, 0, dt)

    -- flip sprite if moving left
    if self.direction < 0 then
        self.spriteSheet:setFlip(true, false)
    else
        self.spriteSheet:setFlip(false, false)
    end

    -- change direction every 2 seconds
    if math.floor(love.timer.getTime()) % 4 == 0 then
        self.direction = -self.direction
    end

    --update animation
    Enemy.super.update(self, dt)
end