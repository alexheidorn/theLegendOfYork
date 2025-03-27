Player = Entity:extend()
-- Player = Object:extend()

-- function Player:constructor(x, y)
--     self.x = x
--     self.y = y
--     self.health = 100
--     self.maxHealth = 100
--     self.attack = 10
--     self.defense = 10
-- end

function Player:new(x, y)
    self.sprite = "assets/Zelda-like/character.png"
    self.animations = {
        -- frame info for each animation
        -- row, frame count
        idle = { row = 1, frameCount = 4, loop = true, frameDuration = 0.5 },
        down = { row = 1, frameCount = 4, loop = true },
        right = { row = 2, frameCount = 4, loop = true },
        up = { row = 3, frameCount = 4, loop = true },
        left = { row = 4, frameCount = 4, loop = true},

        -- walk
        -- attack
    }
    Player.super.new(self, x, y, self.sprite, 16, 32, self.animations)
    self.speed = 100

    self.hitbox.offsetTop = 16
end



function Player:move(moveX, moveY, dt)
    -- local moveAmount = self.speed * dt
    -- local newX = self.x + moveX * moveAmount
    -- local newY = self.y + moveY * moveAmount

    -- -- Collision detection
    -- -- if not G.Map:collides(newX, newY) then
    -- --     self.x = newX
    -- --     self.y = newY
    -- -- end
    -- -- if Map:isWalkable(newX, self.Y) then self.x = newX end
    -- -- if Map:isWalkable(self.x, newY) then self.y = newY end

    -- self.x = newX
    -- self.y = newY
    if moveX ~= 0 or moveY ~= 0 then
        -- self.state = 'walk'
        self.animation:play()
        if moveY > 0 then self:setState('down')
        elseif moveY < 0 then self:setState('up')
        elseif moveX > 0 then self:setState('right')
        elseif moveX < 0 then self:setState('left') end
    else
        self.animation:pause()
        self.animation.elapsedTime = self.animation.elapsedTime + dt
        if self.animation.elapsedTime > 0.5 then
            self.animation:play()
            self:setState('idle')
        end
    end

    Player.super.move(self, moveX, moveY, dt)
end

function Player:update(dt)
    -- Player.super.update(self, dt)
    self.animation:update(dt)
end

function Player:attack(target)
    -- Perform attack logic here
    print("Attacking " .. target.name)
end

function Player:interact()
    -- Perform interaction logic here
    print("Interacting with something")
    
end

return Player