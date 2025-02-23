local tileTable, tileset, tileWidth, tileHeight, quads, quad

function LoadMap(path)
    love.filesystem.load(path) ()
end

function CreateMap(tileW, tileH, tileSetPath, quadInfo, tileString)
    tileset = love.graphics.newImage(tileSetPath)
    tileWidth = tileW
    tileHeight = tileH
    local sheetWidth, sheetHeight = tileset:getWidth(), tileset:getHeight()
    
    quads = {}
    for _, info in ipairs(quadInfo) do
      -- info[1] = char, info[2] = x, info[3] = y
      quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileWidth, tileHeight, sheetWidth, sheetHeight)
    end


    tileTable = {}

    for line in tileString:gmatch("[^\n]+") do
        local row = {}
        for char in line:gmatch(".") do
          row[#row + 1] = char
        end
        tileTable[#tileTable + 1] = row
      end

end

function DrawMap()
    for rowIndex = 1, #tileTable do
        local row = tileTable[rowIndex]
        for columnIndex = 1, #row do
          local char = row[columnIndex]
          local quad = quads[char]
          local x, y = (columnIndex - 1) * tileWidth, (rowIndex - 1) * tileHeight
          love.graphics.draw(tileset, quad, x, y)
        end
    end
end