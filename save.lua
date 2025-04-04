Data = Object:extend()
local json = require "lib/dkjson"

function Data:new()
    self.data = {
        fileNumber = 0,
        playerName = "Player",
        playTime = 0,
        saveDate = os.date("%Y-%m-%d"),
        saveTime = os.date("%H:%M:%S"),

        player = {},
        enemies = {},
        map = {},
    }
end

function Data:encode()
    return json.encode(self.data, { indent = true})
end

function Data:createNewFile(fileNumber)
    if fileNumber == 0 then fileNumber = 1 end
    self.fileNumber = fileNumber

    self:save()
end

function Data:save()
    self.data.player = G.PLAYER
    self.data.enemies = G.ENEMIES
    self.datamap = G.MAP

    -- save the game data to a file
    local success, message = love.filesystem.write("save" .. self.data.fileNumber .. ".txt", Data:encode())
    if success then
        print("Game data saved to save" .. self.data.fileNumber .. ".txt")
    else
        print("Error saving game data: " .. message)
    end
end

function Data:load()
    -- load the game data from a file
    local data = love.filesystem.read("save" .. self.fileNumber .. ".txt")
    return love.data.unpack(data)
end

function Data:delete()
    -- delete the game data from a file
end