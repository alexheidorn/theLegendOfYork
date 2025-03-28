Enemy = Entity:extend()

function Enemy:new(x, y)
    self.spriteSheetPath = "assets/Zelda-like/log.png"
    self.animations = {
        idle = { row = 1, frameCount = 4, loop = true, frameDuration = 0.5, pixelWidth = 32, pixelHeight = 32 },
        patrolling = { row = 1, frameCount = 4, loop = true, pixelWidth = 32, pixelHeight = 32 },
    }
    Enemy.super.new(self, x, y, self.spriteSheetPath, 32, 32, self.animations)

    self.state = "patrolling"
    
    self.direction = 1 -- 1 = right, -1 = left
    self.timer = 0
end

function Enemy:update(dt)
    local nextX = self.hitbox.x + self.direction * self.speed * dt
    if G.map:collides(nextX, self.hitbox.y, self.hitbox.width, self.hitbox.height) then
        -- change direction when colliding with a wall
        self.direction = -self.direction
        self.timer = 0
    end
    -- simple AI movement: move back & forth
    self:move(self.direction, 0, dt)

    -- change direction every 2 seconds
    if self.state == "patrolling" then
        self.timer = self.timer + dt
        if self.timer > 2 then
            self.direction = -self.direction
            self.timer = 0
        end
    end
    --update animation
    Enemy.super.update(self, dt)
end