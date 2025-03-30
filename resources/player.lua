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
    local moveX, moveY = 0, 0
    -- check for movement input
    if G.INPUT:handleInput("left") then moveX = moveX - 1 end
    if G.INPUT:handleInput("right") then moveX = moveX + 1 end
    if G.INPUT:handleInput("up") then moveY = moveY - 1 end
    if G.INPUT:handleInput("down") then moveY = moveY + 1 end
    

    -- normalize diagonal movement
    if moveX ~= 0 and moveY ~= 0 then
        local length = math.sqrt(moveX * moveX + moveY * moveY)
        moveX, moveY = moveX / length, moveY / length
    end

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