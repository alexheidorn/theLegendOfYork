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
    -- self.sprite = G.atlas.player
    Player.super.new(self, x, y, 'player')
    self.health = 100
    self.maxHealth = 100
    self.speed = 100
end

function Player:move(moveX, moveY, dt)
    if self.stunTimer > 0 then 
        self.animation:pause()
        return -- Prevent movement while stunned
    end

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

function Player:collidesWithEnemy()
    -- Check for collision with enemies specifically
    if self.stunTimer > 0 then return end -- Prevent collision checks while stunned
    if not G.ENEMIES then return end -- No enemies to check against
    
    for _, entity in ipairs(G.ENEMIES) do
        if entity:collides(self.hitbox) then
            self.stunTimer = 0.5 -- stun for 0.5 seconds
            self:setState('stun')

            -- Knockback effect
            local knockbackX = (self.hitbox.x - entity.hitbox.x) * 0.5
            local knockbackY = (self.hitbox.y - entity.hitbox.y) * 0.5
            -- Normalize the knockback vector
            local magnitude = math.sqrt(knockbackX * knockbackX + knockbackY * knockbackY)
            if magnitude > 0 and self.stunTimer == 0 then
                knockbackX = knockbackX / magnitude * 10
                knockbackY = knockbackY / magnitude * 10
            end

            -- Apply knockback to the player
            self.hitbox.x = self.hitbox.x + knockbackX
            self.hitbox.y = self.hitbox.y + knockbackY

            -- Play hit sound
            -- G.AUDIO:playSound("hit_sound")

            return true
        end
    end
    return false
end

function Player:update(dt)
    local moveX, moveY = 0, 0
    -- check for movement input
    if G.INPUT:handleInput("left") then moveX = moveX - 1 end
    if G.INPUT:handleInput("right") then moveX = moveX + 1 end
    if G.INPUT:handleInput("up") then moveY = moveY - 1 end
    if G.INPUT:handleInput("down") then moveY = moveY + 1 end
    if G.INPUT:handleInput("attack") then self:attack() end
    if G.INPUT:handleInput("interact") then self:interact() end

    -- normalize diagonal movement
    if moveX ~= 0 and moveY ~= 0 then
        local length = math.sqrt(moveX * moveX + moveY * moveY)
        moveX, moveY = moveX / length, moveY / length
    end

    self:collidesWithEnemy()
    -- apply movement
    self:move(moveX, moveY, dt)

    Player.super.update(self, dt)
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