Data = Object:extend()

function Data:new()
    self.fileNumber = 0
    self.playerName = "Player"
    self.playTime = 0
    self.saveDate = os.date("%Y-%m-%d")
    self.saveTime = os.date("%H:%M:%S")

    self.player = {}
    self.enemies = {}
    self.map = {}
end

function Data:createNewFile(fileNumber)
    if fileNumber == 0 then fileNumber = 1 end
    self.fileNumber = fileNumber

    self:save()
end

function Data:save()
    self.player = G.PLAYER
    self.enemies = G.ENEMIES
    self.map = G.MAP

    -- save the game data to a file
    local success, message = love.filesystem.write("save" .. self.fileNumber .. ".txt", love.data.serialize(self))
    if success then
        print("Game data saved to save" .. self.fileNumber .. ".txt")
    else
        print("Error saving game data: " .. message)
    end
end

function Data:load()
    -- load the game data from a file
    local data = love.filesystem.read("save" .. self.fileNumber .. ".txt")
    return love.data.deserialize(data)
end

function Data:delete()
    -- delete the game data from a file
end