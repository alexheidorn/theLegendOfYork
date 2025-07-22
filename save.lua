json = require "lib/dkjson"
Data = Object:extend()

function Data:new()
    self.fileNumber = 0
    self.playerName = "Player"
    self.playTime = 0

    self.timeStamp = nil -- store the timestamp of when the save was created
    self.saveDate = nil -- store the date of when the save was created
    self.saveTime = nil -- store the time of when the save was created

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
    self.timeStamp = os.time() -- update the timestamp when saving
    self.saveDate = os.date("%Y-%m-%d", self.timeStamp)
    self.saveTime = os.date("%H:%M:%S", self.timeStamp)

    -- Save player info
    if G and G.PLAYER then
        self.player = {
            x = G.PLAYER.x,
            y = G.PLAYER.y,
            hp = G.PLAYER.hp,
            name = G.PLAYER.name,
            -- add other relevant player fields here
        }
    end

    -- Save enemies info
    self.enemies = {}
    if G and G.ENEMIES then
        for _, enemy in ipairs(G.ENEMIES) do
            table.insert(self.enemies, {
                x = enemy.x,
                y = enemy.y,
                type = enemy.type,
                hp = enemy.hp,
                -- add other relevant enemy fields here
            })
        end
    end

    -- Save map info
    if G and G.MAP then
        self.map = {
            name = G.MAP.name,
            -- add other relevant map fields here
        }
    end

    local encoded = json.encode(self, { indent = true })

    -- save the game data to a file
    local success, message = love.filesystem.write("save" .. self.fileNumber .. ".json", encoded)
    if success then
        print("Game data saved to save" .. self.fileNumber .. ".json")
    else
        print("Error saving game data: " .. message)
    end
end

function Data:loadPlayerData()
    if not G.PLAYER then return end
    G.PLAYER.x = self.player.x or 0
    G.PLAYER.y = self.player.y or 0
    G.PLAYER.hp = self.player.hp or 100
    G.PLAYER.name = self.player.name or "Player"
    -- Load other player fields as necessary
end

function Data:loadEnemiesData()
    if not G.ENEMIES then return end
    for i, enemyData in ipairs(self.enemies) do
        if G.ENEMIES[i] then
            G.ENEMIES[i].x = enemyData.x or 0
            G.ENEMIES[i].y = enemyData.y or 0
            G.ENEMIES[i].type = enemyData.type or "default"
            G.ENEMIES[i].hp = enemyData.hp or 100
            -- Load other enemy fields as necessary
        end
    end
end

function Data:loadMapData()
    if not G.MAP then return end
    G.MAP.name = self.map.name or "default_map"
    -- Load other map fields as necessary
end

function Data:load(fileNumber)
    if fileNumber then self.fileNumber = fileNumber end
    if self.fileNumber == 0 then
        print("No save file number specified, cannot load.")
        return nil
    end
    local file = "save" .. self.fileNumber .. ".json"
    
    if love.filesystem.getInfo(file) then
        local contents = love.filesystem.read(file)
        local data, pos, err = json.decode(contents) -- decode the JSON data
        if err then
            print("Error loading game data: " .. err)
            return nil
        end
        
        for key, value in pairs(data) do
            self[key] = value
        end
        -- Load player, enemies, and map data
        self:loadPlayerData()
        self:loadEnemiesData()
        self:loadMapData()

        print("Game data loaded from " .. file)

        return data
    else
        print("No save file found at " .. file)
        return nil -- return nil if the file does not exist
    end
end

function Data:delete(fileNumber)
    local file = "save" .. (fileNumber or self.fileNumber) .. ".json"
    if love.filesystem.getInfo(file) then
        love.filesystem.remove(file)
        print("Save file " .. file .. " deleted.")
    else
        print("Cannot delete save file " .. file .. ": it does not exist.")
    end
end

function Data:getTimestamp(fileNumber)
    local file = "save" .. (fileNumber or 1) .. ".json"
    if love.filesystem.getInfo(file) then
        local contents = love.filesystem.read(file)
        local data, pos, err = json.decode(contents)
        if err then
            print("Error loading game data: " .. err)
            return nil
        end

        if data and data.timeStamp then
            return os.date("%Y-%m-%d %H:%M:%S", data.timeStamp)
        else
            print("No timestamp found in save file.")
            return nil
        end
    else
        print("Save file does not exist.")
        return nil
    end
end