Enemy = Entity:extend()

function Enemy:new(x, y, name)
    Enemy.super.new(self, x, y, name)

    self.state = "patrolling"
    
    self.direction = 1 -- 1 = right, -1 = left
    self.timer = 0
end

function Enemy:collidesWithPlayer()
    local playerHitbox = G.PLAYER.hitbox
    return self:collides(playerHitbox)
end

function Enemy:update(dt)
    local nextX = self.hitbox.x + self.direction * self.speed * dt
    if G.MAP:collides(nextX, self.hitbox.y, self.hitbox.width, self.hitbox.height) then
        -- change direction when colliding with a wall
        self.direction = -self.direction
        self.timer = 0
    end

    -- check for collision with player
    if self:collidesWithPlayer() then
        -- handle collision with player (e.g., start battle)
        -- G.BATTLE:enterBattle()       
        self.direction = -self.direction -- reverse direction on collision
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