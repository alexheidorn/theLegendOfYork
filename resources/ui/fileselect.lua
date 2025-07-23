FileSelectMenu = Object:extend()

--[[
    FileSelectMenu Class
    Displays available save slots, allows selection, and triggers save/load actions.
    Can be used for both saving and loading.
--]]

function FileSelectMenu:new(mode)
    self.mode = mode or "load" -- "save" or "load"
    self.selectedSlot = 1
    self.maxSlots = 3
    self.slotInfo = {}
    self:refreshSlots()
end

function FileSelectMenu:refreshSlots()
    self.slotInfo = {}
    for i = 1, self.maxSlots do
        local info = { name = "Empty", date = "-", time = "-" }
        local file = "save" .. i .. ".json"
        if love.filesystem.getInfo(file) then
            local contents = love.filesystem.read(file)
            local data, pos, err = require("lib/dkjson").decode(contents)
            if not err and data then
                info.name = data.playerName or "Player"
                info.date = data.saveDate or "-"
                info.time = data.saveTime or "-"
            end
        end
        table.insert(self.slotInfo, info)
    end
end

function FileSelectMenu:selectNext()
    self.selectedSlot = self.selectedSlot % self.maxSlots + 1
end

function FileSelectMenu:selectPrev()
    self.selectedSlot = (self.selectedSlot - 2) % self.maxSlots + 1
end

function FileSelectMenu:confirm()
    if self.mode == "save" then
        G.DATA:createNewFile(self.selectedSlot)
        self:refreshSlots()
        G.GAME_STATE = self.returnState or G.GAME_STATES.gameplay
    elseif self.mode == "load" then
        local slotInfo = self.slotInfo[self.selectedSlot]
        -- If accessed from title screen and slot is empty, create new file and start game
        if self.returnState == G.GAME_STATES.title_screen and (not slotInfo or slotInfo.name == "Empty") then
            G.DATA:createNewFile(self.selectedSlot)
            self:refreshSlots()
            G.GAME_STATE = G.GAME_STATES.gameplay
        else
            local loaded = G.DATA:load(self.selectedSlot)
            if loaded then
                if self.returnState == G.GAME_STATES.title_screen then
                    G.GAME_STATE = G.GAME_STATES.gameplay
                else
                    G.GAME_STATE = self.returnState or G.GAME_STATES.gameplay
                end
            end
        end
    end
end

function FileSelectMenu:update(dt)
    if G.INPUT:inputPressed("up") then
        self:selectPrev()
    elseif G.INPUT:inputPressed("down") then
        self:selectNext()
    elseif G.INPUT:inputPressed("confirm") then
        self:confirm()
    elseif G.INPUT:inputPressed("cancel") then
        G.GAME_STATE = self.returnState or G.GAME_STATES.title_screen
    end
    G.INPUT:update(dt)
end

function FileSelectMenu:draw()
    if G.GAME_STATE ~= G.GAME_STATES.file_select then return end
    love.graphics.setFont(G.fonts.temp2)
    love.graphics.setColor(1, 1, 1, 1)
    love.graphics.printf((self.mode == "save" and "Select Slot to Save" or "Select Slot to Load"), 0, love.graphics.getHeight()/2 - 60 * G.scale, love.graphics.getWidth(), "center")
    for i, info in ipairs(self.slotInfo) do
        if i == self.selectedSlot then
            love.graphics.setColor(1, 1, 1)
        else
            love.graphics.setColor(0.5, 0.5, 0.5)
        end
        local text = string.format("Slot %d: %s | %s %s", i, info.name, info.date, info.time)
        love.graphics.printf(text, 0, love.graphics.getHeight()/2 - 20 * G.scale + (i-1)*30, love.graphics.getWidth(), "center")
    end
end
