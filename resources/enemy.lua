Enemy = Entity:extend()

function Enemy:new(x, y)
    self.spriteSheetPath = "assets/Zelda-like/log.png"
    Enemy.super.new(self, x, y, self.spriteSheetPath, 32, 32, 4)

    self.state = "patrolling"
    self.direction = 1 -- 1 = right, -1 = left
    self.timer = 0
end

function Enemy:update(dt)
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

    -- change direction when colliding with a wall
    if G.map:collides(self.x, self.y, self.width, self.height) then
        self.direction = -self.direction
    end

    --update animation
    Enemy.super.update(self, dt)
end