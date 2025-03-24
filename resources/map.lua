Map = Object:extend()

function Map:new(tileWidth, tileHeight, tileSetPath, quadInfo, tileString)
    self.tileset = love.graphics.newImage(tileSetPath)
    self.tilesetWidth, self.tilesetHeight = self.tileset:getWidth(), self.tileset:getHeight()
    self.tileWidth, self.tileHeight = tileWidth, tileHeight
    self.quads = {}
    for _, info in ipairs(quadInfo) do
        -- info[1] = char, info[2] = x, info[3] = y
        self.quads[info[1]] = love.graphics.newQuad(info[2], info[3], self.tileWidth, self.tileHeight, self.tilesetWidth, self.tilesetHeight)
    end

    self.tileTable = {}
    for line in tileString:gmatch("[^\n]+") do
        local row = {}
        for char in line:gmatch(".") do
            row[#row + 1] = char
        end
        table.insert(self.tileTable, row)
    end
end

function Map:update()
    
end

function Map:draw()
    for y = 1, #self.tileTable do
        for x = 1, #self.tileTable[y] do
            local char = self.tileTable[y][x]
            local quad = self.quads[char]
            if quad then
                love.graphics.draw(self.tileset, quad, (x - 1) * self.tileWidth, (y - 1) * self.tileHeight)
            end
        end
    end
end

function Map:collides(x, y, width, height)
    local tileX = math.floor(x / self.tileWidth) + 1
    local tileY = math.floor(y / self.tileHeight) + 1
    local tileWidth = math.ceil((x + width) / self.tileWidth) - tileX
    local tileHeight = math.ceil((y + height) / self.tileHeight) - tileY

    for ty = tileY, tileY + tileHeight - 1 do
        for tx = tileX, tileX + tileWidth - 1 do
            local tile = self.tileTable[ty] and self.tileTable[ty][tx]
            if tile then
                local quad = self.quads[tile]
                if quad then
                    return true
                end
            end
        end
    end

    return false
end