local tileTable, tileset, tileWidth, tileHeight, quads, quad

function LoadMap(path)
    love.filesystem.newFile(path) ()
end

function CreateMap(tileW, tileH, tileSetPath, quadInfo, tileString)
    tileWidth = tileW
    tileHeight = tileH
    local sheetWidth, sheetHeight = tileset:getWidth(), tileset:getHeight()
    
    quads = {}
    for i = 1, #quadInfo do
      quads[i] = love.graphics.newQuad(quadInfo[i][1], quadInfo[i][2], quadInfo[i][3], quadInfo[i][4], tileset:getWidth(), tileset:getHeight())
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
          local number = row[columnIndex]
          local quad = quads[number]
          local x, y = (columnIndex - 1) * tileWidth, (rowIndex - 1) * tileHeight
          love.graphics.draw(tileset, quad, x, y)
        end
    end
end