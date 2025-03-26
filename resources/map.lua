Map = Object:extend()

function Map:new(tileSize,  tileSetPath, quadData, mapData, solidTiles)
    self.tileset = love.graphics.newImage(tileSetPath)
    self.tilesetWidth, self.tilesetHeight = self.tileset:getWidth(), self.tileset:getHeight()
    self.width = 0
    self.height = 0
    self.tileSize = tileSize
    self.solidTiles = solidTiles

    self.showCollisionBoxes = true
    

    self.quads = {}
    for _, info in ipairs(quadData) do
        -- info[1] = char, info[2] = x, info[3] = y
        self.quads[info[1]] = love.graphics.newQuad(info[2], info[3], self.tileSize, self.tileSize, self.tilesetWidth, self.tilesetHeight)
    end

    self.tileTable = {}
    for line in mapData:gmatch("[^\n]+") do
        local row = {}
        for char in line:gmatch(".") do
            row[#row + 1] = char
        end
        if #line - 1 > self.width then
            self.width = #line - 1
        end
        table.insert(self.tileTable, row)
    end

    self.height = #self.tileTable
end

function Map:update()
    
end

function Map:draw()
    for row = 1, #self.tileTable do
        for col = 1, #self.tileTable[row] - 1 do
            local char = self.tileTable[row][col]
            local quad = self.quads[char] or self.quads[' ']
            if quad then
                love.graphics.draw(self.tileset, quad, (col - 1) * self.tileSize, (row - 1) * self.tileSize)
            end

            if self.showCollisionBoxes and self.solidTiles[char] then
                love.graphics.setColor(255, 0, 0, 128) -- Red with 50% transparency
                love.graphics.rectangle(
                    "line", 
                    (col - 1) * self.tileSize,
                    (row - 1) * self.tileSize,
                    self.tileSize,
                    self.tileSize
                    -- 8, 8 -- Rounded corners with radius 8 
                ) 
                love.graphics.setColor(255, 255, 255, 255) -- Reset color
            end
        end
    end
end

function Map:collides(x, y, width, height)
    return self:_collides(x, y) or self:_collides(x + width, y) or self:_collides(x, y + height) or self:_collides(x + width, y + height)
end



function Map:_collides(x, y)
    -- check for collisions with solid tiles
    local col = math.floor(x / self.tileSize) + 1
    local row = math.floor(y / self.tileSize) + 1


    if col < 1 or col > #self.tileTable[row] or row < 1 or row > #self.tileTable then
        return true
    end
    local tile = self.tileTable[row][col]
    return self.solidTiles[tile]
end